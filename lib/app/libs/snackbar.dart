import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Snackbar {
  static show({@required String message, @required Color color}) {
    Get.rawSnackbar(
        messageText: Text(message,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        backgroundColor: color,
        duration: Duration(seconds: 5),
        snackPosition: SnackPosition.BOTTOM);
  }
}
