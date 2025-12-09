import 'package:security_app/core/netwoking/api_constants.dart';
import 'package:security_app/core/netwoking/api_service.dart';
import 'package:security_app/core/storage/app_prefs.dart';
import 'package:security_app/features/incidents/data/models/incident_request_model.dart';
import 'package:security_app/features/incidents/data/models/incident_response_model.dart';

class IncidentsRepository {
  final ApiService _apiService;
  final AppPrefs _appPrefs;

  IncidentsRepository(this._apiService, this._appPrefs);

  Future<List<IncidentResponseModel>> fetchIncidents() async {
    final String? token = _appPrefs.getToken();

    if (token == null || token.isEmpty) {
      throw Exception('No auth token found. Please login again.');
    }

    final dynamic data = await _apiService.get(
      ApiConstants.baseApiUrl + ApiConstants.guardIncidents,
    );

    final dynamic listData = data is Map<String, dynamic> ? data['data'] : data;

    if (listData is List) {
      return listData
          .whereType<Map<String, dynamic>>()
          .map(IncidentResponseModel.fromJson)
          .toList();
    }

    throw Exception('Invalid response format for incidents');
  }

  Future<IncidentResponseModel> createIncidents(
    IncidentRequestModel request,
  ) async {
    final token = _appPrefs.getToken();
    if (token == null || token.isEmpty) {
      throw Exception('No auth token found. Please login again.');
    }
    final dynamic data = await _apiService.post(
      ApiConstants.baseApiUrl + ApiConstants.guardIncidents,
      data: request.toJson(),
    );

    final dynamic incidentJson = data is Map<String, dynamic>
        ? data['data'] ?? data
        : data;

    if (incidentJson is Map<String, dynamic>) {
      return IncidentResponseModel.fromJson(incidentJson);
    }
    throw Exception('Invalid response format for created incident');
  }
}
