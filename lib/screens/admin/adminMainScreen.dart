import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:my_portfolio/screens/admin/addProjectScreen.dart';
import 'package:my_portfolio/screens/admin/detailsFormScreen.dart';
import 'package:my_portfolio/screens/admin/detailsScreem.dart';
import 'package:my_portfolio/screens/admin/displayAllProjects.dart';
import 'package:my_portfolio/screens/admin/recommendationListScreen.dart';
import 'package:my_portfolio/screens/theme/colorPickerScree.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Project Manager')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Add Project'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectFormScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Manage Projects'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProjectsListScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Manage Details'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Manage Recommendations'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecommendationsListScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Manage Theme Colors'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ColorPickerScreen()),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Reset Theme Colors To Default'),
              onPressed: () async {
                // launchUrl(Uri.parse("https://my-portfolio-9f4f4.web.app/#/"));
                await ThemeController.to.resetToDefaultColors();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Open Portfolio'),
              onPressed: () async {
                launchUrl(Uri.parse("https://my-portfolio-9f4f4.web.app/#/"));
                // await ThemeController.to.resetToDefaultColors();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Copy Porfolio Link'),
              onPressed: () {
                Clipboard.setData(
                        ClipboardData(text: "https://my-portfolio-9f4f4.web.app/#/"))
                    .then((_) {
                  // Show a snackbar to the user that text is copied
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Link copied to clipboard')),
                  );
                }).catchError((error) {
                  print('Failed to copy text to clipboard: $error');
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
