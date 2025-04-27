import 'dart:developer';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Gucinav extends StatefulWidget {
  final int number;
  const Gucinav({super.key, required this.number});

  @override
  State<Gucinav> createState() {
    return _GucinavState();
  }
}

class _GucinavState extends State<Gucinav> {
  bool hasNewMessage = false;
  bool hasNewSignal = false;

  @override
  void initState() {
    super.initState();
    // eventBus.on<ReloadBadgeEvent>().listen((event) {
    //   _refreshBadges(); // Refresh badges when ReloadBadgeEvent is triggered
    // });
    // appLifecycleNotifier.addListener(_handleAppLifecycleChange);

    // Initial badge status check
    // _refreshBadges();
  }

  // void _handleAppLifecycleChange() {
  //   if (appLifecycleNotifier.value == AppLifecycleState.resumed) {
  //     // Refresh badge data when app resumes
  //     _refreshBadges();
  //   }
  // }

  // Future<void> _refreshBadges() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     hasNewMessage = prefs.getBool('hasNewMessage') ?? false;
  //     log("on nav hasnewmessage : $hasNewMessage");
  //     hasNewSignal = prefs.getBool('hasNewSignal') ?? false;
  //   });
  // }

  // Handle navigation when a tab is tapped
  void _onTabSelected(int index) {
    // Navigate to the appropriate screen
    switch (index) {
      case 0:
        Get.toNamed("/front-screen/home");
        setState(() {
          hasNewSignal = false;
        });
        break;
      case 1:
        Get.toNamed("/front-screen/home");
        break;
      case 2:
        Get.toNamed("/front-screen/home");
        setState(() {
          hasNewMessage = false;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.react,
      activeColor: const Color(0xFFD0E7FA),
      backgroundColor: Colors.blue,
      items: [
        TabItem(
          title: 'Beranda',
          icon: Stack(
            clipBehavior: Clip.none,
            fit: StackFit.expand,
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
              (hasNewSignal)
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        ),
        TabItem(
          title: 'Barcode',
          icon: widget.number == 1
              ? const ImageIcon(AssetImage('assets/images/qrcode.png'),
                  color: Color(0xFFD0E7FA))
              : const ImageIcon(AssetImage('assets/images/qrcode.png'),
                  color: Colors.white),
        ),
        TabItem(
          title: 'Profile',
          icon: widget.number == 2
              ? const ImageIcon(AssetImage('assets/images/account.png'),
                  color: Color(0xFFD0E7FA))
              : const ImageIcon(AssetImage('assets/images/account.png'),
                  color: Colors.white),
        ),
      ],
      initialActiveIndex: widget.number,
      onTap: _onTabSelected,
    );
  }
}