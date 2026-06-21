import 'package:alarm_map_project/core/api_client.dart';
import 'package:alarm_map_project/features/alerts/data/models/active_alert_dto.dart';
import 'package:alarm_map_project/features/alerts/data/models/region_detail_alert_dto.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/active_alert.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';

class AlertsRepositoryImpl implements AlertsRepository {
  final ApiClient apiClient;

  AlertsRepositoryImpl({required this.apiClient});

  @override
  Future<List<ActiveAlert>> getActiveAlerts() async {
    try {
      final response = await apiClient.dio.get('/v1/alerts/active.json');
      final data = response.data as Map<String, dynamic>;
      final alertsList = data['alerts'] as List<dynamic>;

      final dtoList = alertsList.map<ActiveAlertDto>((dynamic json) {
        return ActiveAlertDto.fromJson(json as Map<String, dynamic>);
      }).toList();

      final allAlerts = dtoList.map<ActiveAlert>((ActiveAlertDto dto) {
        return ActiveAlert(
          regionId: dto.id,
          isAlarm: dto.isAlarm,
        );
      }).toList();

      final seenIds = <String>{};
      final distinctAlerts =
          allAlerts.where((alert) => seenIds.add(alert.regionId)).toList();

      return distinctAlerts;
    } catch (e) {
      throw Exception('Не вдалося завантажити карту: $e');
    }
  }

  @override
  Future<RegionDetailAlert> getAlertByUid(String uid) async {
    try {
      final response =
          await apiClient.dio.get('/v1/iot/active_air_raid_alerts/$uid.json');

      final data = response.data;

      Map<String, dynamic> jsonMap;

      if (data is String) {
        final String trimmedData = data.trim().toLowerCase();

        final isAlarmActive = trimmedData == 'a' || trimmedData == 'p';

        jsonMap = {
          'is_active': isAlarmActive,
        };
      } else if (data is Map<String, dynamic>) {
        jsonMap = data;
      } else {
        jsonMap = {'is_active': false};
      }

      return RegionDetailAlertDto.fromJson(jsonMap, uid).toEntity();
    } catch (e) {
      throw Exception('Не вдалося отримати статус регіону $uid: $e');
    }
  }
}
