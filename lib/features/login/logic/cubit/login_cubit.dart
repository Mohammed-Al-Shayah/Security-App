// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:security_app/core/storage/app_prefs.dart';
import 'package:security_app/features/login/data/models/login_response.dart';
import 'package:security_app/features/login/data/repo/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AppPrefs _appPrefs;
  final LoginRepository _repository;

  LoginCubit(this._appPrefs, this._repository) : super(const LoginState());

  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, errorMessage: null));

    try {
      final LoginResponse response = await _repository.login(
        email: email,
        password: password,
      );

      final String token = response.token;
      final user = response.user;

      if (token.isEmpty) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: 'No token returned from server',
          ),
        );
        return;
      }

      if (user == null) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: false,
            errorMessage: 'No user returned from server',
          ),
        );
        return;
      }

      await Future.wait([
        _appPrefs.saveToken(token),
        _appPrefs.saveUserJson(user.toJson()),
      ]);

      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
