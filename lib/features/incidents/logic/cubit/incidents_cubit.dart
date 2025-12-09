import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:security_app/features/incidents/data/models/incident_request_model.dart';
import 'package:security_app/features/incidents/data/models/incident_response_model.dart';
import 'package:security_app/features/incidents/data/repo/incidents_repository.dart';

part 'incidents_state.dart';

class IncidentsCubit extends Cubit<IncidentsState> {
  final IncidentsRepository _repository;
  IncidentsCubit(this._repository) : super(const IncidentsState());

  Future<void> fetchIncidents() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final items = await _repository.fetchIncidents();
      emit(
        state.copyWith(isLoading: false, incidents: items, errorMessage: null),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> createIncidents(IncidentRequestModel request) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      await _repository.createIncidents(request);
      await fetchIncidents();
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
