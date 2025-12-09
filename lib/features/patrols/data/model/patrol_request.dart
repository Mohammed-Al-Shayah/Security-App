class PatrolRequest {
  final int projectId;
  final int guardId;
  final int? inspectorId;
  final String date;       // "2025-11-30"
  final String startTime;  // "09:00:00"
  final String endTime;    // "10:00:00"
  final int rating;
  final String location;
  final String notes;

  PatrolRequest({
    required this.projectId,
    required this.guardId,
    this.inspectorId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.rating,
    required this.location,
    required this.notes,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'project_id': projectId,
      'guard_id': guardId,
      'inspector_id': inspectorId,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'rating': rating,
      'location': location,
      'notes': notes,
    };
  }
}
