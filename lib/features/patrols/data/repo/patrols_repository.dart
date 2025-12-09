import 'package:security_app/core/netwoking/api_constants.dart';
import 'package:security_app/core/netwoking/api_service.dart';
import 'package:security_app/features/patrols/data/model/patrol.dart';
import 'package:security_app/features/patrols/data/model/patrol_request.dart';

class PatrolsRepository {
  final ApiService _apiService;
  PatrolsRepository(this._apiService);

  Future<List<Patrol>> getMyPatrols() async {
    final dynamic data = await _apiService.get(
      ApiConstants.baseApiUrl + ApiConstants.guardPatrols,
    );

    final dynamic listData = data is Map<String, dynamic> ? data['data'] : data;

    if (listData is List) {
      return listData
          .whereType<Map<String, dynamic>>()
          .map(Patrol.fromJson)
          .toList();
    }

    throw Exception('Invalid response format for patrols');
  }

  Future<Patrol> createPatrol(PatrolRequest request) async {
    final dynamic data = await _apiService.post(
      ApiConstants.baseApiUrl + ApiConstants.guardPatrols,
      data: request.toJson(),
    );

    return Patrol.fromJson(data as Map<String, dynamic>);
  }
}
