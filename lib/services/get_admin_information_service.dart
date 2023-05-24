import 'dart:convert';
import 'dart:io';

import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/models/response_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../helpers/strings.dart';
import '../models/admin_info_model.dart';

class GetAdminInfo {


  static Future<ResponseModel> getAdminInfo() async {
    final _myBox = Hive.box('myBox');


    Uri uri = Uri.parse('${APILink.baseLink}/get');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });

    try {
      if (response.statusCode == 200) {


        dynamic jsonResponse = jsonDecode(response.body);
        AdminInfoModel adminInfoData = AdminInfoModel.fromJson(jsonResponse);

        if (adminInfoData.status == 'success') {
          return ResponseModel(data: adminInfoData.data, message: 'success');
        } else {
          return ResponseModel(message: 'fail');
        }
      } else {
        return ResponseModel(message: 'fail');
      }
    } catch (e) {
      return ResponseModel(message: 'fail');
    }
  }
}
