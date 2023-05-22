import 'package:flutter/material.dart';

import '../models/get_user_data_model.dart';
import '../services/get_user_information_service.dart';

enum UserInformationState { Initial, Loading, Loaded, Error }

class UserInformationProvider extends ChangeNotifier {
  UserInformationState _state = UserInformationState.Initial;
  UserInformationState get state => _state;

  Data? _userInformation;
  Data? get userInformation => _userInformation;

  void getUserInformation() async {
    _state = UserInformationState.Loading;

    try {
      final res = await GetUserInfo.getUserInfo();
      _userInformation = res.data;
      _state = UserInformationState.Loaded;
    } catch (e) {
      _state = UserInformationState.Error;
    }
    notifyListeners();
  }
}
