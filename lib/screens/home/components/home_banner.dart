import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/controllers/themeController.dart';
import 'package:my_portfolio/responsive.dart';
import 'package:my_portfolio/screens/loading.dart';

import '../../../constants.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            AspectRatio(
              aspectRatio: Responsive.isMobile(context) ? 2.5 : 3,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    detailsCntr.details.value.bannerImage!,
                    fit: BoxFit.cover,
                    height: double.maxFinite,
                    width: double.maxFinite,
                  ),
                  Container(color: darkColor.withOpacity(0.66)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          detailsCntr.details.value.qoute == null
                              ? "Loading Data..."
                              : detailsCntr.details.value.qoute.toString(),
                          style: Responsive.isDesktop(context)
                              ? Theme.of(context).textTheme.headline3!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )
                              : Theme.of(context).textTheme.headline5!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                        ),
                        if (Responsive.isMobileLarge(context))
                          const SizedBox(height: defaultPadding / 2),
                        const MyBuildAnimatedText(),
                        const SizedBox(height: defaultPadding),
                        if (!Responsive.isMobileLarge(context))
                          ElevatedButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 2,
                                  vertical: defaultPadding),
                              backgroundColor: ThemeController.to.colorModel.value.primaryColor,
                            ),
                            child: const Text(
                              "EXPLORE NOW",
                              style: TextStyle(color: darkColor),
                            ),
                          ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            !loading() ? const SizedBox() : LoadingWidget(),
          ],
        ));
  }
}

class MyBuildAnimatedText extends StatelessWidget {
  const MyBuildAnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      // it applies same style to all the widgets under it
      style: Theme.of(context).textTheme.subtitle1!,
      maxLines: 1,
      child: Row(
        children: [
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(width: defaultPadding / 2),
          const Text("I build "),
          Responsive.isMobile(context)
              ? const Expanded(child: AnimatedText())
              : const AnimatedText(),
          if (!Responsive.isMobileLarge(context))
            const SizedBox(width: defaultPadding / 2),
          if (!Responsive.isMobileLarge(context)) const FlutterCodedText(),
        ],
      ),
    );
  }
}

class AnimatedText extends StatelessWidget {
  const AnimatedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return detailsCntr.details.value.headlines!.length==0?const SizedBox():AnimatedTextKit(
      animatedTexts: detailsCntr.details.value.headlines!
          .map((e) => TyperAnimatedText(
                e,
                speed: const Duration(milliseconds: 60),
              ))
          .toList(),
    );
  }
}

class FlutterCodedText extends StatelessWidget {
  const FlutterCodedText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: "<",
        children: [
          TextSpan(
            text: "flutter",
            style: TextStyle(color: ThemeController.to.colorModel.value.primaryColor),
          ),
          const TextSpan(text: ">"),
        ],
      ),
    );
  }
}
