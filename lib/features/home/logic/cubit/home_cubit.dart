import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  // void getData() async {
  //   emit(const HomeState.loading());

    // final result = await _homeRepo.fetchData();

  //   result.fold(
  //     // عند الخطأ
  //     (error) => emit(HomeState.failure(error: error.message)),
  //     // عند النجاح
  //     (data) => emit(HomeState.success(data)),
  //   );
  // }
}
