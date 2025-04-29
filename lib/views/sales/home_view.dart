import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:guci_apps/utils/globalvar.dart';
import 'package:http/http.dart' as http;
import 'package:guci_apps/views/widget/bottomnav_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  WebViewController? _controller;
  bool _isLoading = true;
  bool _isError = false;
  Position? _startSpot;
  Timer? _stayTimer;
  late StreamSubscription<Position> _positionSubscription;
  String? sales_id;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString("username");
    String? salesId = prefs.getString("sales_id");

    if (username == null ||
        salesId == null ||
        username.isEmpty ||
        salesId.isEmpty) {
      Get.offAllNamed("/front-screen/login");
    }
    setState(() {
      sales_id = salesId;
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
                onWebResourceError: (_) {
                  setState(() {
                    _isLoading = false;
                    _isError = true;
                  });
                },
              ),
            )
            ..loadRequest(
              Uri.parse("$urlapi/mobile/dashboard"),
              headers: {'sales-id': sales_id!},
            );
    });
  }

  @override
  void dispose() {
    _positionSubscription.cancel();
    _stayTimer?.cancel();
    super.dispose();
  }

  void _startLocationTracking() {
    _positionSubscription = Geolocator.getPositionStream().listen((position) {
      _handlePositionUpdate(position);
    });
  }

  void _handlePositionUpdate(Position position) {
    final double distance =
        _startSpot == null
            ? 0
            : Geolocator.distanceBetween(
              _startSpot!.latitude,
              _startSpot!.longitude,
              position.latitude,
              position.longitude,
            );

    _sendRealTimeLocation(position);

    if (_startSpot == null || distance > 20) {
      // User moved to new spot
      _startSpot = position;
      _stayTimer?.cancel();
      _stayTimer = null;
    } else {
      // User still in same area
      _stayTimer ??= Timer(const Duration(minutes: 5), () {
        _saveLocation(position);
        _stayTimer = null;
      });
    }
  }

  Future<void> _sendRealTimeLocation(Position pos) async {
    try {
      final uri = Uri.parse('$urlapi/location/realtime');
      await http.post(
        uri,
        body: {
          'lat': pos.latitude.toString(),
          'lng': pos.longitude.toString(),
          'sales_id': sales_id,
        },
      );
    } catch (e) {
      debugPrint('Failed to send real-time location: $e');
    }
  }

  Future<void> _saveLocation(Position pos) async {
    try {
      final uri = Uri.parse('$urlapi/location/save_location');
      await http.post(
        uri,
        body: {
          'lat': pos.latitude.toString(),
          'lng': pos.longitude.toString(),
          'sales_id': sales_id,
        },
      );
    } catch (e) {
      debugPrint('Failed to save location: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    checkLoginStatus().then((_) {
      _startLocationTracking();
    });
  }

  void _reload() {
    setState(() {
      _isLoading = true;
      _isError = false;
    });
    _controller!.reload();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            _isError
                ? Center(
                  child: ElevatedButton(
                    onPressed: _reload,
                    child: Text('Retry'),
                  ),
                )
                : Stack(
                  children: [
                    _controller == null
                        ? const Center(
                          child: CircularProgressIndicator(),
                        ) // Show a loading indicator while _controller is null
                        : WebViewWidget(controller: _controller!),
                    if (_isLoading) Center(child: CircularProgressIndicator()),
                  ],
                ),
        bottomNavigationBar: const Gucinav(number: 0),
      ),
    );
  }
}
