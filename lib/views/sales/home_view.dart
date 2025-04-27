import 'package:flutter/material.dart';
import 'package:guci_apps/views/widget/bottomnav_widget.dart';
import 'package:guci_apps/views/widget/button_widget.dart';
// import 'package:guci_apps/views/widget/text_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() {
    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  late String lang = "en";
  String urltranslated = "";
  // bool _isError = false;
  // bool _isWebViewLoaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  // void _showErrorBottomSheet() {
  //   if (mounted) {
  //     showModalBottomSheet(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return Container(
  //           padding: const EdgeInsets.all(16.0),
  //           height: 150,
  //           decoration: const BoxDecoration(color: Colors.black),
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Text(
  //                 'Connection error. Please check your internet and try again.',
  //                 style: Theme.of(
  //                   context,
  //                 ).textTheme.displayLarge?.copyWith(fontSize: 16),
  //                 textAlign: TextAlign.center,
  //               ),
  //               const SizedBox(height: 20),
  //               ButtonWidget(
  //                 text: "Retry",
  //                 onTap: () {},
  //                 textcolor: const Color(0xFF000000),
  //                 backcolor: const Color(0xFFBFA573),
  //                 width: 150,
  //                 radiuscolor: const Color(0xFFFFFFFF),
  //                 fontsize: 16,
  //                 radius: 5,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: Stack(children: [Container()])),
      bottomNavigationBar: const Gucinav(number: 0),
    );
  }
}
