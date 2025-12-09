import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:security_app/core/netwoking/api_constants.dart';
import 'package:security_app/core/netwoking/api_service.dart';
import 'package:security_app/core/netwoking/dio_factory.dart';
import 'package:security_app/core/storage/app_prefs.dart';
import 'package:security_app/features/incidents/logic/cubit/incidents_cubit.dart';
import 'package:security_app/features/login/data/repo/login_repository.dart';
import 'package:security_app/features/login/logic/cubit/login_cubit.dart';
import 'package:security_app/features/incidents/data/repo/incidents_repository.dart';
import 'package:security_app/features/patrols/data/repo/patrols_repository.dart';
import 'package:security_app/features/patrols/logic/cubit/patrol_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> initServiceLocator() async {
  // 1) External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<AppPrefs>(() => AppPrefs(sharedPreferences));
  getIt.registerLazySingleton<Dio>(
    () => DioFactory(getIt<AppPrefs>()).createDio(),
  );
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(
      dio: getIt<Dio>(),
      baseUrl: ApiConstants.baseApiUrl,
      tokenProvider: () async => getIt<AppPrefs>().getToken(),
    ),
  );
  // 3) Repositories
  getIt.registerLazySingleton<LoginRepository>(
    () => LoginRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<IncidentsRepository>(
    () => IncidentsRepository(getIt<ApiService>(), getIt<AppPrefs>()),
  );

  getIt.registerLazySingleton<PatrolsRepository>(
    () => PatrolsRepository(getIt<ApiService>()),
  );

  // 4) Cubits
  getIt.registerFactory<LoginCubit>(
    () => LoginCubit(getIt<AppPrefs>(), getIt<LoginRepository>()),
  );
  getIt.registerFactory<IncidentsCubit>(
    () => IncidentsCubit(getIt<IncidentsRepository>()),
  );

  getIt.registerFactory<PatrolCubit>(
    () => PatrolCubit(getIt<PatrolsRepository>()),
  );
}
