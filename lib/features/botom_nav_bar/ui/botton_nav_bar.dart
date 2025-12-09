import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:security_app/core/di/service_locator.dart';
import 'package:security_app/core/widgets/bottom_nav_bar.dart';
import 'package:security_app/core/widgets/my_app_bar.dart';
import 'package:security_app/features/home/ui/screens/home_screen.dart';
import 'package:security_app/features/incidents/logic/cubit/incidents_cubit.dart';
import 'package:security_app/features/incidents/ui/incidents_screen.dart';
import 'package:security_app/features/patrols/logic/cubit/patrol_cubit.dart';
import 'package:security_app/features/patrols/ui/patrols_screen.dart';
import 'package:security_app/features/profile/ui/profile_screen.dart';
import 'package:security_app/features/shifts/ui/shifts.dart';

class PagesMyApp extends StatefulWidget {
  const PagesMyApp({super.key});

  @override
  State<PagesMyApp> createState() => _PagesMyAppState();
}

class _PagesMyAppState extends State<PagesMyApp> {
  int _currentIndex = 0;

  final List<String> _appBarTitles = [
    'Home',
    'Shifts',
    'Patrols',
    'Incidents',
    'Profile',
  ];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomeScreen(),
      const Shifts(),
      BlocProvider(
        create: (_) => getIt<PatrolCubit>()..loadMyPatrols(),
        child: const PatrolsScreen(),
      ),
      BlocProvider(
        create: (_) => getIt<IncidentsCubit>()..fetchIncidents(),
        child: const IncidentsScreen(),
      ),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: _appBarTitles[_currentIndex],
        key: Key('home_app_bar'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
