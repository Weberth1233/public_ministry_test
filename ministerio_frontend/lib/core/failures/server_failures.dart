import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ServerFailures {
  notFound,
  serverError,
  userAlreadyExists,
  blankField,
  invalidEmail,
  maxProjects,
  maxUserProjects
}

class APIerrorhandling {
  final ServerFailures serverFailures;
  APIerrorhandling(this.serverFailures);

  void errorhandling({String? message}) {
    switch (serverFailures) {
      case ServerFailures.userAlreadyExists:
        // TODO: Handle this case.
        Get.defaultDialog(
          backgroundColor: Colors.yellow,
          title: 'Alerta!',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'Nome já existe!',
        );
        break;
      case ServerFailures.blankField:
        // TODO: Handle this case.
        Get.defaultDialog(
          backgroundColor: Colors.yellow,
          title: 'Alerta!',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'Nome em branco!',
        );
        break;
      case ServerFailures.notFound:
        Get.defaultDialog(
          backgroundColor: Colors.red,
          title: 'Erro ao realizar a requisição',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'Não foram encontrados usuarios',
        );
        break;
      case ServerFailures.invalidEmail:
        Get.defaultDialog(
          backgroundColor: Colors.yellow,
          title: 'Alerta!',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'Email inválido',
        );
        break;
      case ServerFailures.serverError:
        Get.defaultDialog(
          backgroundColor: Colors.red,
          title: 'Erro ao realizar a requisição',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'Ocorreu um erro com a API',
        );
        break;
      case ServerFailures.maxProjects:
        // TODO: Handle this case.
        Get.defaultDialog(
          backgroundColor: Colors.yellow,
          title: 'Alerta!',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: 'O maximo de usuários em um projeto é 5',
        );
        break;

      case ServerFailures.maxUserProjects:
        // TODO: Handle this case.
        Get.defaultDialog(
          backgroundColor: Colors.yellow,
          title: 'Alerta!',
          titleStyle: const TextStyle(fontWeight: FontWeight.bold),
          middleText: message!,
        );
        break;
    }
  }
}
