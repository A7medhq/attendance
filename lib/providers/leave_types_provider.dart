
import 'package:attendance/models/active_leave_types_model.dart';
import 'package:attendance/models/response_model.dart';
import 'package:attendance/services/leave_services.dart';
import 'package:flutter/material.dart';


enum LeaveTypesProviderState { Initial, Loading, Loaded, Error }

class LeaveTypesProvider extends ChangeNotifier{

   LeaveTypesProviderState _state = LeaveTypesProviderState.Initial;
   LeaveTypesProviderState get state => _state;

  List<LeaveTypes>? _leaveTypes;
  List<LeaveTypes>? get leaveTypes => _leaveTypes;

  void getLeaveTypes() async {
    _state = LeaveTypesProviderState.Loading;
 try{
   final ResponseModel res = await LeaveServices.getLeaveTypes();
   _leaveTypes = res.data;
   _state = LeaveTypesProviderState.Loaded;
 }catch(e){
   _state = LeaveTypesProviderState.Error;
   print(e);
 }

    notifyListeners();
  }
}