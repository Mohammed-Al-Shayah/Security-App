import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';

class MyCard extends StatelessWidget {
  final String date;
  final String time;
  final String location;
  final String status;
  final Color statusColor;
  final VoidCallback? onTap;
  const MyCard({
    this.onTap,
    super.key,
    required this.date,
    required this.time,
    required this.location,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        width: double.infinity,
        // height: 164.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.sp),
        ),
        child: Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Icon(
                    Icons.date_range_outlined,
                    size: 24.sp,
                    color: ColorsManager.grayLight,
                  ),
                  Text(date),
                  SizedBox(width: 170.w),
                  Icon(Icons.navigate_next, size: 24.sp),
                ],
              ),

              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 24.sp,
                    color: ColorsManager.grayLight,
                  ),
                  SizedBox(width: 8.w),
                  Text(time),
                ],
              ),
              SizedBox(height: 10.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 24.sp,
                    color: ColorsManager.grayLight,
                  ),
                  SizedBox(width: 8.w),
                  Text(location),
                ],
              ),
              SizedBox(height: 12.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.sp),
                  color: statusColor,
                ),
                child: Text(
                  status,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
