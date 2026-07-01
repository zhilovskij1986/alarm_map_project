import 'package:alarm_map_project/features/alerts/data/models/active_alert_dto.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/active_alert.dart';
import 'package:alarm_map_project/features/alerts/domain/entities/region_detail_alert.dart';
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import '../datasources/alerts_remote_data_source.dart';


class AlertsRepositoryImpl implements AlertsRepository {

  final AlertsRemoteDataSource remoteDataSource;

  AlertsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ActiveAlert>> getActiveAlerts() async {
    try {

      final dtoList = await remoteDataSource.getActiveAlerts();

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

      final dto = await remoteDataSource.getAlertByUid(uid);
      return dto.toEntity();
    } catch (e) {
      throw Exception('Не вдалося отримати статус регіону $uid: $e');
    }
  }
}
