import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/models/user.dart';

final detailsCntr = Get.find<DetailsController>();

class DetailsController extends GetxController {
  final firestore = FirebaseFirestore.instance;
  var details = DetailsModel(
          myName: "Zain Arshad",
          title: "Software Engineer",
          residence: "Pakistan",
          city: "Mansehra",
          age: "22",
          skills: [],
          skillsPercentage: [],
          languages: [],
          languagesPercentage: [],
          cvLink: "",
          knowledges: [],
          linkedIn: "",
          upwork: "",
          fiverr: "",
          qoute: "",
          headlines: [],
          subHeadlines: "",
          tag: "",
          bannerImage:
              "https://firebasestorage.googleapis.com/v0/b/my-portfolio-9f4f4.appspot.com/o/banner_images%2F2024-05-31%2020%3A17%3A28.200808?alt=media&token=4b8280ce-5c19-4037-8221-7589c535cb9a",
          profileImage:
              "https://firebasestorage.googleapis.com/v0/b/my-portfolio-9f4f4.appspot.com/o/profile_images%2F2024-05-31%2020%3A14%3A26.036733?alt=media&token=2cf54b86-d82b-4265-8feb-3dae4c453f6f")
      .obs;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    details.bindStream(streamDetails()!);
  }

  Stream<DetailsModel> streamDetails() {
    return firestore
        .collection("details")
        .doc("AllDetails")
        .snapshots()
        .map((event) => DetailsModel.fromJson(event.data()!));
  }
}
