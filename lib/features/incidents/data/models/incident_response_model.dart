import 'package:equatable/equatable.dart';

class IncidentResponseModel extends Equatable {
  final int id;
  final String? title;
  final String? typeName;
  final String? status;
  final String? projectName;
  final String? projectLocation;
  final String? description;
  final DateTime? occurredAt;

  const IncidentResponseModel({
    required this.id,
    this.title,
    this.typeName,
    this.status,
    this.projectName,
    this.projectLocation,
    this.description,
    this.occurredAt,
  });

  factory IncidentResponseModel.fromJson(Map<String, dynamic> json) {
    final project = json['project'];
    final type = json['type'];

    return IncidentResponseModel(
      id: json['id'] ?? 0,
      title: json['title']?.toString() ?? '',
      typeName: type is Map
          ? type['name']?.toString() ?? ''
          : json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      projectName: project is Map
          ? project['name']?.toString() ?? ''
          : json['project']?.toString() ??
                json['project_name']?.toString() ??
                '',
      projectLocation: project is Map
          ? project['location']?.toString() ?? ''
          : '',
      description: json['description']?.toString() ?? '',
      occurredAt: json['occurred_at'] != null
          ? DateTime.tryParse(json['occurred_at'])
          : (json['date'] != null ? DateTime.tryParse(json['date']) : null),
    );
  }

  String get formattedDate {
    if (occurredAt == null) return '';
    return "${_monthName(occurredAt!.month)} ${occurredAt!.day}, ${occurredAt!.year}";
  }

  String _monthName(int m) {
    const months = [
      "",
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December",
    ];
    return months[m];
  }

  @override
  List<Object?> get props => [
    id,
    title,
    typeName,
    status,
    projectName,
    projectLocation,
    description,
    occurredAt,
  ];
}
