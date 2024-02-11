import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/view/project/widgets/custom_modal_component.dart';
import 'package:ministerio_frontend/components/bottom_navigaionbar_component.dart';
import 'package:ministerio_frontend/viewmodel/project_view_model.dart';
import 'package:lottie/lottie.dart';
import '../../components/no_data_component.dart';
import '../../core/routes/app_routes.dart';

class ProjectView extends StatefulWidget {
  const ProjectView({Key? key}) : super(key: key);

  @override
  State<ProjectView> createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView> {
  // final controller = Get.find<ClientViewModel>();
  final controller = Get.find<ProjectViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Projetos'),
        centerTitle: true,
        leading: const Icon(Icons.computer_outlined),
        actions: [
          IconButton(
              onPressed: () {
                controller.projectList.clear();
                controller.getProjects();
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
                child: controller.projectList.isEmpty
                    ? const NoDataComponent()
                    : ListView.builder(
                        itemCount: controller.projectList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: const Icon(
                              Icons.business_sharp,
                              color: Colors.black,
                              size: 29,
                            ),
                            title: Text(
                                controller.projectList.elementAt(index).name,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600)),
                            subtitle:
                                const Text("Clique para mais detalhes..."),
                            trailing: const Icon(
                              Icons.person_3_rounded,
                              color: Colors.purple,
                            ),
                            onTap: () {
                              Get.dialog(
                                CustomModalComponent(
                                  projectModel:
                                      controller.projectList.elementAt(index),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
      bottomNavigationBar: BottomNavigationBarComponent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicione o código a ser executado quando o botão for pressionado
          Get.toNamed(Routes.createProject);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
