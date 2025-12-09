import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:security_app/core/theming/colors.dart';
import 'package:security_app/core/widgets/my_card.dart';
import 'package:security_app/core/widgets/my_status.dart';

class Shifts extends StatefulWidget {
  const Shifts({super.key});

  @override
  State<Shifts> createState() => _ShiftsState();
}

class _ShiftsState extends State<Shifts> {
  int selectedIndex = 0;

  final List<String> statuses = ["Today", "Upcoming", "Past"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.grayBackGround,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 24.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(
                statuses.length,
                (index) => Row(
                  children: [
                    MyStatus(
                      statusText: statuses[index],
                      isSelected: selectedIndex == index,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    ),
                    if (index != statuses.length - 1) SizedBox(width: 12.w),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

            _buildSelectedPage(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedPage() {
    switch (selectedIndex) {
      case 0:
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: const MyCard(
                  date: "20 Aug, 2023",
                  time: "8:00 AM - 4:00 PM",
                  location: "789 Sample St, Cityville",
                  status: 'In Progress',
                  statusColor: Colors.blue,
                ),
              );
            },
          ),
        );
      case 1:
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: const MyCard(
                  date: "25 Aug, 2023",
                  time: "9:00 AM - 5:00 PM",
                  location: "123 Main St, Cityville",
                  status: 'Scheduled',
                  statusColor: Colors.orange,
                ),
              );
            },
          ),
        );
      case 2:
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            physics: AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: const MyCard(
                  date: "12 Aug, 2023",
                  time: "10:00 AM - 6:00 PM",
                  location: "456 Another St, Cityville",
                  status: 'Completed',
                  statusColor: Colors.green,
                ),
              );
            },
          ),
        );
      default:
        return Container();
    }
  }
}
