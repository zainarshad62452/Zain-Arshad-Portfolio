import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_portfolio/controllers/loading.dart';
import 'package:my_portfolio/models/Recommendation.dart';





final recomCntr = Get.find<RecommendationController>();

class RecommendationController extends GetxController {
  RxList<Recommendation>? allRecommendations = <Recommendation>[].obs;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    allRecommendations!.bindStream(streamAllRecommendations()!);
  }

    Stream<List<Recommendation>>? streamAllRecommendations() {
    try {
      return FirebaseFirestore.instance.collection('recommendations').snapshots().map((event) {
        loading(false);
        List<Recommendation> list = [];
        event.docs.forEach((element) {
          final admin = Recommendation.fromJson(element.data());
          list.add(admin);
        });
        loading(false);
        return list;
      });
    } catch (e) {
      loading(false);
      return null;
    }
  }
}
