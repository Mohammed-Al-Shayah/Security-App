
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';

class MyStatus extends StatelessWidget {
  final String statusText;
  final bool isSelected;
  final VoidCallback onTap;

  const MyStatus({
    super.key,
    required this.statusText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? ColorsManager.mainBlue : ColorsManager.grayLight,
          borderRadius: BorderRadius.circular(14.sp),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        child: Text(
          statusText,
          style: TextStyles.font16WightSemiBold.copyWith(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
