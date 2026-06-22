import 'package:alarm_map_project/core/api_client.dart';
import 'package:alarm_map_project/features/alerts/data/repositories/alerts_repository_impl.dart';
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/main_alerts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('uk', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AlertsRepository>(
      create: (context) => AlertsRepositoryImpl(apiClient: ApiClient()),
      child: MaterialApp(
        title: 'Alerts Map Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        home: const MainAlertsScreen(),
      ),
    );
  }
}
