import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../helpers/strings.dart';

class AuthServiceAPI {
  final _myBox = Hive.box('myBox');

  Future<bool?> logout() async {
    Uri uri = Uri.parse('${APILink.baseLink}/destroy');
    final response = await http.get(uri, headers: <String, String>{
      'X-locale': 'en',
      HttpHeaders.authorizationHeader: _myBox.get('token')
    });
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['status'] == 'success') {
          _myBox.put('token', 'null');
          return true;
        } else {
          return false;
        }
      }
    } catch (e) {
      {
        return false;
      }
    }
  }
}
