import 'dart:io';
import 'dart:math' as math;

import 'package:active_fit_user/models/exercise_model.dart';
import 'package:active_fit_user/models/push_up_model.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

Future<String> getAssetPath(String asset) async {
  final path = await getLocalPath(asset);
  await Directory(dirname(path)).create(recursive: true);
  final file = File(path);
  if (!await file.exists()) {
    final byteData = await rootBundle.load(asset);
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
  return file.path;
}

Future<String> getLocalPath(String path) async {
  return '${(await getApplicationSupportDirectory()).path}/$path';
}

double angle(
  PoseLandmark firstLandmark,
  PoseLandmark midLandmark,
  PoseLandmark lastLandmark,
) {
  final radians = math.atan2(
          lastLandmark.y - midLandmark.y, lastLandmark.x - midLandmark.x) -
      math.atan2(
          firstLandmark.y - midLandmark.y, firstLandmark.x - midLandmark.x);
  double degrees = radians * 180.0 / math.pi;
  degrees = degrees.abs();
  if (degrees > 180.0) {
    degrees = 360.0 - degrees;
  }
  return degrees;
}

/*PushUpState? isPushUp(double angleElbow, PushUpState current) {
  final umbralElbow = 60.0;
  final umbralElbowExt = 160.0;
  if (current == PushUpState.neutral &&
      angleElbow > umbralElbowExt &&
      angleElbow < 180.0) {
    return PushUpState.init;
  } else if (current == PushUpState.init &&
      angleElbow < umbralElbow &&
      angleElbow > 40.0) {
    {
      return PushUpState.complete;
    }
  }
}*/

ExerciseState? getExerciseState(String exerciseName, double angle1,
    double? angle2, ExerciseState currentState) {
  if (exerciseName == "pushUp") {
    return isPushUpComplete(angle1, currentState);
  } else if (exerciseName == "squat") {
    return isSquat(angle1, angle2!, currentState);
  } else if (exerciseName == "plank") {
    return isPlank(angle1, currentState);
  } else if (exerciseName == "lunges") {
    return isLunges(angle1, angle2!, currentState);
  } else if (exerciseName == "burpees") {
    return isBurpees(angle1, angle2!, currentState);
  }
  return null;
}

ExerciseState? isPushUpComplete(double angle, ExerciseState currentState) {
  final umbralElbowStart = 60.0; // Umbral para iniciar el push-up
  final umbralElbowEnd = 160.0; // Umbral para finalizar el push-up
  if (currentState == ExerciseState.neutral && angle < umbralElbowStart) {
    return ExerciseState.init; // Iniciar el push-up
  } else if (currentState == ExerciseState.init && angle > umbralElbowEnd) {
    return ExerciseState.complete; // Completar el push-up
  }
  return null; // No hay cambio de estado
}

ExerciseState? isPushUp(double angleElbow, ExerciseState current) {
  final umbralElbow = 60.0;
  final umbralElbowExt = 160.0;
  if (current == PushUpState.neutral &&
      angleElbow > umbralElbowExt &&
      angleElbow < 180.0) {
    return ExerciseState.init;
  } else if (current == PushUpState.init &&
      angleElbow < umbralElbow &&
      angleElbow > 40.0) {
    {
      return ExerciseState.complete;
    }
  }
}

ExerciseState? isSquat(
    double angleKnee, double angleElbow, ExerciseState current) {
  final umbralKneeStart = 90.0; // Umbral menor para la posición de cuclillas
  final umbralKneeEnd = 160.0; // Umbral mayor para la posición recta
  final umbralElbowMid = 90.0; // Umbral aproximado para el ángulo del codo en medio

  if (angleKnee >= umbralKneeStart && angleKnee <= umbralKneeEnd &&
      angleElbow < umbralElbowMid) {
    // Está en posición de cuclillas
    return ExerciseState.init; // Iniciar la sentadilla
  }

  if (current == ExerciseState.init &&
      (angleKnee < umbralKneeStart || angleElbow > umbralElbowMid)) {
    // Ya no está en posición de cuclillas o ha extendido el codo
    return ExerciseState.complete; // Completar la sentadilla
  }

  return null; // No hay cambios de estado
}



ExerciseState? isPlank(double angleElbow, ExerciseState current) {
  final umbralElbowStart = 45.0; // Umbral para iniciar el plank
  final umbralElbowEnd = 160.0; // Umbral para finalizar el plank
  if (current == ExerciseState.neutral && angleElbow < umbralElbowStart) {
    return ExerciseState.init; // Iniciar el plank
  } else if (current == ExerciseState.init && angleElbow > umbralElbowEnd) {
    return ExerciseState.complete; // Completar el plank
  }
  return null;
}

ExerciseState? isLunges(
    double angleKneeLeft, double angleKneeRight, ExerciseState current) {
  final umbralKnee = 160.0;
  final lowerBound = 80.0;
  final upperBound = 90.0;

  // Validación para la pierna izquierda
  if (current == ExerciseState.neutral &&
      angleKneeLeft < umbralKnee &&
      angleKneeLeft >= lowerBound &&
      angleKneeLeft <= upperBound) {
    return ExerciseState.init;
  } else if (current == ExerciseState.init && angleKneeLeft > umbralKnee) {
    return ExerciseState.complete;
  }

  // Validación para la pierna derecha
  if (current == ExerciseState.neutral &&
      angleKneeRight < umbralKnee &&
      angleKneeRight >= lowerBound &&
      angleKneeRight <= upperBound) {
    return ExerciseState.init;
  } else if (current == ExerciseState.init && angleKneeRight > umbralKnee) {
    return ExerciseState.complete;
  }

  return null;
}

bool isSquatting = false;
bool isMovingUp = false;

ExerciseState? isBurpees(
    double angleKnee, double angleElbow, ExerciseState current) {
  final umbralKneeStart = 90.0;
  final umbralKneeEnd = 120.0;

  if (angleKnee >= umbralKneeStart && angleKnee <= umbralKneeEnd) {
    isSquatting = true;
  } else {
    isSquatting = false;
  }

  if (current == ExerciseState.neutral &&
      angleElbow < 100.0 &&
      isSquatting &&
      !isMovingUp) {
    isMovingUp = true;
    return ExerciseState.init;
  }

  if (current == ExerciseState.init &&
      (angleKnee < umbralKneeStart || angleElbow > 100.0)) {
    isSquatting = false;
    isMovingUp = false;
    return ExerciseState.complete;
  }

  return null;
}
