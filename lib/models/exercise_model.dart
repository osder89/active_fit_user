import 'package:active_fit_user/models/exercise.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ExerciseState {
  neutral,
  init,
  complete,
}

class ExerciseCounter extends Cubit<ExerciseState> {
  ExerciseCounter() : super(ExerciseState.neutral);
  int seriesCounter = 0;
  int repetitionCounter = 0;
  Exercise? currentExercise;

  void setExerciseState(ExerciseState current) {
    emit(current);
  }

  void startExercise(Exercise exercise) {
    currentExercise = exercise;
    seriesCounter = 0;
    repetitionCounter = 0;
    emit(ExerciseState.init);
  }

  void incrementSeries() {
    seriesCounter++;
    repetitionCounter = 0;
    emit(state);
  }

  void incrementRepetition() {
  repetitionCounter++;
  if (currentExercise != null && repetitionCounter == currentExercise!.repetitionsPerSeries) {
    repetitionCounter = 0; // Reiniciar el contador de repeticiones
    incrementSeries(); // Llamar al método para incrementar la serie
  } else {
    emit(state); // Emitir el estado actualizado si no se cumplen las condiciones anteriores
  }
}



  void resetExercise() {
    seriesCounter = 0;
    repetitionCounter = 0;
    currentExercise = null;
    emit(ExerciseState.neutral);
  }

  void startExerciseByType(ExerciseType type) {
    switch (type) {
      case ExerciseType.squats:
        startExercise(Exercise(
          name: 'squat',
          type: ExerciseType.squats,
          series: 3,
          repetitionsPerSeries: 12,
        ));
        break;
      case ExerciseType.pushUps:
        startExercise(Exercise(
          name: 'pushUp',
          type: ExerciseType.pushUps,
          series: 3,
          repetitionsPerSeries: 13,
        ));
        break;
      case ExerciseType.plank:
        startExercise(Exercise(
          name: 'plank',
          type: ExerciseType.plank,
          series: 3,
          repetitionsPerSeries: 60,
        ));
        break;
      case ExerciseType.lunges:
        startExercise(Exercise(
          name: 'lunges',
          type: ExerciseType.lunges,
          series: 3,
          repetitionsPerSeries: 12,
        ));
        break;
      case ExerciseType.burpees:
        startExercise(Exercise(
          name: 'burpees',
          type: ExerciseType.burpees,
          series: 3,
          repetitionsPerSeries: 10,
        ));
        break;
    }
  }
  void checkSeriesAndRepetitions() {
    if (currentExercise != null &&
        seriesCounter == currentExercise!.series) {
      emit(ExerciseState.complete);
    } else if (repetitionCounter == currentExercise!.repetitionsPerSeries) {
      repetitionCounter = 0;
      emit(state); 
    }
  } 
  void resetRepetitionCounter() {
  repetitionCounter = 0;
  emit(state); 
}

}
