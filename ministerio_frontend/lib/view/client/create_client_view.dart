import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/model/client_model.dart';

import '../../viewmodel/client_view_model.dart';

class CreateClienteView extends StatefulWidget {
  const CreateClienteView({super.key});

  @override
  State<CreateClienteView> createState() => _CreateClienteViewState();
}

class _CreateClienteViewState extends State<CreateClienteView> {
  final controller = Get.find<ClientViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar usuários'),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                      labelText: "Digite o nome do usuário",
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.emailController,
                  decoration: const InputDecoration(
                      labelText: "Digite o email",
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 10,
              ),
              TextField(
                  controller: controller.phoneController,
                  decoration: const InputDecoration(
                      labelText: "Digite telefone",
                      border: OutlineInputBorder())),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    print(controller.nameController.text);
                    controller.registerClient();
                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.purple),
                  ),
                  child: const Text(
                    "Cadastrar",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
