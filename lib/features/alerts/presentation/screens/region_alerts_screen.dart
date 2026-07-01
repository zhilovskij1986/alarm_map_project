import 'package:alarm_map_project/features/alerts/domain/entities/region.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegionAlertsScreen extends StatelessWidget {
  const RegionAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const dropdownBgColor = Colors.white;
    Region? selectedRegion;

    return BlocBuilder<RegionAlertsCubit, RegionAlertsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Region Alerts',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: state.appBarColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black87),
                onPressed: () {
                  if (selectedRegion != null) {
                    context
                        .read<RegionAlertsCubit>()
                        .loadRegionDetailAlerts(selectedRegion!.uid.toString());
                  }
                },
              )
            ],
          ),
          body: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            color: state.backgroundColor,
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    color: dropdownBgColor,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F7FA),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black12),
                      ),
                      // StatefulBuilder
                      child: StatefulBuilder(
                        builder: (context, setDropdownState) {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<Region>(
                              value: selectedRegion,
                              isExpanded: true,
                              dropdownColor: Colors.white,
                              hint: Row(
                                children: const [
                                  Icon(Icons.search, color: Colors.black45, size: 20),
                                  SizedBox(width: 10),
                                  Text(
                                    'Оберіть місто або регіон',
                                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Colors.black45),
                                  ),
                                ],
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.black54),
                              items: Region.values.map((Region region) {
                                return DropdownMenuItem<Region>(
                                  value: region,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.location_on_outlined, color: Colors.black45, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        '${region.label} область',
                                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (Region? newRegion) {
                                if (newRegion != null) {
                                  setDropdownState(() {
                                    selectedRegion = newRegion;
                                  });
                                  context.read<RegionAlertsCubit>().loadRegionDetailAlerts(newRegion.uid.toString());
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Expanded(
                    child: Builder(
                      builder: (context) {
                        if (selectedRegion == null || state is RegionAlertsInitial) {
                          return const InitialAlertsView();
                        }

                        if (state is RegionAlertsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          );
                        }

                        if (state is RegionAlertsError) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                state.message,
                                style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                        if (state is RegionAlertsLoaded && state.alerts.isNotEmpty) {
                          final isAlarm = state.alerts.first.isAirRaidActive;
                          return LoadedAlertsView(isAlarm: isAlarm);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
        ),
        );
      },
    );
  }
}

class InitialAlertsView extends StatelessWidget {
  const InitialAlertsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.apartment_rounded,
              color: Colors.white,
              size: 160,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.cloud_outlined, color: Colors.white, size: 32),
                SizedBox(width: 40),
                Icon(Icons.cloud_outlined, color: Colors.white, size: 24),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class LoadedAlertsView extends StatelessWidget {
  final bool isAlarm;

  const LoadedAlertsView({super.key, required this.isAlarm});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isAlarm ? Icons.notification_important_rounded : Icons.check_circle_rounded,
            color: Colors.white,
            size: 120,
          ),
          const SizedBox(height: 32),
          Text(
            isAlarm ? 'Повітряна тривога!' : 'Немає тривоги',
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          if (isAlarm)
            const Text(
              'Пройдіть до укриття',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}