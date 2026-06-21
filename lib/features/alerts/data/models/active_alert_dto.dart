import 'package:alarm_map_project/features/alerts/domain/entities/region.dart';

class ActiveAlertDto {
  final String id;
  final bool isAlarm;

  ActiveAlertDto({required this.id, required this.isAlarm});

  factory ActiveAlertDto.fromJson(Map<String, dynamic> json) {
    String defaultUid = (json['location_uid'] ?? '').toString();
    final oblastName = json['location_oblast'] as String?;
    final String locationTitle =
        (json['location_title'] as String? ?? '').toLowerCase();

    if (defaultUid == '31' ||
        locationTitle.contains('м. київ') ||
        locationTitle == 'київ') {
      return ActiveAlertDto(
        id: Region.kyivCity.uid.toString(),
        isAlarm: json['finished_at'] == null,
      );
    }

    if (defaultUid == '14' ||
        (oblastName != null && oblastName.toLowerCase().contains('київська'))) {
      return ActiveAlertDto(
        id: Region.kyivRegion.uid.toString(),
        isAlarm: json['finished_at'] == null,
      );
    }

    if (oblastName != null && oblastName.isNotEmpty) {
      final cleanName =
          oblastName.replaceAll(' область', '').trim().toLowerCase();

      final matchedRegion = Region.values.firstWhere(
        (r) => cleanName.contains(r.label.toLowerCase()),
        orElse: () => Region.values.firstWhere(
            (r) => r.uid.toString() == defaultUid,
            orElse: () => Region.kyivRegion),
      );

      return ActiveAlertDto(
        id: matchedRegion.uid.toString(),
        isAlarm: json['finished_at'] == null,
      );
    }

    return ActiveAlertDto(
      id: defaultUid,
      isAlarm: json['finished_at'] == null,
    );
  }
}
