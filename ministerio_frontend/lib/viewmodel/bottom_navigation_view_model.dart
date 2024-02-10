import 'package:get/get.dart';
import 'package:ministerio_frontend/core/routes/app_routes.dart';

class BottomNavigationBarViewModel extends GetxController {
  var selectedIndex = 0.obs;

  final List<String> routes = [Routes.home, Routes.projects];

  void changePage(int index) {
    selectedIndex.value = index;
    Get.toNamed(routes[index]);
  }
}
