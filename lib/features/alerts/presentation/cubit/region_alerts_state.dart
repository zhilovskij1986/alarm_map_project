import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';

abstract class RegionAlertsState {
  const RegionAlertsState();
}

class RegionAlertsInitial extends RegionAlertsState {}

class RegionAlertsLoading extends RegionAlertsState {}

class RegionAlertsLoaded extends RegionAlertsState {
  
  final List<RegionDetailAlert> alerts;

  const RegionAlertsLoaded(this.alerts);
}

class RegionAlertsError extends RegionAlertsState {
  final String message;

  const RegionAlertsError(this.message);
}
