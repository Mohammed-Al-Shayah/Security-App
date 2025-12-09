import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:security_app/core/di/service_locator.dart';
import 'package:security_app/core/storage/app_prefs.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';
import 'package:security_app/features/login/data/models/user.dart';

class UserDetailsOnHomeScreen extends StatelessWidget {
  const UserDetailsOnHomeScreen({super.key});

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
    final today = DateFormat('EEEE, MMMM d, y').format(DateTime.now());

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(Icons.access_time_filled_sharp, size: 80),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: TextStyles.font16boldeblue500Weight),
                    Text(role, style: TextStyles.font13GrayGeg),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.date_range,
                  color: ColorsManager.moreGray,
                  size: 16.sp,
                ),
                SizedBox(width: 5.w),
                Text(today, style: TextStyles.font14moreGrayGeg),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
