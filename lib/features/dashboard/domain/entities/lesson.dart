class Lesson {
  final String id;
  final String title;
  final int durationMinutes;
  final bool isCompleted;
  final bool isLocked;
  final int order;

  Lesson({
    required this.id,
    required this.title,
    required this.durationMinutes,
    this.isCompleted = false,
    this.isLocked = false,
    required this.order,
  });
}

