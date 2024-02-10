import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/project_model.dart';
import 'package:ministerio_frontend/utils/paths/paths.dart';
import 'package:ministerio_frontend/model/client_model.dart';
import 'package:ministerio_frontend/repositories/base_repository.dart';
import '../core/failures/server_failures.dart';

class ClientViewModel extends GetxController {
  RxBool isLoading = false.obs;
  final BaseRepository baseRepository;
  RxList clientList = <ClientModel>[].obs;
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  // Criar uma lista para armazenar os ids dos usuários dos projetos
  RxList<ProjectModel> projectsUser = <ProjectModel>[].obs;
  //Rodar for e pega os projetos onde os id dos usuários e apresentar por meio de um modal

  ClientViewModel(this.baseRepository);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    getClients();
  }

  Future<void> getClients() async {
    isLoading.value = true;
    final result = await baseRepository.get(userModelFromJson, Path.users);

    result.fold(
      (failure) {
        APIerrorhandling(failure).errorhandling();
      },
      (value) {
        for (int i = 0; i < value.length; i++) {
          clientList.add(value[i]);
        }
      },
    );
    isLoading.value = false;
  }

  Future<void> registerClient() async {
    isLoading.value = true;

    ClientModel clientModel = ClientModel(
        name: nameController.value.text,
        phone: phoneController.value.text,
        email: emailController.value.text);

    final result = await baseRepository.register(Path.createuser,
        clientModel.toJson(), userModelToJson, ClientModel.fromJson);

    result.fold(
      (failure) {
        APIerrorhandling(failure).errorhandling();
      },
      (value) {
        _reset();
        clientList.add(value);
        // Cor do texto do alerta);
        Get.back();
        Get.snackbar(
          'Sucesso', "Cadastrado com sucesso!",
          snackPosition: SnackPosition.TOP, // Posição do alerta
          backgroundColor: Colors.green, // Cor de fundo do alerta
          colorText: Colors.white,
        );
      },
    );
    isLoading.value = false;
  }

  void _reset() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
  }

  @override
  void dispose() {
    print("Destroir componente");
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    clientList.clear();
    projectsUser.clear();
    Get.delete<ClientViewModel>(); // Liberar recursos associados à instância
    // TODO: implement dispose
    super.dispose();
  }
}
