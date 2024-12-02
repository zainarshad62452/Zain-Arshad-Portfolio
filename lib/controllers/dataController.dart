import 'package:get/get.dart';
import 'package:my_portfolio/models/Project.dart';
import 'package:my_portfolio/services/dataServices.dart';





final dataCntr = Get.find<DataController>();

class DataController extends GetxController {
  RxList<Project>? allProjects = <Project>[].obs;
  @override
  void onReady() {
    initAdminStream();
  }

  initAdminStream() async {
    allProjects!.bindStream(DataServices().streamAllProjects()!);
  }
}
