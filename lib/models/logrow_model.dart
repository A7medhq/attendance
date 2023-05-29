// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LogRawModel welcomeFromJson(String str) =>
    LogRawModel.fromJson(json.decode(str));

String welcomeToJson(LogRawModel data) => json.encode(data.toJson());

class LogRawModel {
  String status;
  Data data;
  String message;

  LogRawModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory LogRawModel.fromJson(Map<String, dynamic> json) => LogRawModel(
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
  String employeeId;
  DateTime date;
  String time;
  int recordType;
  String recordDescription;
  int nextRecordType;
  String nextRecordDescription;
  int errorCode;
  String errorDescription;

  Data({
    required this.employeeId,
    required this.date,
    required this.time,
    required this.recordType,
    required this.recordDescription,
    required this.nextRecordType,
    required this.nextRecordDescription,
    required this.errorCode,
    required this.errorDescription,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        employeeId: json["employee_id"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        recordType: json["record_type"],
        recordDescription: json["record_description"],
        nextRecordType: json["next_record_type"],
        nextRecordDescription: json["next_record_description"],
        errorCode: json["error_code"],
        errorDescription: json["error_description"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "time": time,
        "record_type": recordType,
        "record_description": recordDescription,
        "next_record_type": nextRecordType,
        "next_record_description": nextRecordDescription,
        "error_code": errorCode,
        "error_description": errorDescription,
      };
}
