class Task {
  String taskName;
  // DateTime taskDate;
  bool completionStatus;

  Task({
    required this.taskName,
    // required this.taskDate,
    this.completionStatus = false,
  });

  void toggleDone() {
    completionStatus = !completionStatus;
  }
}
