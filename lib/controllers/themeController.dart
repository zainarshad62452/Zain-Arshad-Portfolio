import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/color.dart';

class ThemeController extends GetxController {
  static ThemeController get to => Get.find();

  Rx<ColorModel> colorModel = ColorModel.defaultColors.obs;

  @override
  void onInit() {
    super.onInit();
    _bindColorsStream();
    _initializeDefaultColors();
  }

  void _bindColorsStream() {
    colorModel.bindStream(streamThemeColors());
  }

  Stream<ColorModel> streamThemeColors() {
    return FirebaseFirestore.instance
        .collection("theme")
        .doc("colors")
        .snapshots()
        .map((event) => ColorModel.fromMap(event.data()!));
  }

  Future<void> updateColor(String colorName, Color color) async {
    await FirebaseFirestore.instance.collection('theme').doc('colors').update({
      colorName: color.value.toString(),
    });
    _updateLocalColorModel(colorName, color);
  }

  Future<void> resetToDefaultColors() async {
    await FirebaseFirestore.instance
        .collection('theme')
        .doc('colors')
        .set(ColorModel.defaultColors.toMap())
        .then((value) => print("this is done //////////////////"));
    colorModel.value = ColorModel.defaultColors;
  }

  Future<void> _initializeDefaultColors() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('theme')
        .doc('colors')
        .get();
    if (!snapshot.exists) {
      await FirebaseFirestore.instance
          .collection('theme')
          .doc('colors')
          .set(ColorModel.defaultColors.toMap());
    }
  }

  void _updateLocalColorModel(String colorName, Color color) {
    ColorModel updatedModel = colorModel.value;
    switch (colorName) {
      case 'primaryColor':
        updatedModel = ColorModel(
          primaryColor: color,
          secondaryColor: updatedModel.secondaryColor,
          darkColor: updatedModel.darkColor,
          bodyTextColor: updatedModel.bodyTextColor,
          bgColor: updatedModel.bgColor,
        );
        break;
      case 'secondaryColor':
        updatedModel = ColorModel(
          primaryColor: updatedModel.primaryColor,
          secondaryColor: color,
          darkColor: updatedModel.darkColor,
          bodyTextColor: updatedModel.bodyTextColor,
          bgColor: updatedModel.bgColor,
        );
        break;
      case 'darkColor':
        updatedModel = ColorModel(
          primaryColor: updatedModel.primaryColor,
          secondaryColor: updatedModel.secondaryColor,
          darkColor: color,
          bodyTextColor: updatedModel.bodyTextColor,
          bgColor: updatedModel.bgColor,
        );
        break;
      case 'bodyTextColor':
        updatedModel = ColorModel(
          primaryColor: updatedModel.primaryColor,
          secondaryColor: updatedModel.secondaryColor,
          darkColor: updatedModel.darkColor,
          bodyTextColor: color,
          bgColor: updatedModel.bgColor,
        );
        break;
      case 'bgColor':
        updatedModel = ColorModel(
          primaryColor: updatedModel.primaryColor,
          secondaryColor: updatedModel.secondaryColor,
          darkColor: updatedModel.darkColor,
          bodyTextColor: updatedModel.bodyTextColor,
          bgColor: color,
        );
        break;
    }
    colorModel.value = updatedModel;
  }
}
