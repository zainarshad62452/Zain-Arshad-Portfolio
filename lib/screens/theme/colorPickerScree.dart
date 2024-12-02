import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:my_portfolio/screens/loading.dart';

class ColorPickerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Picker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Stack(
          children: [
            Column(
              children: [
                ColorTile(
                  color: ThemeController.to.colorModel.value.primaryColor,
                  title: 'Primary Color',
                  onColorChanged: (color) {
                    ThemeController.to.updateColor('primaryColor', color);
                  },
                ),
                ColorTile(
                  color: ThemeController.to.colorModel.value.secondaryColor,
                  title: 'Secondary Color',
                  onColorChanged: (color) {
                    ThemeController.to.updateColor('secondaryColor', color);
                  },
                ),
                ColorTile(
                  color: ThemeController.to.colorModel.value.darkColor,
                  title: 'Dark Color',
                  onColorChanged: (color) {
                    ThemeController.to.updateColor('darkColor', color);
                  },
                ),
                ColorTile(
                  color: ThemeController.to.colorModel.value.bodyTextColor,
                  title: 'Body Text Color',
                  onColorChanged: (color) {
                    ThemeController.to.updateColor('bodyTextColor', color);
                  },
                ),
                ColorTile(
                  color: ThemeController.to.colorModel.value.bgColor,
                  title: 'Background Color',
                  onColorChanged: (color) {
                    ThemeController.to.updateColor('bgColor', color);
                  },
                ),
              ],
            ),
            !loading() ? SizedBox() : LoadingWidget(),
          ],
        )),
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  final String title;
  final ValueChanged<Color> onColorChanged;

  const ColorTile({
    Key? key,
    required this.color,
    required this.title,
    required this.onColorChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: CircleAvatar(
        backgroundColor: color,
      ),
      onTap: () async {
        Color pickedColor = color;
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Pick a color'),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: color,
                onColorChanged: (newColor) {
                  pickedColor = newColor;
                },
                showLabel: true,
                pickerAreaHeightPercent: 0.8,
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Got it'),
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
        );

        // ignore: unnecessary_null_comparison
        if (pickedColor != null && pickedColor != color) {
          onColorChanged(pickedColor);
        }
      },
    );
  }
}
