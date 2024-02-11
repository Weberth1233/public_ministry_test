import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:ministerio_frontend/core/failures/server_failures.dart';
import 'package:ministerio_frontend/model/base_model.dart';
import 'package:http/http.dart' as http;
import '../api_constants.dart';

class BaseRepository {
  BaseRepository();

  Future<Either<ServerFailures, List<T>>> get<T extends BaseModel>(
      List<T> Function(String) fromJson, String path) async {
    try {
      List<T> objects = [];
      //Chamando URL passando path
      var url = Uri.parse('${ApiConstants.baseUrl}$path/');

      var response = await http.get(url);
      if (response.statusCode == 200) {
        //Aplicando correção de caracteres especias com o utf-8
        var responseBody = utf8.decode(response.bodyBytes);
        objects = fromJson(responseBody);
        // Ordenando a lista por ordem alfabética
        objects.sort((a, b) => a.name.compareTo(b.name));

        return right(objects);
      } else if (response.statusCode == 400) {
        return left(ServerFailures.notFound);
      }
    } catch (e) {
      e.printError();
      log(e.toString());
    }
    return left(ServerFailures.serverError);
  }

  Future<Either<ServerFailures, T>> register<T extends BaseModel>(
    String path,
    Map<String, dynamic> mapObject,
    Function fuctionEncode,
    Function fuctionDecode,
  ) async {
    try {
      //Passando a url
      var url = Uri.parse('${ApiConstants.baseUrl}$path/');
      //Transfornando meu map de objetos em uma String a partir de uma função que pega um map e usa a função json.encode para passar para essa string bodyJson
      String bodyJson = fuctionEncode(mapObject);
      print(bodyJson);
      //Criando a requisição do metodo post
      var response = await http.post(url,
          headers: {
            'Content-Type':
                'application/json', // Defina o tipo de conteúdo como JSON
          },
          //Passando o corpo da requisição
          body: bodyJson);
      //Verificando status da resposta da api
      if (response.statusCode == 201) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //Usando a função decode que está nas minhas classes para transformar o json em um objeto do tipo Generico
        return right(fuctionDecode(jsonResponse));
      } else if (response.statusCode == 400) {
        // Decodifique o corpo da resposta usando Utf8Decoder para tratar caracteres com acentos corretamente
        var responseBody =
            json.decode(const Utf8Decoder().convert(response.bodyBytes));
        if (responseBody.containsKey("name") &&
            responseBody["name"].contains("user com este name já existe.")) {
          return left(ServerFailures.userAlreadyExists);
        } else if (responseBody.containsKey("name") &&
            responseBody["name"].contains("project com este name já existe.")) {
          return left(ServerFailures.userAlreadyExists);
        } else if (responseBody.containsKey("name") &&
            responseBody["name"]
                .contains("Este campo não pode ser em branco.")) {
          return left(ServerFailures.blankField);
        } else if (responseBody.containsKey("email") &&
            responseBody["email"]
                .contains("Insira um endereço de email válido.")) {
          return left(ServerFailures.invalidEmail);
        } else if (responseBody.containsKey("errorMaxUser")) {
          return left(ServerFailures.maxProjects);
        } else {
          print(responseBody["errorMaxProjectsUser"]);
          APIerrorhandling(ServerFailures.maxUserProjects)
              .errorhandling(message: responseBody["errorMaxProjectsUser"]);
          return left(ServerFailures.maxUserProjects);
        }
      }
    } catch (e) {
      e.printError();
      log(e.toString());
    }
    return left(ServerFailures.serverError);
  }
}
