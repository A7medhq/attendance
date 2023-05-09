// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel profileFromJson(String str) =>
    UpdateProfileModel.fromJson(json.decode(str));

String profileToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  UpdateProfileModel({
    this.notifyMobile,
  });

  String? notifyMobile;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateProfileModel(
        notifyMobile: json["notify_mobile"],
      );

  Map<String, dynamic> toJson() => {
        "notify_mobile": notifyMobile,
      };
}
