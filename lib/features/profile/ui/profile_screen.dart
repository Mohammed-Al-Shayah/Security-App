import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/di/service_locator.dart';
import 'package:security_app/core/storage/app_prefs.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';
import 'package:security_app/features/login/data/models/user.dart';
import 'package:security_app/features/profile/widgets/deatiles_user.dart';
import 'package:security_app/features/profile/widgets/profile_settings_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  User? _getStoredUser() {
    final data = getIt<AppPrefs>().getUserJson();
    if (data == null) return null;
    return User.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    String withFallback(String? value, String fallback) {
      final trimmed = value?.trim();
      if (trimmed == null || trimmed.isEmpty) return fallback;
      return trimmed;
    }

    final user = _getStoredUser();
    final name = withFallback(user?.name, 'Guest User');
    final role = withFallback(user?.role, 'Security Team');
    final email = withFallback(user?.email, 'Email not available');
    final phone = withFallback(user?.phone, 'Phone not available');
    final userId = user?.id;
    final employeeId = userId != null
        ? 'Employee ID: $userId'
        : 'Employee ID: N/A';

    return Scaffold(
      backgroundColor: ColorsManager.grayBackGround,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.0.w),
                width: double.infinity,
                height: 400.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorsManager.grayLight,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60.w,
                        color: ColorsManager.moreGray,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(name, style: TextStyles.font16Black500Weight),
                    SizedBox(height: 8.h),
                    Text(role, style: TextStyles.font14moreGrayGeg),
                    SizedBox(height: 24.h),
                    DeatilesUser(icon: Icons.email_outlined, text: email),
                    SizedBox(height: 12.h),
                    DeatilesUser(icon: Icons.phone_outlined, text: phone),
                    SizedBox(height: 12.h),
                    DeatilesUser(icon: Icons.badge_outlined, text: employeeId),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              ProfileSettingsSection(
                onMyProjectsTap: () {
                  // Handle My Projects tap
                },
                onAttendanceHistoryTap: () {
                  // Handle Attendance History tap
                },
                onLanguageTap: () {
                  // Handle Language tap
                },
                onLogoutTap: () {
                  // Handle Logout tap
                },
                currentLanguage: 'English',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
