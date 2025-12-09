import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int? currentIndex;
  final ValueChanged<int>? onTap;
  const BottomNavBar({super.key, this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex ?? 0,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      // selectedItemColor: Colors.blue,
      // unselectedItemColor: Colors.grey,
      elevation: 8.0,
      
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svgs/homeGray.svg'),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svgs/shiftss.svg'),
          label: 'Shifts',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svgs/patrol.svg'),
          label: 'Patrols',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svgs/incident.svg'),
          label: 'Incidents',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/svgs/Profile.svg'),
          label: 'Profile',
        ),
      ],
    );
  }
}
