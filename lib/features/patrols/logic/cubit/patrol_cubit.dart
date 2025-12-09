import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:security_app/features/patrols/data/model/patrol.dart';
import 'package:security_app/features/patrols/data/model/patrol_request.dart';
import 'package:security_app/features/patrols/data/repo/patrols_repository.dart';
import 'package:security_app/features/patrols/logic/cubit/patrol_state.dart';

class PatrolCubit extends Cubit<PatrolsState> {
  final PatrolsRepository _repository;

  PatrolCubit(this._repository) : super(PatrolsState());

  Future<void> loadMyPatrols() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      final List<Patrol> patrols = await _repository.getMyPatrols();

      emit(
        state.copyWith(isLoading: false, patrols: patrols, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> createPatrol(PatrolRequest request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final Patrol newPatrol = await _repository.createPatrol(request);

      final List<Patrol> updated = <Patrol>[newPatrol, ...state.patrols];

      emit(
        state.copyWith(isLoading: false, patrols: updated, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
