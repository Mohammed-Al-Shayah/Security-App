class IncidentRequestModel {
  final String title;
  final int typeId;
  final int projectId;
  final String description;
  final DateTime occurredAt;

  IncidentRequestModel({
    required this.title,
    required this.typeId,
    required this.projectId,
    required this.description,
    required this.occurredAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'type_id': typeId,
      'project_id': projectId,
      'description': description,
      'occurred_at': occurredAt.toIso8601String(),
    };
  }
}
