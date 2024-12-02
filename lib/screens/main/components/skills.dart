import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:my_portfolio/components/animated_progress_indicator.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/screens/loading.dart';

import '../../../constants.dart';

class Skills extends StatelessWidget {
  const Skills({
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
                    "Skills",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Row(
                    children: List.generate(
                  detailsCntr.details.value.skills!.length,
                  (index) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: AnimatedCircularProgressIndicator(
                        percentage:
                            detailsCntr.details.value.skillsPercentage![index] /
                                100,
                        label:
                            detailsCntr.details.value.skills![index].toString(),
                      ),
                    ),
                  ),
                )),
              ],
            ),
            !loading() ? SizedBox() : LoadingWidget()
          ],
        ));
  }
}
