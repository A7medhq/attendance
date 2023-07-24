import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:open_settings/open_settings.dart';

class AuthService {
  //initialize Local Authentication plugin.
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool isAuthenticated = false;

  Future<bool> checkBiometricsSupp() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

    print('is supp $canCheckBiometrics');

    if (canCheckBiometrics) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkBiometricsEnabled() async {
    //check if user has enabled biometrics.
    bool isBiometricSupported = await _localAuthentication.isDeviceSupported();
    print('is enabled $isBiometricSupported');

    if (isBiometricSupported) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> authenticateUser() async {
    //if device supports biometrics and user has enabled biometrics, then authenticate.
    if (await checkBiometricsSupp() && await checkBiometricsEnabled()) {
      try {
        isAuthenticated = await _localAuthentication.authenticate(
            localizedReason: 'Scan your fingerprint to authenticate',
            options: const AuthenticationOptions(
                // biometricOnly: true,
                ));
      } on PlatformException catch (e) {
        print(e);
      }
    } else if (await checkBiometricsSupp() && !await checkBiometricsEnabled()) {
      OpenSettings.openBiometricEnrollSetting();
    }
    return isAuthenticated;
  }
}
