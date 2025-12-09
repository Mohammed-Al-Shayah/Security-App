import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:security_app/core/di/service_locator.dart';
import 'package:security_app/core/routing/routes.dart';
import 'package:security_app/core/widgets/bottom_nav_bar.dart';
import 'package:security_app/features/botom_nav_bar/ui/botton_nav_bar.dart';
import 'package:security_app/features/home/ui/screens/home_screen.dart';
import 'package:security_app/features/login/logic/cubit/login_cubit.dart';
import 'package:security_app/features/incidents/logic/cubit/incidents_cubit.dart';
import 'package:security_app/features/login/ui/login_screen.dart';
import 'package:security_app/features/patrols/logic/cubit/patrol_cubit.dart';
import 'package:security_app/features/patrols/ui/patrols_screen.dart';
import 'package:security_app/features/profile/ui/profile_screen.dart';
import 'package:security_app/features/shifts/ui/shifts.dart';
import 'package:security_app/features/incidents/ui/incidents_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.bottomNavBar:
        return MaterialPageRoute(
          builder: (context) =>
              BottomNavBar(currentIndex: 0, onTap: (index) {}),
        );

      case Routes.pagesMyApp:
        return MaterialPageRoute(builder: (context) => const PagesMyApp());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: const LoginScreen(),
          ),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Routes.shiftsScreen:
        return MaterialPageRoute(builder: (context) => const Shifts());
      case Routes.patrolsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<PatrolCubit>()..loadMyPatrols(),
            child: PatrolsScreen(),
          ),
        );
      case Routes.incidentsScreen:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (_) => getIt<IncidentsCubit>()..fetchIncidents(),
            child: const IncidentsScreen(),
          ),
        );
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (context) => const Center(child: Text('404 Not Found')),
        );
    }
  }
}
