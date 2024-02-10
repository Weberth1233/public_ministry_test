import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/project_model.dart';

class CustomModalUserComponent extends StatelessWidget {
  final RxList<ProjectModel> projectModel;

  const CustomModalUserComponent({Key? key, required this.projectModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: projectModel.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  minLeadingWidth: 2,
                  leading: const Icon(
                    Icons.business_sharp,
                    color: Colors.black,
                    size: 29,
                  ),
                  title: Text(
                    projectModel[index].name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.person_3_rounded,
                    color: Colors.purple,
                  ),
                  autofocus: true,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () {
              Get.back(); // Fechar o modal
            },
            child: const Text('Fechar'),
          ),
        ),
      ],
    );
  }
}
