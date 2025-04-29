import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guci_apps/utils/globalvar.dart';
import 'package:guci_apps/views/widget/bottomnav_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _isError = false;
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    String? salesId = prefs.getString("sales_id");

    if (username != null &&
        salesId != null &&
        username.isNotEmpty &&
        salesId.isNotEmpty) {
      Get.offAllNamed("/front-screen/login");
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    // initialize the controller
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (_) {
                setState(() {
                  _isLoading = true;
                  _isError = false;
                });
              },
              onPageFinished: (_) {
                setState(() {
                  _isLoading = false;
                });
              },
              onWebResourceError: (err) {
                setState(() {
                  _isLoading = false;
                  _isError = true;
                });
              },
            ),
          )
          // replace with your real URL
          ..loadRequest(Uri.parse("$urlapi/mobile/profile"));
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    _controller.reload();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // 1) If we had an error, show a retry button
            if (_isError)
              Center(
                child: ElevatedButton(
                  onPressed: _reload,
                  child: const Text('Retry'),
                ),
              )
            else
              // 2) Otherwise show the WebView
              WebViewWidget(controller: _controller),

            // 3) And while loading, overlay a spinner
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
        bottomNavigationBar: const Gucinav(number: 1),
      ),
    );
  }
}
