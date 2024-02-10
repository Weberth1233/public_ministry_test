import 'dart:convert';

import 'package:ministerio_frontend/model/base_model.dart';

List<ClientModel> userModelFromJson(String str) => List<ClientModel>.from(
    json.decode(str).map((x) => ClientModel.fromJson(x)));

String userModelListToJson(List<ClientModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String userModelToJson(Map<String, dynamic> data) => json.encode(data);

class ClientModel extends BaseModel {
  int? id;
  String name;
  String phone;
  String email;

  ClientModel(
      {required this.name, required this.phone, required this.email, this.id});

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"]);

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "email": email,
      };
}
