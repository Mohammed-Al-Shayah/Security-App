import 'project.dart';

class Patrol {
  final int? id;
  final int? inspectorId;
  final int? projectId;
  final int? guardId;
  final String? startTime;    // "2025-11-30 09:00:00"
  final String? endTime;      // "2025-11-30 10:00:00"
  final int? rating;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;
  final Project? project;

  Patrol({
     this.id,
     this.inspectorId,
     this.projectId,
     this.guardId,
     this.startTime,
     this.endTime,
     this.rating,
     this.notes,
     this.createdAt,
     this.updatedAt,
     this.project,
  });

  factory Patrol.fromJson(Map<String, dynamic> json) {
    return Patrol(
      id: json['id'] as int,
      inspectorId: json['inspector_id'] as int?,
      projectId: json['project_id'] as int,
      guardId: json['guard_id'] as int,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      rating: json['rating'] as int,
      notes: json['notes'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      project: Project.fromJson(json['project']),
    );
  }
}
