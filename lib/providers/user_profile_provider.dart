// import 'package:flutter/material.dart';

// import '../models/get_user_data_model.dart';
// import '../services/get_user_information_service.dart';

// enum UserProfileState { Initial, Loading, Loaded, Error }

// class UserProfileProvider extends ChangeNotifier {
//   late TextEditingController _nameController;
//   late TextEditingController _employeeCodeController;
//   late TextEditingController _notifyEmailController;
//   late TextEditingController _notifyMobileController;
//   late TextEditingController _identifierNoController;
//   late TextEditingController _identifierTypeController;
//   late TextEditingController _bankIdController;
//   late TextEditingController _bankAddressController;

//   UserProfileProvider() {
//     _nameController = TextEditingController();
//     _employeeCodeController = TextEditingController();
//     _notifyEmailController = TextEditingController();
//     _notifyMobileController = TextEditingController();
//     _identifierNoController = TextEditingController();
//     _identifierTypeController = TextEditingController(text: '4');
//     _bankIdController = TextEditingController(text: '5');
//     _bankAddressController = TextEditingController();
//   }
//   UserProfileState _state = UserProfileState.Initial;
//   UserProfileState get state => _state;

//   Data? _userProfileInformation;
//   Data? get userProfileInformation => _userProfileInformation;
//   void getUserProfileInformation() async {
//     _state = UserProfileState.Loading;

//     try {
//       final res = await GetUserInfo.getUserInfo();
//       _userProfileInformation = res.data;
//       _nameController.text = _userProfileInformation!.name!;
//       _employeeCodeController.text = _userProfileInformation!.employeeCode!;
//       _notifyEmailController.text = _userProfileInformation!.notifyEmail!;
//       _notifyMobileController.text = _userProfileInformation!.notifyMobile!;
//       _identifierNoController.text = _userProfileInformation!.identifierNo!;
//       _bankAddressController.text = _userProfileInformation!.bankIBAN!;

//       _state = UserProfileState.Loaded;
//     } catch (e) {
//       _state = UserProfileState.Error;
//     }
//     notifyListeners();
//   }
// }
