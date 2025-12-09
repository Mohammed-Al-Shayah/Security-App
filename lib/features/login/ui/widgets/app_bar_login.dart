
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/theming/styles.dart';

class AppBarLogin extends StatelessWidget {
  const AppBarLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      decoration: const BoxDecoration(color: ColorsManager.mainBlue),
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: 80.w,
            height: 80.h,
          ),
          SizedBox(height: 16.h),
          Text('Security Guard', style: TextStyles.font24WhiteBold),
          Text(
            "Welcome back, please login",
            style: TextStyles.font16WightSemiBold,
          ),
        ],
      ),
    );
  }
}
