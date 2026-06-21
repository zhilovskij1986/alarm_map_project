import 'package:alarm_map_project/features/alerts/domain/entities/region.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegionAlertsScreen extends StatefulWidget {
  const RegionAlertsScreen({super.key});

  @override
  State<RegionAlertsScreen> createState() => _RegionAlertsScreenState();
}

class _RegionAlertsScreenState extends State<RegionAlertsScreen> {
  
  Region? _selectedRegion;   
  Color _currentBgColor = const Color(0xFF7EC8F2); 
  Color _currentAppBarColor = const Color(0xFFBCE0F5);

  @override
  Widget build(BuildContext context) {
    const dropdownBgColor = Colors.white;   
    const alarmBackgroundColor = Color(0xFFFF3A3A); 
    const alarmAppBarColor = Color(0xFFE03030);     
    const clearBackgroundColor = Color(0xFF2ECC71); 
    const clearAppBarColor = Color(0xFF27AE60);     

    return BlocConsumer<RegionAlertsCubit, RegionAlertsState>(
      listener: (context, state) {
        if (state is RegionAlertsLoaded && state.alerts.isNotEmpty) {
          final isAlarm = state.alerts.first.isAirRaidActive;
          setState(() {
            _currentBgColor = isAlarm ? alarmBackgroundColor : clearBackgroundColor;
            _currentAppBarColor = isAlarm ? alarmAppBarColor : clearAppBarColor;
          });
        }        
        else if (state is RegionAlertsInitial) {
          setState(() {
            _currentBgColor = const Color(0xFF7EC8F2);
            _currentAppBarColor = const Color(0xFFBCE0F5);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: _currentBgColor, 
          appBar: AppBar(
            title: const Text(
              'Region Alerts',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            backgroundColor: _currentAppBarColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.black87),
                onPressed: () {
                  if (_selectedRegion != null) {
                    context
                        .read<RegionAlertsCubit>()
                        .loadRegionDetailAlerts(_selectedRegion!.uid.toString());
                  }
                },
              )
            ],
          ),
          body: Column(
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
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Region>(
                      value: _selectedRegion,
                      isExpanded: true,
                      dropdownColor: Colors.white,                     
                      hint: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.black45, size: 20),
                          const SizedBox(width: 10),
                          const Text(
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
                          setState(() {
                            _selectedRegion = newRegion;
                          });
                          context.read<RegionAlertsCubit>().loadRegionDetailAlerts(newRegion.uid.toString());
                        }
                      },
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Builder(
                  builder: (context) {                    
                    if (_selectedRegion == null || state is RegionAlertsInitial) {
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
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}