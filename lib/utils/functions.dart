import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:guci_apps/utils/extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

void printDebug(Object object) {
  if (kDebugMode) {
    print(object);
  }
}

int randomNumber() {
  int min = 1000;
  int max = 9999;
  final rnd = Random();
  int r = min + rnd.nextInt(max - min);
  return r;
}

Future<String> satoshiAPI(Uri url, String body) async {
  final prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var passwd = prefs.getString("password");

  String token = '';
  var headers = {'Content-Type': 'application/json'};
  if (email != null && passwd != null) {
    token = sha1.convert(utf8.encode(email + passwd)).toString();
  }

  if (token.isNotEmpty) {
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Response response = await post(url, headers: headers, body: body);
  return response.body;
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
    content: SizedBox(
        height: 9.h,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(114, 162, 138, 1))),
          ],
        )),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlert(String value, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      value,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: const Color(0xFFBFA573),
  ));
}

String capitalizeFirstLetter(String word) {
  if (word.isEmpty) {
    return word; // Return empty string if input is empty
  }
  return word[0].toUpperCase() + word.substring(1);
}