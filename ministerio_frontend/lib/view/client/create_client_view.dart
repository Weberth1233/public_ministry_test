import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/components/elevation_button_component.dart';
import '../../components/text_field_component.dart';
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
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFielComponent(
                  label: 'Digite o nome do usuário',
                  textEditingController: controller.nameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFielComponent(
                  label: 'Digite o email',
                  textEditingController: controller.emailController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFielComponent(
                  label: 'Digite seu telefone',
                  textEditingController: controller.phoneController,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 50,
                  child: ElevationButtonComponent(
                      action: () {
                        controller.registerClient();
                      },
                      label: 'Cadastro'))
            ],
          ),
        ),
      ),
    );
  }
}
