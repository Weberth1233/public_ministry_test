import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/project_model.dart';

class CustomModalComponent extends StatelessWidget {
  final ProjectModel projectModel;

  const CustomModalComponent({Key? key, required this.projectModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              projectModel.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(projectModel.description),
          ),
          const Divider(),
          ListView.builder(
            shrinkWrap: true,
            itemCount: projectModel.users.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  projectModel.users.elementAt(index).name,
                ),
                subtitle: Text(
                  "Email: ${projectModel.users.elementAt(index).email} | Telefone: ${projectModel.users.elementAt(index).phone}",
                ),
                onTap: () {
                  Get.defaultDialog(
                    title: 'Dados do usuário',
                    titlePadding: const EdgeInsets.all(8.0),
                    middleText:
                        "Email: ${projectModel.users.elementAt(index).email} | Telefone: ${projectModel.users.elementAt(index).phone}",
                  );
                },
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Get.back(); // Fechar o modal
              },
              child: const Text('Fechar'),
            ),
          ),
        ],
      ),
    );
  }
}
