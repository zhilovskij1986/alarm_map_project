import 'package:flutter/material.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';

abstract class RegionAlertsState {
  final Color backgroundColor;
  final Color appBarColor;

  const RegionAlertsState({
    required this.backgroundColor,
    required this.appBarColor,
  });
}

class RegionAlertsInitial extends RegionAlertsState {
  const RegionAlertsInitial() : super(
    backgroundColor: const Color(0xFF7EC8F2),
    appBarColor: const Color(0xFFBCE0F5),
  );
}

class RegionAlertsLoading extends RegionAlertsState {
  const RegionAlertsLoading() : super(
    backgroundColor: const Color(0xFF7EC8F2),
    appBarColor: const Color(0xFFBCE0F5),
  );
}

class RegionAlertsLoaded extends RegionAlertsState {
  final List<RegionDetailAlert> alerts;

  RegionAlertsLoaded(this.alerts) : super(
    backgroundColor: alerts.isNotEmpty && alerts.first.isAirRaidActive
        ? const Color(0xFFFF3A3A)
        : const Color(0xFF2ECC71),
    appBarColor: alerts.isNotEmpty && alerts.first.isAirRaidActive
        ? const Color(0xFFE03030)
        : const Color(0xFF27AE60),
  );
}

class RegionAlertsError extends RegionAlertsState {
  final String message;

  const RegionAlertsError(this.message) : super(
    backgroundColor: const Color(0xFF7EC8F2),
    appBarColor: const Color(0xFFBCE0F5),
  );
}