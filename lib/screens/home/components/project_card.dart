// import 'package:flutter/material.dart';
// import 'package:my_portfolio/controllers/themeController.dart';
// import 'package:my_portfolio/models/Project.dart';
// import 'package:my_portfolio/responsive.dart';

// import '../../../constants.dart';

// class ProjectCard extends StatelessWidget {
//   const ProjectCard({
//     Key? key,
//     required this.project,
//   }) : super(key: key);

//   final Project project;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(defaultPadding),
//       color: ThemeController.to.colorModel.value.secondaryColor,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Row(
//           //   children: [
//           // Container(
//           //   width: 40,
//           //   height: 40,
//           //   decoration: BoxDecoration(
//           //       borderRadius: BorderRadius.circular(5.0),
//           //       image: DecorationImage(
//           //           image: NetworkImage(project.mainImage.toString()),
//           //           fit: BoxFit.cover)),
//           // ),
//           // const SizedBox(
//           //   width: 5.0,
//           // ),
//           Text(
//             project.title!,
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//             style: Theme.of(context).textTheme.subtitle2,
//           ),
//           //   ],
//           // ),
//           const Spacer(),
//           Text(
//             project.description!,
//             maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
//             overflow: TextOverflow.ellipsis,
//             style: const TextStyle(height: 1.5),
//           ),
//           const Spacer(),
//           TextButton(
//             onPressed: () {},
//             child: Text(
//               "Read More >>",
//               style: TextStyle(
//                   color: ThemeController.to.colorModel.value.primaryColor),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:my_portfolio/models/Project.dart';
import 'package:my_portfolio/responsive.dart';
import 'package:my_portfolio/screens/admin/displayAllProjects.dart';
import 'package:my_portfolio/screens/home/components/project_details_screen.dart';

import '../../../constants.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({
    Key? key,
    required this.project,
  }) : super(key: key);

  final Project project;

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) {
        setState(() {
          _isHovered = true;
          print("Mouse is hovered now");
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
          print("Mouse quit now");
        });
      },
      child: GestureDetector(
        onTap: () =>
            Get.to(() => ProjectDetailsScreen(project: widget.project)),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: const EdgeInsets.all(defaultPadding),
          color: ThemeController.to.colorModel.value.secondaryColor,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.project.title!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const Spacer(),
                  Text(
                    widget.project.description!,
                    maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(height: 1.5),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Get.to(
                          () => ProjectDetailsScreen(project: widget.project));
                    },
                    child: Text(
                      "Read More >>",
                      style: TextStyle(
                        color: ThemeController.to.colorModel.value.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                duration: Duration(milliseconds: 200),
                opacity: _isHovered ? 1.0 : 0.0,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    image: DecorationImage(
                      image: NetworkImage(widget.project.mainImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
