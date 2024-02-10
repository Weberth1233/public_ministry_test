import 'package:ministerio_frontend/model/base_model.dart';
import 'package:ministerio_frontend/model/client_model.dart';
import 'dart:convert';

List<ProjectModel> projectModelFromJson(String str) => List<ProjectModel>.from(
    json.decode(str).map((x) => ProjectModel.fromJson(x)));

String projectModelListToJson(List<ProjectModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String projectModelToJson(Map<String, dynamic> data) => json.encode(data);

class ProjectModel extends BaseModel {
  final int? id;
  final String name;
  final String description;
  final List<ClientModel> users;

  ProjectModel({
    this.id,
    required this.name,
    required this.description,
    required this.users,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    List<ClientModel> userList = [];

    if (json['users'] != null) {
      var usersListJson = json['users'] as List<dynamic>;

      // Certifique-se de que está convertendo corretamente cada elemento da lista.
      userList = usersListJson
          .map((userJson) =>
              ClientModel.fromJson(userJson as Map<String, dynamic>))
          .toList();
    }

    return ProjectModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      users: userList,
    );
  }

  List<int> _myconverter() {
    List<int> ids = [];
    for (var element in users) {
      if (element.id != null) {
        ids.add(element.id!);
      }
    }
    return ids;
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "users": _myconverter(),
      };
}
