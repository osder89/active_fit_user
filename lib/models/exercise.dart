enum ExerciseType {
  squats, // Sentadillas
  pushUps, // Flexiones
  plank, // Plancha
  lunges, // Zancadas
  burpees, // Burpees
}

class Exercise {
  final String name;
  final ExerciseType type;
  final int series;
  final int repetitionsPerSeries;

  Exercise({
    required this.name,
    required this.type,
    required this.series,
    required this.repetitionsPerSeries,
  });
}