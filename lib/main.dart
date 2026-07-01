import 'package:alarm_map_project/core/api_client.dart';
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository_impl.dart';
import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'core/router.dart';
import 'features/alerts/domain/datasources/alerts_remote_data_source_impl.dart';


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
      create: (context) {
        final apiClient = ApiClient();

        final remoteDataSource = AlertsRemoteDataSourceImpl(apiClient: apiClient);

        return AlertsRepositoryImpl(remoteDataSource: remoteDataSource);
  },
      child: MaterialApp.router(
        title: 'Alerts Map Project',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blueGrey,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
