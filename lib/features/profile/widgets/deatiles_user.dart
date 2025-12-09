import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';

class DeatilesUser extends StatelessWidget {
  final IconData icon;
  final String text;
  const DeatilesUser({super.key,required this.icon,required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: ColorsManager.grayBackGround,
      ),
      child: Row(
        children: [
          Icon(
           icon,
            size: 20.sp,
            color: ColorsManager.moreGray,
          ),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyles.font14moreGrayGeg,
          ),
        ],
      ),
    );
  }
}
