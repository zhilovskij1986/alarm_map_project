
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegionAlertsCubit extends Cubit<RegionAlertsState> {
  RegionAlertsCubit(this._alertsRepository) : super(RegionAlertsInitial());

  final AlertsRepository _alertsRepository;

  Future<void> loadRegionDetailAlerts(String regionId) async {
    try {
      emit(RegionAlertsLoading());
      
      final regionAlert = await _alertsRepository.getAlertByUid(regionId);

      emit(RegionAlertsLoaded([regionAlert]));      
      
    } catch (e) {
      emit(RegionAlertsError('Не вдалося завантажити історію: $e'));
    }
  }
}
