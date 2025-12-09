import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';

class TodayShifts extends StatelessWidget {
  const TodayShifts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.sp),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today's Shift", style: TextStyles.font16Black500Weight),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.timer_outlined, color: ColorsManager.grayLight),
                  SizedBox(width: 5.w),
                  Text('08:00 AM - 04:00 PM', style: TextStyles.font13GrayGeg),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: ColorsManager.grayLight,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'Downtown Office Complex',
                    style: TextStyles.font13GrayGeg,
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.sp),
                  color: Color(0xFFA5D6A7),
                ),
                child: Text(
                  'In Progress',
                  style: TextStyle(color: Color(0xFF43A047)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
