part of 'incidents_cubit.dart';

class IncidentsState extends Equatable {
  final bool isLoading;
  final List<IncidentResponseModel> incidents;
  final String? errorMessage;

  const IncidentsState({
    this.isLoading = false,
    this.incidents = const [],
    this.errorMessage,
  });

  IncidentsState copyWith({
    bool? isLoading,
    List<IncidentResponseModel>? incidents,
    String? errorMessage,
  }) {
    return IncidentsState(
      isLoading: isLoading ?? this.isLoading,
      incidents: incidents ?? this.incidents,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, incidents, errorMessage];
}
