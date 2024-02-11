import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/project_model.dart';
import 'package:ministerio_frontend/utils/paths/paths.dart';
import 'package:ministerio_frontend/model/client_model.dart';
import 'package:ministerio_frontend/repositories/base_repository.dart';
import '../core/failures/server_failures.dart';
import '../core/routes/app_routes.dart';

class ClientProjectsViewModel extends GetxController {
  RxBool isLoading = false.obs;
  final BaseRepository baseRepository;
  // Criar uma lista para armazenar os ids dos usuários dos projetos
  RxList<ProjectModel> projectsUser = <ProjectModel>[].obs;
  //Rodar for e pega os projetos onde os id dos usuários e apresentar por meio de um modal
  ClientProjectsViewModel(this.baseRepository);
  RxBool isitem = false.obs;

  Future<void> getClientProjects(ClientModel clientModel) async {
    projectsUser.clear();
    isLoading.value = true;

    final result = await baseRepository.get(
        projectModelFromJson, "${Path.userProjects}/${clientModel.id}");

    result.fold(
      (failure) {
        APIerrorhandling(failure).errorhandling();
      },
      (value) {
        for (int i = 0; i < value.length; i++) {
          projectsUser.add(value[i]);
        }
        if (projectsUser.isNotEmpty) {
          Get.toNamed(Routes.projectsClient, arguments: clientModel.name);
        } else {
          Get.defaultDialog(
              title: "Atenção!",
              middleText: "Cadastre um projeto para ${clientModel.name}",
              backgroundColor: Colors.yellow);
        }
      },
    );
    isLoading.value = false;
  }

  @override
  void dispose() {
    projectsUser.clear();
    Get.delete<
        ClientProjectsViewModel>(); // Liberar recursos associados à instância
    // TODO: implement dispose
    super.dispose();
  }
}
