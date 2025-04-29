import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Gucinav extends StatefulWidget {
  final int number;
  const Gucinav({super.key, required this.number});

  @override
  State<Gucinav> createState() {
    return _GucinavState();
  }
}

class _GucinavState extends State<Gucinav> {
  @override
  void initState() {
    super.initState();
  }

  // Handle navigation when a tab is tapped
  void _onTabSelected(int index) {
    // Navigate to the appropriate screen
    switch (index) {
      case 0:
        Get.toNamed("/front-screen/home");
        break;
      case 1:
        Get.toNamed("/front-screen/profile");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: widget.number,
      backgroundColor: const Color.fromARGB(255, 46, 147, 230),
      selectedItemColor: Color(0xFFD0E7FA),
      unselectedItemColor: Colors.white,

      items: [
        BottomNavigationBarItem(
          label: 'Beranda',
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              widget.number == 0
                  ? const ImageIcon(
                    AssetImage('assets/images/home.png'),
                    color: Color(0xFFD0E7FA),
                  )
                  : const ImageIcon(
                    AssetImage('assets/images/home.png'),
                    color: Colors.white,
                  ),
            ],
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon:
              widget.number == 1
                  ? const ImageIcon(
                    AssetImage('assets/images/account.png'),
                    color: Color(0xFFD0E7FA),
                  )
                  : const ImageIcon(
                    AssetImage('assets/images/account.png'),
                    color: Colors.white,
                  ),
        ),
      ],
      onTap: _onTabSelected,
    );
  }
}
