import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/client_model.dart';
import 'package:ministerio_frontend/repositories/project_repository_impl.dart';
import 'package:ministerio_frontend/utils/paths/paths.dart';
import '../core/failures/server_failures.dart';
import '../model/project_model.dart';

class ProjectViewModel extends GetxController {
  RxBool isLoading = false.obs;
  final ProjectRepositoryImpl baseRepository;
  RxList projectList = <ProjectModel>[].obs;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  final _userProjectList = <ClientModel>[].obs;
  RxBool selectUser = false.obs;

  bool isClientSelected(ClientModel client) =>
      _userProjectList.contains(client);

  ProjectViewModel(this.baseRepository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    getProjects();
  }

  Future<void> getProjects() async {
    isLoading.value = true;
    final result =
        await baseRepository.get(projectModelFromJson, Path.projects);
    result.fold(
      (failure) {
        APIerrorhandling(failure).errorhandling();
      },
      (value) {
        for (int i = 0; i < value.length; i++) {
          projectList.add(value[i]);
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> registerProject() async {
    isLoading.value = true;
    ProjectModel project = ProjectModel(
        name: nameController.value.text,
        description: descriptionController.value.text,
        users: _userProjectList);
    final result = await baseRepository.register(Path.createproject,
        project.toJson(), projectModelToJson, ProjectModel.fromJson);
    result.fold(
      (failure) {
        if (failure != ServerFailures.maxUserProjects) {
          APIerrorhandling(failure).errorhandling();
        }
      },
      (value) {
        _reset();
        projectList.add(value);
        Get.back();
        Get.snackbar(
          'Sucesso', "Cadastrado com sucesso!",
          snackPosition: SnackPosition.TOP, // Posição do alerta
          backgroundColor: Colors.green, // Cor de fundo do alerta
          colorText: Colors.white,
        );
        _userProjectList.clear();
      },
    );
    isLoading.value = false;
  }

  void _reset() {
    nameController.clear();
    descriptionController.clear();
  }

  void toggleClientSelection(ClientModel client, bool isSelected) {
    if (isSelected) {
      _userProjectList.add(client);
    } else {
      _userProjectList.remove(client);
    }
  }

  @override
  void dispose() {
    print("Destroir componente");
    nameController.dispose();
    descriptionController.dispose();
    projectList.clear();
    Get.delete<ProjectViewModel>();
    // TODO: implement dispose
    super.dispose();
  }
}
