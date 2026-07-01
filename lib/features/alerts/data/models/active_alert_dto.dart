import 'package:alarm_map_project/features/alerts/domain/entities/region.dart';

class ActiveAlertDto {
  final String id;
  final bool isAlarm;

  ActiveAlertDto({required this.id, required this.isAlarm});

  factory ActiveAlertDto.fromJson(Map<String, dynamic> json) {
    String defaultUid = json['location_uid'].toString();
    final oblastName = json['location_oblast'] as String?;
    final bool isAlarmActive = json['finished_at'] == null;

    if (defaultUid == Region.kyivCity.uid.toString()) {
      return ActiveAlertDto(
        id: Region.kyivCity.uid.toString(),
        isAlarm: isAlarmActive,
      );
    }

    if (defaultUid == Region.kyivRegion.uid.toString() ||
        (oblastName != null && oblastName.toLowerCase().contains('київська'))) {
      return ActiveAlertDto(
        id: Region.kyivRegion.uid.toString(),
        isAlarm: json['finished_at'] == null,
      );
    }

    if (oblastName != null && oblastName.isNotEmpty) {
      final cleanName =
          oblastName.replaceAll(' область', '').trim().toLowerCase();

      Region? matched;

      for (final r in Region.values) {
        if (cleanName.contains(r.label.toLowerCase()) || r.uid.toString() == defaultUid) {
          matched = r;
          break;
        }
      }

      final String finalId = matched != null ? matched.uid.toString() : defaultUid;

      return ActiveAlertDto(
        id: finalId,
        isAlarm: json['finished_at'] == null,
      );
    }

    return ActiveAlertDto(
      id: defaultUid,
      isAlarm: json['finished_at'] == null,
    );
  }
}
