import 'package:alarm_map_project/features/alerts/domain/entities/region.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/alerts_map_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/alerts_map_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertsMapScreen extends StatelessWidget {
  const AlertsMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFF7EC8F2);
    const appBarColor = Color(0xFFBCE0F5);
    const cardAlarmColor = Color(0xFFACDCF7);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Alerts Map',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: appBarColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: () => context.read<AlertsMapCubit>().loadActiveAlerts(),
          )
        ],
      ),
      body: BlocBuilder<AlertsMapCubit, AlertsMapState>(
        builder: (context, state) {
          if (state is AlertsMapLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1DC0F4)),
              ),
            );
          } else if (state is AlertsMapError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (state is AlertsMapLoaded) {
            final activeRegionIds = state.alerts
                .where((a) => a.isAlarm)
                .map((a) => a.regionId)
                .toSet();

            final activeRegionsInMap = Region.values.where((region) {
              return activeRegionIds.contains(region.uid.toString());
            }).toList();

            return Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1047 / 695,
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                'assets/map/Ukraine_base.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            ...Region.values.map((region) {
                              final uidStr = region.uid.toString();
                              if (activeRegionIds.contains(uidStr)) {
                                return Positioned.fill(
                                  child: Image.asset(
                                    'assets/map/${region.fileName}.png',
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: activeRegionsInMap.isEmpty
                      ? const Center(
                          child: Text(
                            'Всі області чисті',
                            style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          physics: const BouncingScrollPhysics(),
                          itemCount: activeRegionsInMap.length,
                          itemBuilder: (context, index) {
                            final region = activeRegionsInMap[index];
                            final now = DateTime.now();
                            final minutes = now.minute < 10
                                ? '0${now.minute}'
                                : '${now.minute}';
                            final alertTime =
                                'May 20, 2026, ${now.hour}:$minutes';

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: cardAlarmColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    color: Colors.redAccent,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          region == Region.kyivCity
                                              ? region.label
                                              : '${region.label} область',
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          alertTime,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const Center(child: Text('Очікування даних...'));
        },
      ),
    );
  }
}


