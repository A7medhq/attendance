import 'dart:convert';
import 'dart:io';

import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/models/response_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../helpers/strings.dart';

class GetUserInfo {


  static Future<bool> checkUserLoggedIn() async {
    final _myBox = Hive.box('myBox');


    Uri uri = Uri.parse('${APILink.baseLink}${APILink.kHRLink}profile');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });

    try {
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        return true;
      }else {return false;}

    } else {
      return false;
    }}
        catch(e) {
      return false;
        }
  }

  static Future<ResponseModel> getUserInfo() async {
    final _myBox = Hive.box('myBox');


    Uri uri = Uri.parse('${APILink.baseLink}${APILink.kHRLink}profile');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });

    try {
      if (response.statusCode == 200) {


        var jsonResponse = jsonDecode(response.body);
        var userInfoData = UserData.fromJson(jsonResponse);

        if (userInfoData.status == 'success') {
          return ResponseModel(data: userInfoData.data, message: 'success');
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
