import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../providers/strings.dart';

class GetUserInfo {
  final _myBox = Hive.box('myBox');

  late var data;
  Future<dynamic> getUserInfo() async {
    Uri uri = Uri.parse('${APILink.baseLink}${APILink.kHRLink}profile');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });

    try {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          return data;
        } else {
          return {"status": "fail"};
        }
      } else {
        return {"status": "fail"};
      }
    } catch (e) {
      return {"status": "fail"};
    }
  }
}
