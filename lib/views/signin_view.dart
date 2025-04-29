import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guci_apps/utils/extensions.dart';
import 'package:guci_apps/utils/functions.dart';
import 'package:guci_apps/utils/globalvar.dart';
import 'package:guci_apps/views/widget/button_widget.dart';
import 'package:guci_apps/views/widget/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninView extends StatefulWidget {
  const SigninView({super.key});

  @override
  State<SigninView> createState() {
    return _SigninViewState();
  }
}

class _SigninViewState extends State<SigninView> {
  final GlobalKey<FormState> _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  bool _passwordVisible = false;
  bool _haserror = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 3.w),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            child: Form(
              key: _signinFormKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(text: "LOGIN", fontsize: 32),
                          TextWidget(
                            text: "Please login to continue",
                            fontsize: 16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    width: 100.w,
                    height: (_haserror) ? 38.h : 35.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD0E7FA), // Background color
                      borderRadius: BorderRadius.circular(
                        10,
                      ), // Rounded corners
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.h,
                        vertical: 3.h,
                      ),
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: 75.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TextWidget(text: "Username", fontsize: 12),
                              SizedBox(height: 0.5.h),
                              SizedBox(
                                height: 6.h,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  controller: _usernameTextController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(
                                        Icons.visibility,
                                        color: Color.fromARGB(0, 255, 255, 255),
                                        size: 12,
                                      ),
                                      onPressed: () {},
                                    ),
                                    fillColor: Colors.white,
                                    isDense: true,
                                    prefixIconColor: Colors.black,
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical:
                                          3.0, // Control the height of the input field
                                      horizontal: 20.0,
                                    ),
                                    hintStyle: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromRGBO(163, 163, 163, 1),
                                    ),
                                    hintText: 'Enter your username',
                                  ),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              const TextWidget(text: "Password", fontsize: 12),
                              SizedBox(height: 1.h),
                              SizedBox(
                                height: (_haserror) ? 10.h : 6.h,
                                child: TextFormField(
                                  controller: _passwordTextController,
                                  obscureText: !_passwordVisible,
                                  maxLines: 1,
                                  keyboardType: TextInputType.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: const Color(0xFFFFFFFF),
                                        size: 14,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                    ),
                                    isDense: true,
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1.0,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                        width: 1.0,
                                      ),
                                    ),
                                    hintStyle: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromRGBO(163, 163, 163, 1),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      vertical:
                                          3.0, // Control the height of the input field
                                      horizontal: 20.0,
                                    ),
                                    hintText: 'Enter your Password',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      setState(() {
                                        _haserror = true;
                                      });
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  ButtonWidget(
                    text: "Login",
                    onTap: () async {
                      showLoaderDialog(context);
                      if (!_signinFormKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                      if (_signinFormKey.currentState!.validate()) {
                        Map<String, dynamic> mdata;
                        mdata = {
                          'username': _usernameTextController.text,
                          'password':
                              sha1
                                  .convert(
                                    utf8.encode(_passwordTextController.text),
                                  )
                                  .toString(),
                        };
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var url = Uri.parse("$urlapi/auth/signin_sales");
                        await gucitoakAPI(url, jsonEncode(mdata))
                            .then((ress) {
                              var result = jsonDecode(ress);
                              log("100--${jsonEncode(result['code'])}");
                              if (result['code'] == 200) {
                                prefs.setString(
                                  "username",
                                  _usernameTextController.text,
                                );
                                prefs.setString(
                                  "password",
                                  sha1
                                      .convert(
                                        utf8.encode(
                                          _passwordTextController.text,
                                        ),
                                      )
                                      .toString(),
                                );
                                prefs.setString(
                                  "sales_id",
                                  result["message"]["id"].toString(),
                                );
                                Get.toNamed("/front-screen/home");
                                _signinFormKey.currentState?.reset();
                                _usernameTextController.clear();
                                _passwordTextController.clear();
                              } else {
                                var psnerr = result['message'];
                                if (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                showAlert(psnerr, context);
                              }
                            })
                            .catchError((err) {
                              log(err.toString());
                              Navigator.pop(context);
                              showAlert(
                                "Something Wrong, Please Contact Administrator",
                                context,
                              );
                            });
                      }
                    },
                    textcolor: Colors.white,
                    backcolor: Colors.blue,
                    width: 150,
                    radiuscolor: const Color(0xFFFFFFFF),
                    fontsize: 16,
                    radius: 5,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
