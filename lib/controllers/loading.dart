import 'package:get/get.dart';
final loading = Get.find<LoadingController>().isLoading;

class LoadingController extends GetxController {
  final Rx<bool> isLoading = false.obs;
  @override
  void onInit() {
    isLoading(false);
    super.onInit();
  }
}