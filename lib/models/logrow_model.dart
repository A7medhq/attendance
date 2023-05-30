// To parse this JSON data, do
//
//     final logRaw = logRawFromJson(jsonString);

import 'dart:convert';

LogRawModel logRawFromJson(String str) =>
    LogRawModel.fromJson(json.decode(str));

String logRawToJson(LogRawModel data) => json.encode(data.toJson());

class LogRawModel {
  String status;
  String message;
  Errors errors;

  LogRawModel({
    required this.status,
    required this.message,
    required this.errors,
  });

  factory LogRawModel.fromJson(Map<String, dynamic> json) => LogRawModel(
        status: json["status"],
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  dynamic employeeId;
  DateTime date;
  String time;
  int recordType;
  String recordDescription;
  int nextRecordType;
  String nextRecordDescription;
  int errorCode;
  String errorDescription;

  Errors({
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

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
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
