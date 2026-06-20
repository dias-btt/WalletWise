import 'package:equatable/equatable.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class DashboardStarted extends DashboardEvent {
  const DashboardStarted(this.userId);

  final String userId;

  @override
  List<Object?> get props => <Object?>[userId];
}

final class DashboardRefreshed extends DashboardEvent {
  const DashboardRefreshed();
}
