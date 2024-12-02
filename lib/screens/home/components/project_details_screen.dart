import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/Project.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_portfolio/screens/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailsScreen({Key? key, required this.project})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double titleFontSize = screenWidth > 800 ? 24 : 18;
    double subtitleFontSize = screenWidth > 800 ? 20 : 16;
    double textFontSize = screenWidth > 800 ? 16 : 14;

    List<String> skills = project.skillsUsed?.split(',') ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          project.title ?? "Project Details",
          style: TextStyle(fontSize: titleFontSize),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.09,
                    height: MediaQuery.of(context).size.width * 0.09,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          project.mainImage ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title ?? '',
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (screenWidth > 600)
                          Row(
                            children: [
                              Tooltip(
                                message: 'View Code',
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.github,
                                    size: textFontSize + 4,
                                    color: ThemeController
                                        .to.colorModel.value.bodyTextColor,
                                  ),
                                  onPressed: () {
                                    project.sourceCodeUrl == ""
                                        ? snackbar("Oppsss!",
                                            "Source code is not available!.")
                                        : launchUrl(
                                            Uri.parse(project.sourceCodeUrl!));
                                    // Navigate to code repository
                                  },
                                ),
                              ),
                              const SizedBox(width: 8),
                              Tooltip(
                                message: 'Download App',
                                child: IconButton(
                                  icon: Icon(
                                    FontAwesomeIcons.download,
                                    size: textFontSize + 4,
                                    color: ThemeController
                                        .to.colorModel.value.bodyTextColor,
                                  ),
                                  onPressed: () {
                                    project.projectUrl == ""
                                        ? snackbar("Oppsss!",
                                            "Download is not available!.")
                                        : launchUrl(
                                            Uri.parse(project.projectUrl!));
                                  },
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (screenWidth <= 600) ...[
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'View Code',
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.github,
                          size: textFontSize + 4,
                          color:
                              ThemeController.to.colorModel.value.bodyTextColor,
                        ),
                        onPressed: () {
                          project.sourceCodeUrl == ""
                              ? snackbar(
                                  "Oppsss!", "Source code is not available!.")
                              : launchUrl(Uri.parse(project.sourceCodeUrl!));
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Tooltip(
                      message: 'Download App',
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.download,
                          size: textFontSize + 4,
                          color:
                              ThemeController.to.colorModel.value.bodyTextColor,
                        ),
                        onPressed: () {
                          project.projectUrl == ""
                              ? snackbar(
                                  "Oppsss!", "Download is not available!.")
                              : launchUrl(Uri.parse(project.projectUrl!));

                          // Download the app
                        },
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 16),
              Text(
                "Project Images",
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 0.25,
                      enlargeCenterPage: true,
                    ),
                    items: project.projectImages?.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            image,
                            width: MediaQuery.of(context).size.width,
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project.description ?? '',
                style: TextStyle(fontSize: textFontSize),
              ),
              const SizedBox(height: 16),
              Text(
                "Technologies Used",
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: skills.map((skill) {
                  String emoji = '';
                  if (skill.toLowerCase().contains('flutter')) {
                    emoji = '🖥️';
                  } else if (skill.toLowerCase().contains('dart')) {
                    emoji = '🎯';
                  } else if (skill.toLowerCase().contains('firebase')) {
                    emoji = '🔥';
                  } else if (skill.toLowerCase().contains('map')) {
                    emoji = '🗺️';
                  } else if (skill.toLowerCase().contains('android')) {
                    emoji = '📱';
                  } else if (skill.toLowerCase().contains('messaging')) {
                    emoji = '✉️';
                  } else if (skill.toLowerCase().contains('api')) {
                    emoji = '🔌';
                  } else {
                    emoji = '🔧';
                  }
                  return Text(
                    '$emoji $skill',
                    style: TextStyle(fontSize: textFontSize),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
