import 'dart:convert';

import 'package:http/http.dart' as http;

import '../providers/strings.dart';

class AuthServiceAPI {
  // late var data;
  Future<dynamic> sendLoginData(
      {required String email, required String password}) async {
    Uri uri = Uri.parse('${APILink.baseLink}/login');
    final response = await http.post(uri, headers: <String, String>{
      'X-locale': 'en',
    }, body: {
      "email": email,
      "password": password
    });
    try {
      if (response.statusCode == 200 || response.statusCode == 401) {
        var data = jsonDecode(response.body);
        if (data['status'].length > 0) {
          return data;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
