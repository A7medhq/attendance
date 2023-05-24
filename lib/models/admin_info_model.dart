// To parse this JSON data, do
//
//     final adminInfoModel = adminInfoModelFromJson(jsonString);

import 'dart:convert';

AdminInfoModel adminInfoModelFromJson(String str) => AdminInfoModel.fromJson(json.decode(str));

String adminInfoModelToJson(AdminInfoModel data) => json.encode(data.toJson());

class AdminInfoModel {
  String status;
  Data data;
  String message;

  AdminInfoModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory AdminInfoModel.fromJson(Map<String, dynamic> json) => AdminInfoModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
    "message": message,
  };
}

class Data {
  User user;

  Data({
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user.toJson(),
  };
}

class User {
  int id;
  String email;
  String name;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
