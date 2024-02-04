import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDialogs {
  static success({required String msg}) {
    Get.snackbar('Success', msg,
        colorText: Colors.white, backgroundColor: Colors.cyan.withOpacity(.2));
  }

// Error Function
  static error({required String msg}) {
    Get.snackbar('Error', msg,
        colorText: Colors.white,
        backgroundColor: Colors.black45.withOpacity(.3));
  }

// Info Function
  static info({required String msg}) {
    Get.snackbar('Info', msg,
        colorText: Colors.white,
        backgroundColor: Colors.black45.withOpacity(.3));
  }

  // progress function
  static showProgress() {
    Get.dialog(Center(
      child: CircularProgressIndicator(
        strokeWidth: 2,
      ),
    ));
  }
}
