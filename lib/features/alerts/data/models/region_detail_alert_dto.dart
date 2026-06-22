import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';

class RegionDetailAlertDto {
  final String uid;
  final bool isAirRaidActive;

  RegionDetailAlertDto({required this.uid, required this.isAirRaidActive});

  factory RegionDetailAlertDto.fromJson(
      Map<String, dynamic> json, String requestUid) {
    return RegionDetailAlertDto(
      uid: requestUid,
      isAirRaidActive:
          json['is_active'] ?? json['activated'] ?? json['alarm'] ?? false,
    );
  }
  RegionDetailAlert toEntity() {
    return RegionDetailAlert(regionId: uid, isAirRaidActive: isAirRaidActive);
  }
}
