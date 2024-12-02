import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/detailsController.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/screens/loading.dart';

class MyInfo extends StatelessWidget {
  const MyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.23,
      child: Obx(() => Stack(
            children: [
              Container(
                color: Color(0xFF242430),
                child: Column(
                  children: [
                    Spacer(flex: 2),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          NetworkImage(detailsCntr.details.value.profileImage!),
                    ),
                    Spacer(),
                    Text(
                      detailsCntr.details.value.myName.toString(),
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text(
                      detailsCntr.details.value.title.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        height: 1.5,
                      ),
                    ),
                    Spacer(flex: 2),
                  ],
                ),
              ),
              !loading() ? SizedBox() : LoadingWidget()
            ],
          )),
    );
  }
}
