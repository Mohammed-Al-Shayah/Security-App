part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  const LoginState({
     this.isLoading=false,
    this.errorMessage,
     this.isSuccess=false,
  });

  LoginState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess];

}
