import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../viewmodel/bottom_navigation_view_model.dart';

class BottomNavigationBarComponent extends StatelessWidget {
  BottomNavigationBarComponent({Key? key}) : super(key: key);

  final BottomNavigationBarViewModel controller =
      Get.put(BottomNavigationBarViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() => BottomNavigationBar(
          currentIndex: controller.selectedIndex.value,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Projetos',
            ),
          ],
          onTap: controller.changePage,
        ));
  }
}
