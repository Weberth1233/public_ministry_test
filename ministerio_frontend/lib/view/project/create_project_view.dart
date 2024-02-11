import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/components/elevation_button_component.dart';
import 'package:ministerio_frontend/components/text_field_component.dart';
import 'package:ministerio_frontend/viewmodel/project_view_model.dart';
import '../../viewmodel/client_view_model.dart';

class CreateProjecView extends StatelessWidget {
  const CreateProjecView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerUser = Get.find<ClientViewModel>();
    final controllerProject = Get.find<ProjectViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar projeto'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFielComponent(
                  textEditingController: controllerProject.nameController,
                  label: "Digite o nome do projeto"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFielComponent(
                  textEditingController:
                      controllerProject.descriptionController,
                  label: "Digite a descrição do projeto"),
            ),
            const Text(
              "Membros do projeto",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            Expanded(
              child: Obx(() => controllerUser.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: controllerUser.clientList.length,
                      itemBuilder: (context, index) {
                        final client = controllerUser.clientList[index];
                        return ListTile(
                          leading: Obx(() => Checkbox(
                                activeColor: Colors.purple,
                                value:
                                    controllerProject.isClientSelected(client),
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    controllerProject.toggleClientSelection(
                                        client, value);
                                  }
                                },
                              )),
                          title: Text(
                            client.name,
                            style: const TextStyle(fontSize: 14),
                          ),
                          trailing: const Icon(
                            Icons.emoji_people,
                            color: Colors.purple,
                          ),
                          autofocus: true,
                        );
                      },
                    )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                  height: 50,
                  child: ElevationButtonComponent(
                      action: () {
                        controllerProject.registerProject();
                      },
                      label: 'Cadastrar')),
            ),
          ],
        ),
      ),
    );
  }
}
