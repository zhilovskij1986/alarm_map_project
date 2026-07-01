import 'package:alarm_map_project/features/alerts/domain/repositories/alerts_repository.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/alerts_map_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/cubit/region_alerts_cubit.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/alerts_map_screen.dart';
import 'package:alarm_map_project/features/alerts/presentation/screens/region_alerts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MainAlertsScreen extends StatelessWidget {
  const MainAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1DC0F4), Color(0xFFF2F67C)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MenuButton(
                title: 'Alerts Map',
                icon: Icons.map_outlined,
                onTap: () {
                  context.push('/map');
                },
              ),
              const SizedBox(height: 20),
              MenuButton(
                title: 'Region Alerts',
                imagePath: 'assets/map/icon_city.png',
                onTap: () {
                  context.push('/regions');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? imagePath;
  final VoidCallback onTap;

  const MenuButton({
    super.key,
    required this.title,
    this.icon,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                width: 20,
                height: 20,
                fit: BoxFit.contain,
              )
            else if (icon != null)
              Icon(icon, color: const Color(0xFF1E1E1E), size: 22),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
