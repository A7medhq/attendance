import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../models/get_user_data_model.dart';
import '../helpers/strings.dart';

class GetUserProfile {

 static Future<UserData?> getUserProfile() async {

   UserData? user;
   final _myBox = Hive.box('myBox');

    Uri uri = Uri.parse('${APILink.baseLink}${APILink.kHRLink}profile');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        user = UserData.fromJson(data);
        if (user!.status == 'success') {
          return user;
        } else {
          return null;
        }
      } else {
        print(response.statusCode);
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
