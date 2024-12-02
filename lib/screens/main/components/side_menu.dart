// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:my_portfolio/constants.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:my_portfolio/controllers/detailsController.dart';
// import 'package:my_portfolio/controllers/loading.dart';
// import 'package:my_portfolio/screens/loading.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'area_info_text.dart';
// import 'coding.dart';
// import 'knowledges.dart';
// import 'my_info.dart';
// import 'skills.dart';

// import 'html_stub.dart' if (dart.library.html) 'dart:html' as html;

// class SideMenu extends StatelessWidget {
//   const SideMenu({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SafeArea(
//         child: Obx(() => Stack(
//           children: [
//             Column(
//               children: [
//                 MyInfo(),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     padding: EdgeInsets.all(defaultPadding),
//                     child: Column(
//                       children: [
//                         AreaInfoText(
//                           title: "Residence",
//                           text: detailsCntr.details.value.residence.toString(),
//                         ),
//                         AreaInfoText(
//                           title: "City",
//                           text: detailsCntr.details.value.city.toString(),
//                         ),
//                         AreaInfoText(
//                           title: "Age",
//                           text: detailsCntr.details.value.age.toString(),
//                         ),
//                         Skills(),
//                         SizedBox(height: defaultPadding),
//                         Coding(),
//                         Knowledges(),
//                         Divider(),
//                         SizedBox(height: defaultPadding / 2),
//                         TextButton(
//                           onPressed: () async {
//                             if (!kIsWeb) {
//                               // Handle non-web platform case here
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(content: Text('CV download is not supported on this platform.')),
//                               );
//                               return;
//                             }

//                             try {
//                               final byteData = await rootBundle.load('assets/images/cv.pdf'); // Load the asset
//                               final buffer = byteData.buffer.asUint8List();
//                               final blob = html.Blob([Uint8List.fromList(buffer)]);

//                               // Create a URL for the blob
//                               final url = html.Url.createObjectUrlFromBlob(blob);

//                               // Create an anchor element to trigger the download
//                               final anchor = html.AnchorElement(href: url)
//                                 ..target = 'web_browser' // Opens in a new tab or window
//                                 ..download = 'cv.pdf'; // Specify the filename

//                               // Trigger a click event on the anchor to initiate the download
//                               anchor.click();

//                               // Clean up by revoking the URL to release resources
//                               html.Url.revokeObjectUrl(url);

//                               print('CV download initiated');
//                             } catch (error) {
//                               print(error.toString());
//                             }
//                           },
//                           child: FittedBox(
//                             child: Row(
//                               children: [
//                                 Text(
//                                   "DOWNLOAD CV",
//                                   style: TextStyle(
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .bodyText1!
//                                         .color,
//                                   ),
//                                 ),
//                                 SizedBox(width: defaultPadding / 2),
//                                 SvgPicture.asset("assets/icons/download.svg")
//                               ],
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: defaultPadding),
//                           color: Color(0xFF24242E),
//                           child: Row(
//                             children: [
//                               Spacer(),
//                               IconButton(
//                                 onPressed: () async {
//                                   const url = 'https://www.linkedin.com/in/zain-arshad-4a4baa24b'; // Replace with your desired URL
//                                     await launchUrl(Uri.parse(url));

//                                 },
//                                 icon: SvgPicture.asset("assets/icons/linkedin.svg"),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   const url = 'https://www.github.com/zainarshad62452'; // Replace with your desired URL
//                                   await launchUrl(Uri.parse(url));
//                                 },
//                                 icon: SvgPicture.asset("assets/icons/github.svg"),
//                               ),
//                               IconButton(
//                                 onPressed: () async {
//                                   const url = 'https://www.fiverr.com/zainarshad44556'; // Replace with your desired URL
//                                   await launchUrl(Uri.parse(url));
//                                 },
//                                 icon: SvgPicture.asset("assets/icons/fiverr.svg"),
//                               ),
//                               Spacer(),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           !loading()?SizedBox():LoadingWidget()
//           ],
//         )),
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:my_portfolio/constants.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/screens/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'area_info_text.dart';
import 'coding.dart';
import 'knowledges.dart';
import 'my_info.dart';
import 'skills.dart';
import 'html_stub.dart' if (dart.library.html) 'dart:html' as html;

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx(() => Stack(
              children: [
                Column(
                  children: [
                    MyInfo(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Column(
                          children: [
                            AreaInfoText(
                              title: "Residence",
                              text: detailsCntr.details.value.residence
                                  .toString(),
                            ),
                            AreaInfoText(
                              title: "City",
                              text: detailsCntr.details.value.city.toString(),
                            ),
                            AreaInfoText(
                              title: "Age",
                              text: detailsCntr.details.value.age.toString(),
                            ),
                            Skills(),
                            SizedBox(height: defaultPadding),
                            Coding(),
                            Knowledges(),
                            Divider(),
                            SizedBox(height: defaultPadding / 2),
                            TextButton(
                              onPressed: () async {
                                String cvUrl = detailsCntr.details.value.cvLink
                                    .toString(); // Replace with your CV URL

                                if (!kIsWeb) {
                                  // Handle non-web platform case here
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'CV download is not supported on this platform.')),
                                  );
                                  return;
                                }
                                await launchUrl(Uri.parse(cvUrl));

                                // try {
                                //   final response = await http.get(Uri.parse(cvUrl));

                                //   if (response.statusCode == 200) {
                                //     // final blob = html.Blob([response.bodyBytes]);
                                //     // final url = html.Url.createObjectUrlFromBlob(blob);

                                //     // final anchor = html.AnchorElement(href: url)..click();
                                //     // // .attributes['download'] = 'cv.pdf'
                                //     // // .click();

                                //     // html.Url.revokeObjectUrl(url);

                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text('CV download initiated.')),
                                //     );
                                //   } else {
                                //     ScaffoldMessenger.of(context).showSnackBar(
                                //       SnackBar(content: Text('Failed to download CV.')),
                                //     );
                                //   }
                                // } catch (e) {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(content: Text('Error occurred: ${e.toString()}')),
                                //   );
                                // }
                              },
                              child: FittedBox(
                                child: Row(
                                  children: [
                                    Text(
                                      "DOWNLOAD CV",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .color,
                                      ),
                                    ),
                                    SizedBox(width: defaultPadding / 2),
                                    SvgPicture.asset(
                                        "assets/icons/download.svg")
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: defaultPadding),
                              color: Color(0xFF24242E),
                              child: Row(
                                children: [
                                  Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      String url = detailsCntr
                                          .details.value.linkedIn
                                          .toString(); // Replace with your desired URL
                                      await launchUrl(Uri.parse(url));
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/icons/linkedin.svg"),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String url = detailsCntr
                                          .details.value.github
                                          .toString(); // Replace with your desired URL
                                      await launchUrl(Uri.parse(url));
                                    },
                                    icon: SvgPicture.asset(
                                        "assets/icons/github.svg"),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String url = detailsCntr
                                          .details.value.fiverr
                                          .toString(); // Replace with your desired URL
                                      await launchUrl(Uri.parse(url));
                                    },
                                    icon: SvgPicture.asset(
                                        width: 20.0,
                                        height: 20.0,
                                        "assets/icons/fiverr.svg"),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String url = detailsCntr
                                          .details.value.upwork
                                          .toString(); // Replace with your desired URL
                                      await launchUrl(Uri.parse(url));
                                    },
                                    icon: SvgPicture.asset(
                                        width: 20.0,
                                        height: 20.0,
                                        "assets/icons/upwork.svg"),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                !loading() ? SizedBox() : LoadingWidget()
              ],
            )),
      ),
    );
  }
}
