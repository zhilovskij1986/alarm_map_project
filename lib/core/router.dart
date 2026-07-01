import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/alerts_map_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/alerts_map_screen.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/main_alerts_screen.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/region_alerts_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainAlertsScreen(),
    ),
    GoRoute(
      path: '/map',
      builder: (context, state) => BlocProvider(
        create: (context) => AlertsMapCubit(
          context.read<AlertsRepository>(),
        )..loadActiveAlerts(),
        child: const AlertsMapScreen(),
      ),
    ),
    GoRoute(
      path: '/regions',
      builder: (context, state) => BlocProvider(
        create: (context) => RegionAlertsCubit(
          context.read<AlertsRepository>(),
        ),
        child: const RegionAlertsScreen(),
      ),
    ),
  ],
);