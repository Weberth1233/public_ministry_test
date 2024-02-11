import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/components/bottom_navigaionbar_component.dart';
import 'package:ministerio_frontend/viewmodel/client_projects_view_model.dart';
import 'package:ministerio_frontend/viewmodel/client_view_model.dart';
import '../../components/no_data_component.dart';
import '../../core/routes/app_routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.find<ClientViewModel>();
  final controllerClientProjects = Get.find<ClientProjectsViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Usuários'),
        centerTitle: true,
        leading: const Icon(Icons.computer_outlined),
        actions: [
          IconButton(
              onPressed: () {
                controller.clientList.clear();
                controller.getClients();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: controller.clientList.isEmpty
                    ? const NoDataComponent()
                    : ListView.builder(
                        itemCount: controller.clientList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(
                              Icons.person_pin_outlined,
                              color: Colors.black,
                              size: 29,
                            ),
                            title: Text(
                                controller.clientList.elementAt(index).name!,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            subtitle: Text(
                                controller.clientList.elementAt(index).email),
                            trailing: const Icon(
                              Icons.business,
                              color: Colors.purple,
                            ),
                            onTap: () {
                              controllerClientProjects.getClientProjects(
                                  controller.clientList.elementAt(index));
                            },
                          );
                        },
                      ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBarComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.createClient);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
