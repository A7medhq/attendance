


import 'dart:convert';
import 'dart:io';

import 'package:attendance/helpers/strings.dart';
import 'package:attendance/models/active_leave_types_model.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:attendance/models/response_model.dart';

class LeaveServices{

  static Future<ResponseModel> getLeaveTypes() async {

     final _myBox = Hive.box('myBox');

    final Uri url = Uri.parse('${APILink.baseLink+APILink.kLeaveManagmentSystemLink}get-leave-types');
   http.Response response  = await http.get(url,headers: {
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    });


   try{

     if(response.statusCode == 200){

       final dynamic decodedData = jsonDecode(response.body);
      final ActiveLeaveTypesModel data = ActiveLeaveTypesModel.fromJson(decodedData);


       if (data.status == 'success') {
         return ResponseModel(data: data.data,message: 'success');
       }
       else{
         return ResponseModel(message: 'failed');
       }
     } else {

       return ResponseModel(message: 'failed');
     }
   }
   catch(e) {
   return ResponseModel(message: 'failed');
   }

  }


  static Future<ResponseModel> createLeaveRequest({required String leaveTypeId, required String numberOfDays,}) async {

     final _myBox = Hive.box('myBox');

    final Uri url = Uri.parse('${APILink.baseLink+APILink.kLeaveManagmentSystemLink}create');
   http.Response response  = await http.post(url,headers: {
      HttpHeaders.authorizationHeader: _myBox.get('token').toString(),
    },body: {
     'leave_type_id': leaveTypeId,
     'employee_id': _myBox.get('userId').toString(),
     'no_days': numberOfDays,
     'last_work': '2023-01-08',
     'return_work': '2023-01-11',
     'direct': '0',
     'request_status': '1'
   });


   try{

     if(response.statusCode == 200){

       final dynamic decodedData = jsonDecode(response.body);
      final ActiveLeaveTypesModel data = ActiveLeaveTypesModel.fromJson(decodedData);


       if (data.status == 'success') {
         return ResponseModel(data: data.data,message: 'success');
       }
       else{
         return ResponseModel(message: 'failed');
       }
     } else {

       return ResponseModel(message: 'failed');
     }
   }
   catch(e) {
   return ResponseModel(message: 'failed');
   }

  }



}