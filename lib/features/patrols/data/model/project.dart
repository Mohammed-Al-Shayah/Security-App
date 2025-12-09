class Project {
  final int? id;
  final String? name;
  final String? location;
  final String? lat;
  final String? lng;
  final int? managerId;
  final String? startDate;
  final String? endDate;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Project({
     this.id,
     this.name,
     this.location,
     this.lat,
     this.lng,
     this.managerId,
     this.startDate,
     this.endDate,
     this.status,
     this.createdAt,
     this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      lat: json['lat'],
      lng: json['lng'],
      managerId: json['manager_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
