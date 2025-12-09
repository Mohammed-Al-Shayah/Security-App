import 'package:flutter/material.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/features/home/ui/widgets/bottom_details_home_screen.dart';
import 'package:security_app/features/home/ui/widgets/quick_actions.dart';
import 'package:security_app/features/home/ui/widgets/user_details_home_screen.dart';
import 'package:security_app/features/home/ui/widgets/check_home_screen.dart';
import 'package:security_app/features/home/ui/widgets/today_shifts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.grayBackGround,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetailsOnHomeScreen(),
            CheckHomeScreen(),
            TodayShifts(),
            QuickActions(),
            BottomDetailsHomeScreen(),
          ],
        ),
      ),
    );
  }
}
