import 'package:equatable/equatable.dart';
import 'package:security_app/features/patrols/data/model/patrol.dart';

class PatrolsState extends Equatable {
  final bool isLoading;
  final List<Patrol> patrols;
  final String? errorMessage;

  const PatrolsState({
    this.isLoading = false,
    this.patrols = const <Patrol>[],
    this.errorMessage,
  });

  PatrolsState copyWith({
    bool? isLoading,
    List<Patrol>? patrols,
    String? errorMessage,
  }) {
    return PatrolsState(
      isLoading: isLoading ?? this.isLoading,
      patrols: patrols ?? this.patrols,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => <Object?>[isLoading, patrols, errorMessage];
}
