import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quick Actions', style: TextStyles.font16Black500Weight),
            SizedBox(height: 16.h),
            GridView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: 5.h,
                crossAxisSpacing: 20.w,
                childAspectRatio: 1,
              ),
              children: [
                _buildActionItem(
                  icon: Icons.date_range_outlined,
                  label: 'My Shifts',
                  onTap: () {
                    // Handle Schedule action
                  },
                ),

                _buildActionItem(
                  icon: Icons.description_outlined,
                  label: 'Attendance',
                  onTap: () {
                    // Handle Reports action
                  },
                ),

                _buildActionItem(
                  icon: Icons.photo_camera_back_outlined,
                  label: 'Patrols',
                  onTap: () {
                    // Handle Reports action
                  },
                ),
                _buildActionItem(
                  icon: Icons.report_gmailerrorred_sharp,
                  label: 'Report Incident',
                  onTap: () {
                    // Handle Reports action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

_buildActionItem({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Container(
          width: 140.w,
          height: 95.h,
          decoration: BoxDecoration(
            color: ColorsManager.grayBackGround,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: ColorsManager.mainBlue, size: 40.sp),
              SizedBox(height: 8.h),
              Text(label, style: TextStyles.font14Black400Weight),
            ],
          ),
        ),
      ],
    ),
  );
}
