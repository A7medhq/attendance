import 'dart:convert';
import 'dart:io';

import 'package:attendance/providers/strings.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

class UpdateUserData {
  final _myBox = Hive.box('myBox');

  Future<String> updateUserData(String notify) async {
    Uri uri = Uri.parse('${APILink.baseLink}}${APILink.kHRLink}update-profile');
    final response = await http.post(uri, headers: <String, String>{
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    }, body: {
      "notify_mobile": notify,
    });

    try {
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (data['status'] == 'success') {
          return 'Updated Successfully';
        } else {
          return 'Error Occurred';
        }
      } else {
        return 'status code error';
      }
    } catch (e) {
      return 'Error Occurred';
    }
  }

  Future<http.StreamedResponse> updateUserImage(String filePath) async {
    var headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    };
    var request = http.MultipartRequest('POST',
        Uri.parse('${APILink.baseLink}${APILink.kHRLink}update-profile'))
      ..followRedirects = false
      ..files.add(await http.MultipartFile.fromPath("image", filePath))
      ..headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }
}
