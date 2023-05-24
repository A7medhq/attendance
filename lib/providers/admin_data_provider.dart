import 'package:attendance/services/get_admin_information_service.dart';
import 'package:flutter/material.dart';

import '../models/admin_info_model.dart';

enum AdminInformationState { Initial, Loading, Loaded, Error }

class AdminInformationProvider extends ChangeNotifier {
  AdminInformationState _state = AdminInformationState.Initial;
  AdminInformationState get state => _state;

  Data? _adminInformation;
  Data? get adminInformation => _adminInformation;

  void getAdminInformation() async {
    _state = AdminInformationState.Loading;

    try {
      final res = await GetAdminInfo.getAdminInfo();
      _adminInformation = res.data;
      _state = AdminInformationState.Loaded;
    } catch (e) {
      _state = AdminInformationState.Error;
    }
    notifyListeners();
  }
}