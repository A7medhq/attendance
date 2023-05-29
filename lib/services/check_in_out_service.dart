import 'dart:convert';
import 'dart:io';

import 'package:attendance/models/logrow_model.dart';
import 'package:attendance/models/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../helpers/strings.dart';

class CheckService {
  static Future<ResponseModel> sendLocationToCheck(
      {required String longitude, required String latitude}) async {
    final myBox = Hive.box('myBox');

    Uri uri = Uri.parse('${APILink.baseLink}/tas/lograw');
    final response = await http.post(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.authorizationHeader: myBox.get('token').toString(),
    }, body: {
      'employee_id': myBox.get('userId').toString(),
      'longitude': longitude,
      'latitude': latitude
    });
    try {
      dynamic jsonResponse = jsonDecode(response.body);
      LogRawModel logRawData = LogRawModel.fromJson(jsonResponse);
      return ResponseModel(data: logRawData.data, message: logRawData.message);
    } catch (e) {
      print(e);
      return ResponseModel(message: e.toString());
    }
  }

  static Future<ResponseModel> getCheckLoginStatus() async {
    final myBox = Hive.box('myBox');
    Uri uri = Uri.parse(
        '${APILink.baseLink}/tas/status?employeeId=${myBox.get('userId').toString()}');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.authorizationHeader: myBox.get('token').toString(),
    });
    try {
      dynamic jsonResponse = jsonDecode(response.body);
      LogRawModel logRawData = LogRawModel.fromJson(jsonResponse);

      return ResponseModel(data: logRawData.data, message: logRawData.message);
    } catch (e) {
      print(e);
      return ResponseModel(message: e.toString());
    }
  }
}
