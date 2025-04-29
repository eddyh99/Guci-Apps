import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guci_apps/utils/extensions.dart';
import 'package:guci_apps/utils/functions.dart';
import 'package:guci_apps/utils/globalvar.dart';
import 'package:guci_apps/views/widget/button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() {
    return _LandingViewState();
  }
}

class _LandingViewState extends State<LandingView> {
  Future<void> _autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    String? password = prefs.getString("password");

    if (username != null && password != null) {
      // Prepare the login data
      Map<String, dynamic> mdata = {'username': username, 'password': password};

      try {
        var url = Uri.parse("$urlapi/auth/signin_sales");
        var response = await gucitoakAPI(url, jsonEncode(mdata));
        var result = jsonDecode(response);

        if (result['code'] == 200) {
          // If session is valid, save sales_id if needed
          prefs.setString("sales_id", result["message"]["id"].toString());

          // Then move to home
          Get.offAllNamed("/front-screen/home");
        } else {
          var psnerr = result['message'];
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          showAlert(psnerr, context);
        }
        // else do nothing, stay in landing page
      } catch (e) {
        log("Auto-login error: $e");
        Navigator.pop(context);
        showAlert("Something Wrong, Please Contact Administrator", context);
        // You can also show a toast or just ignore
      }
    }
    // else: No saved credentials, stay on landing page
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.symmetric(horizontal: 10.w),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome to",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Text(
                      "GUCILUWAK",
                      style: GoogleFonts.lato(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              const Image(
                image: AssetImage('assets/images/logo-satoshi.png'),
                width: 186,
                height: 210,
              ),
              SizedBox(height: 10.h),
              ButtonWidget(
                text: "Login",
                onTap: () {
                  Get.toNamed("/front-screen/login");
                },
                textcolor: const Color(0xFFB48B3D),
                backcolor: const Color(0xFFFFFFFF),
                width: 50.w,
                radiuscolor: const Color(0xFFB48B3D),
                fontsize: 16,
                radius: 30,
              ),
              SizedBox(height: 1.h),
              ButtonWidget(
                text: "Register",
                onTap: () {
                  Get.toNamed("/front-screen/register");
                },
                textcolor: const Color(0xFFFFFFFF),
                backcolor: const Color(0x00000000),
                width: 50.w,
                radiuscolor: const Color(0xFFB48B3D),
                fontsize: 16,
                radius: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
