import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/controllers/recommendationController.dart';
import 'package:my_portfolio/models/Recommendation.dart';
import 'package:my_portfolio/screens/home/components/recommendation_card.dart';
import 'package:my_portfolio/screens/loading.dart';

import '../../../constants.dart';

class Recommendations extends StatelessWidget {
  const Recommendations({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: Obx(() => Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Certificates & Experiences",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: defaultPadding),
                  recomCntr.allRecommendations!.value.isNotEmpty
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              // ignore: invalid_use_of_protected_member
                              recomCntr.allRecommendations!.value.length,
                              (index) => Padding(
                                padding: const EdgeInsets.only(
                                    right: defaultPadding),
                                child: RecommendationCard(
                                  recommendation: recomCntr
                                      .allRecommendations!.value[index],
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              !loading() ? SizedBox() : LoadingWidget()
            ],
          )),
    );
  }
}
