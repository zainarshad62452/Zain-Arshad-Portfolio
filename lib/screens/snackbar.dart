import 'package:flutter/material.dart';
import 'package:get/get.dart';

snackbar(String title, String text) {
  Get.snackbar(title, text,
      snackPosition: SnackPosition.TOP, backgroundColor: Colors.white70);
}

alertSnackbar(String text) {
  Get.snackbar("Alert", text,
      snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
}
