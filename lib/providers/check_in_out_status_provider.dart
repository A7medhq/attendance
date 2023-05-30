import 'package:attendance/models/logrow_model.dart';
import 'package:attendance/services/check_in_out_service.dart';
import 'package:flutter/material.dart';

enum CheckStatusState { Initial, Loading, Loaded, Error }

class CheckStatusProvider extends ChangeNotifier {
  CheckStatusState _state = CheckStatusState.Initial;
  CheckStatusState get state => _state;

  LogRawModel? _checkStatus;
  LogRawModel? get checkStatus => _checkStatus;

  void getCheckStatus() async {
    _state = CheckStatusState.Loading;

    try {
      final res = await CheckService.getCheckLoginStatus();
      _checkStatus = res.data;
      _state = CheckStatusState.Loaded;
    } catch (e) {
      _state = CheckStatusState.Error;
    }

    notifyListeners();
  }
}
