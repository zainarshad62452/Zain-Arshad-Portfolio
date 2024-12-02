import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/dataController.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/controllers/recommendationController.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:my_portfolio/screens/admin/adminMainScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/screens/home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC7WlfRGpXAPpbmRO2NC_ONYySKolgajxE",
            authDomain: "my-portfolio-9f4f4.firebaseapp.com",
            projectId: "my-portfolio-9f4f4",
            storageBucket: "my-portfolio-9f4f4.appspot.com",
            messagingSenderId: "173983808216",
            appId: "1:173983808216:web:d79fc766e78867863675ad",
            measurementId: "G-L1DKEDVG97"));
  } else {
    await Firebase.initializeApp();
  }

  Get.put(LoadingController(), permanent: true);
  Get.put(DataController(), permanent: true);
  Get.put(DetailsController(), permanent: true);
  Get.put(ThemeController(), permanent: true); 
  Get.put(RecommendationController(), permanent: true); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zain Arshad's Portfolio",
      theme: ThemeData.dark().copyWith(
        primaryColor: ThemeController.to.colorModel.value.primaryColor,
        scaffoldBackgroundColor: ThemeController.to.colorModel.value.bgColor,
        canvasColor: ThemeController.to.colorModel.value.bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white)
            .copyWith(
              bodyText1: TextStyle(color: ThemeController.to.colorModel.value.bodyTextColor),
              bodyText2: TextStyle(color: ThemeController.to.colorModel.value.bodyTextColor),
            ),
      ),
      // home: AdminMainScreen(),
      home: const HomeScreen(),
    ));
  }
}
