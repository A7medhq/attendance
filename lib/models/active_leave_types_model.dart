// To parse this JSON data, do
//
//     final activeLeaveTypesModel = activeLeaveTypesModelFromJson(jsonString);

import 'dart:convert';

ActiveLeaveTypesModel activeLeaveTypesModelFromJson(String str) => ActiveLeaveTypesModel.fromJson(json.decode(str));

String activeLeaveTypesModelToJson(ActiveLeaveTypesModel data) => json.encode(data.toJson());

class ActiveLeaveTypesModel {
  String status;
  List<LeaveTypes> data;
  String message;

  ActiveLeaveTypesModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ActiveLeaveTypesModel.fromJson(Map<String, dynamic> json) => ActiveLeaveTypesModel(
    status: json["status"],
    data: List<LeaveTypes>.from(json["data"].map((x) => LeaveTypes.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class LeaveTypes {
  int leaveTypeId;
  String description;
  String gender;
  int minimumDays;
  int maximumDays;
  int payable;
  int requiresSubAction;
  int reqPriorDay;
  int status;

  LeaveTypes({
    required this.leaveTypeId,
    required this.description,
    required this.gender,
    required this.minimumDays,
    required this.maximumDays,
    required this.payable,
    required this.requiresSubAction,
    required this.reqPriorDay,
    required this.status,
  });

  factory LeaveTypes.fromJson(Map<String, dynamic> json) => LeaveTypes(
    leaveTypeId: json["leave_type_id"],
    description: json["description"],
    gender: json["gender"],
    minimumDays: json["minimum_days"],
    maximumDays: json["maximum_days"],
    payable: json["payable"],
    requiresSubAction: json["requires_sub_action"],
    reqPriorDay: json["req_prior_day"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "leave_type_id": leaveTypeId,
    "description": description,
    "gender": gender,
    "minimum_days": minimumDays,
    "maximum_days": maximumDays,
    "payable": payable,
    "requires_sub_action": requiresSubAction,
    "req_prior_day": reqPriorDay,
    "status": status,
  };
}
