
import '../../../../core/api_client.dart';
import '../../data/models/active_alert_dto.dart';
import '../../data/models/region_detail_alert_dto.dart';
import 'alerts_remote_data_source.dart';

class AlertsRemoteDataSourceImpl implements AlertsRemoteDataSource {
  final ApiClient apiClient;

  AlertsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<ActiveAlertDto>> getActiveAlerts() async {
    final response = await apiClient.dio.get('/v1/alerts/active.json');
    final data = response.data as Map<String, dynamic>;
    final alertsList = data['alerts'] as List<dynamic>;

    return alertsList.map<ActiveAlertDto>((dynamic json) {
      return ActiveAlertDto.fromJson(json as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<RegionDetailAlertDto> getAlertByUid(String uid) async {
    final response = await apiClient.dio.get('/v1/iot/active_air_raid_alerts/$uid.json');
    final data = response.data;

    Map<String, dynamic> jsonMap;
    if (data is String) {
      final String trimmedData = data.trim().toLowerCase();
      final isAlarmActive = trimmedData == 'a' || trimmedData == 'p';
      jsonMap = {'is_active': isAlarmActive};
    } else if (data is Map<String, dynamic>) {
      jsonMap = data;
    } else {
      jsonMap = {'is_active': false};
    }

    return RegionDetailAlertDto.fromJson(jsonMap, uid);
  }
}