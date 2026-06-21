import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/alerts_map_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertsMapCubit extends Cubit<AlertsMapState> {
  final AlertsRepository _repository;

  AlertsMapCubit(this._repository) : super(AlertsMapInitial());

  Future<void> loadActiveAlerts() async {
    emit(AlertsMapLoading());

    try {
      final alerts = await _repository.getActiveAlerts();

      emit(AlertsMapLoaded(alerts));
      
    } catch (e) {
      emit(AlertsMapError(
          'Не вдалося завантажити карту тривог: ${e.toString()}'));
    }
  }
}
