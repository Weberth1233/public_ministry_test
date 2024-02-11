import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/view/project/widgets/custom_modal_component.dart';
import 'package:ministerio_frontend/viewmodel/client_projects_view_model.dart';

class ProjectsClientView extends StatefulWidget {
  const ProjectsClientView({Key? key}) : super(key: key);

  @override
  State<ProjectsClientView> createState() => _ProjectsClientViewState();
}

class _ProjectsClientViewState extends State<ProjectsClientView> {
  // final controller = Get.find<ClientViewModel>();
  final controller = Get.find<ClientProjectsViewModel>();
  String name = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projetos - $name'),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: controller.projectsUser.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(
                      Icons.business_sharp,
                      color: Colors.black,
                      size: 29,
                    ),
                    title: Text(controller.projectsUser.elementAt(index).name,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                    subtitle: const Text("Clique para mais detalhes..."),
                    trailing: const Icon(
                      Icons.person_3_rounded,
                      color: Colors.purple,
                    ),
                    onTap: () {
                      Get.dialog(
                        CustomModalComponent(
                          projectModel:
                              controller.projectsUser.elementAt(index),
                        ),
                      );
                      // Get.toNamed(Routes.projectClients,
                      //     arguments:
                      //         controller.projectList.elementAt(index).users);
                    },
                  );
                },
              ),
      ),
    );
  }
}
