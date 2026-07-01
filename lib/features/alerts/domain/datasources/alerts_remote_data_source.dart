
import '../../data/models/active_alert_dto.dart';
import '../../data/models/region_detail_alert_dto.dart';

abstract class AlertsRemoteDataSource {
  Future<List<ActiveAlertDto>> getActiveAlerts();
  Future<RegionDetailAlertDto> getAlertByUid(String uid);
}