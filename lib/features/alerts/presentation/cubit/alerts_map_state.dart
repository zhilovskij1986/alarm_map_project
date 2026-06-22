import 'package:alarm_map_project/features/alerts/domain/entities/active_alert.dart';

abstract class AlertsMapState {
  const AlertsMapState();
}

class AlertsMapInitial extends AlertsMapState {}

class AlertsMapLoading extends AlertsMapState {}

class AlertsMapLoaded extends AlertsMapState {
  final List<ActiveAlert> alerts;

  const AlertsMapLoaded(this.alerts);
}

class AlertsMapError extends AlertsMapState {
  final String message;

  const AlertsMapError(this.message);
}
