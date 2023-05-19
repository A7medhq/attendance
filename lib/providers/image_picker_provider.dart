// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:hive/hive.dart';
// import '../services/update_user_information.dart';

// enum ImagePickerState { Initial, Loaded, Error }

// class ImagePickerProvider extends ChangeNotifier {
//   final _myBox = Hive.box('myBox');
//   ImagePickerState _state = ImagePickerState.Initial;
//   ImagePickerState get state => _state;
//   double imageSizeInKB = 0;

//   XFile? _image;

//   XFile? get image => _image;

//   // Future<void> getImageFromCamera() async {
//   //   final imagePicker = ImagePicker();
//   //   final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
//   //   if (pickedImage != null) {
//   //     _image = File(pickedImage.path);
//   //     notifyListeners();
//   //   }
//   // }

//   Future<void> getImageFromGallery() async {
//     try {
//       final imagePicker = ImagePicker();
//       final pickedImage =
//           await imagePicker.pickImage(source: ImageSource.gallery);
     
//       if (pickedImage != null) {
//         pickedImage.readAsBytes().then((value) {
//           imageSizeInKB = value.length / 1024;
//         });
//         _image = XFile(pickedImage.path);
        
//         if (image != null) {
//           if (imageSizeInKB < 2048) {
//             var response = await UpdateUserData.updateUserImage(image!.path);

//             if (response.statusCode == 200) {
//               const Text('Updated successfully');
//             } else {
//               const Text('Error Occurred: Try again');
//             }
//           } else {
//             const Text('The image must be less than 2mb');
//           }
//         } else {
//           const Text('Choose a photo first');
//         }
//         _state = ImagePickerState.Loaded;
//       }
//     } catch (e) {
//       _state = ImagePickerState.Error;
//     }
//     notifyListeners();
//   }
// }
