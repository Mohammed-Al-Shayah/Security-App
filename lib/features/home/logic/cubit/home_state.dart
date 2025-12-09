part of 'home_cubit.dart';

@freezed
class HomeState<T> with _$HomeState<T> {
  const factory HomeState.initial() = _Initial<T>;
  const factory HomeState.loading() = _Loading<T>;
  const factory HomeState.success(T data) = _Success<T>;
  const factory HomeState.failure({required String error}) = _Failure<T>;
}
