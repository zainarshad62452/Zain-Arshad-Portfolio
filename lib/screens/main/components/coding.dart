import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_portfolio/components/animated_progress_indicator.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/screens/loading.dart';

import '../../../constants.dart';

class Coding extends StatelessWidget {
  const Coding({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                  child: Text(
                    "Coding",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                detailsCntr.details.value.languages!.length == 0
                    ? SizedBox()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            detailsCntr.details.value.languages!.length,
                            (index) => AnimatedLinearProgressIndicator(
                                  percentage: detailsCntr.details.value
                                          .languagesPercentage![index] /
                                      100,
                                  label: detailsCntr
                                      .details.value.languages![index],
                                )),
                      )
              ],
            ),
            !loading() ? SizedBox() : LoadingWidget()
          ],
        ));
  }
}
