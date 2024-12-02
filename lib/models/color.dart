import 'package:flutter/material.dart';

class ColorModel {
  Color primaryColor;
  Color secondaryColor;
  Color darkColor;
  Color bodyTextColor;
  Color bgColor;

  ColorModel({
    required this.primaryColor,
    required this.secondaryColor,
    required this.darkColor,
    required this.bodyTextColor,
    required this.bgColor,
  });

  factory ColorModel.fromMap(Map<String, dynamic> map) {
    return ColorModel(
      primaryColor: Color(int.parse(map['primaryColor'])),
      secondaryColor: Color(int.parse(map['secondaryColor'])),
      darkColor: Color(int.parse(map['darkColor'])),
      bodyTextColor: Color(int.parse(map['bodyTextColor'])),
      bgColor: Color(int.parse(map['bgColor'])),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'primaryColor': primaryColor.value.toString(),
      'secondaryColor': secondaryColor.value.toString(),
      'darkColor': darkColor.value.toString(),
      'bodyTextColor': bodyTextColor.value.toString(),
      'bgColor': bgColor.value.toString(),
    };
  }

  static ColorModel get defaultColors => ColorModel(
        primaryColor: Colors.green,
        secondaryColor: Color(0xFF242430),
        darkColor: Color(0xFF191923),
        bodyTextColor: Color.fromARGB(255, 125, 129, 125),
        bgColor: Color(0xFF1E1E28),
      );
}
