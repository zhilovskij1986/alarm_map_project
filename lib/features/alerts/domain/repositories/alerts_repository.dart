import 'package:alarm_map_project/features/alerts/domain/entities/active_alert.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';

abstract class AlertsRepository {
  Future<List<ActiveAlert>> getActiveAlerts();

  Future<RegionDetailAlert> getAlertByUid(String uid);
}
