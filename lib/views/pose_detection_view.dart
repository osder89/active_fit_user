import 'package:active_fit_user/models/exercise.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

import '../painters/pose_painter.dart';
import 'detector_view.dart';

class PoseDetectorView extends StatefulWidget {
  final String exerciseName;
  PoseDetectorView({required this.exerciseName, Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PoseDetectorViewState(this.exerciseName);
}

class _PoseDetectorViewState extends State<PoseDetectorView> {
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  PosePainter? _posePainter;
  String _exerciseName; 

 
  var _cameraLensDirection = CameraLensDirection.back;
  _PoseDetectorViewState(this._exerciseName);

  @override
  void dispose() async {
    _canProcess = false;
    _poseDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DetectorView(
      posePainter : _posePainter,
      exerciseName : _exerciseName,
      title: 'Pose Detector',
      customPaint: _customPaint,
      text: _text,
      onImage: _processImage,
      initialCameraLensDirection: _cameraLensDirection,
      onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
    );
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final poses = await _poseDetector.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {
      final painter = PosePainter(
        poses,
        inputImage.metadata!.size,
        inputImage.metadata!.rotation,
        _cameraLensDirection,
      );
      _customPaint = CustomPaint(painter: painter);
      _posePainter = painter;
    } else {
      _text = 'Poses found: ${poses.length}\n\n';
      // TODO: set _customPaint to draw landmarks on top of image
      _customPaint = null;
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}

ExerciseType getExerciseTypeByName(String exerciseName) {
  switch (exerciseName.toLowerCase()) {
    case 'sentadillas':
      return ExerciseType.squats;
    case 'flexiones':
      return ExerciseType.pushUps;
    case 'plancha':
      return ExerciseType.plank;
    case 'zancadas':
      return ExerciseType.lunges;
    case 'burpees':
      return ExerciseType.burpees;
    default:
      throw Exception('Ejercicio no reconocido: $exerciseName');
  }
}