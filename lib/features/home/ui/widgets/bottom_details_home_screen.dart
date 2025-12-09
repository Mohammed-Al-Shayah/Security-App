
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:security_app/core/theming/styles.dart';

class BottomDetailsHomeScreen extends StatelessWidget {
  const BottomDetailsHomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/patrolsGreen.svg',
                    width: 32.w,
                    height: 32.h,
                  ),
                  SizedBox(height: 12.h),
                  Text('3', style: TextStyles.font24BlackBold),
                  SizedBox(height: 4.h),
                  Text(
                    'Patrols Today',
                    style: TextStyles.font14Black400Weight,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 16.w),
    
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
                vertical: 24.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/Reportred.svg',
                    width: 32.w,
                    height: 32.h,
                  ),
                  SizedBox(height: 12.h),
                  Text('3', style: TextStyles.font24BlackBold),
                  SizedBox(height: 4.h),
                  Text(
                    'Patrols Today',
                    style: TextStyles.font14Black400Weight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
