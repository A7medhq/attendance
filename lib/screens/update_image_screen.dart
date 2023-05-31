import 'dart:io';

import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../components/text_button.dart';
import '../components/text_field_custom.dart';
import '../helpers/constants.dart';
import '../helpers/show_snack_bar_custom.dart';
import '../models/get_user_data_model.dart';
import '../services/update_user_information.dart';

class UpdateImageScreen extends StatefulWidget {
  static const id = '/updateImageScreen';
  final String? image;
  const UpdateImageScreen({Key? key, this.image}) : super(key: key);
  @override
  State<UpdateImageScreen> createState() => _UpdateImageScreenState();
}

class _UpdateImageScreenState extends State<UpdateImageScreen> {
  late TextEditingController _notify_mobile;
  XFile? _imageFile;
  UserData? data;
  final ImagePicker _imagePicker = ImagePicker();
  // final UpdateUserData _updateUserData = UpdateUserData();
  bool isLoading = false;
  double imageSizeInKB = 0;

  void takePhoto(ImageSource source) async {
    final pickedImage =
        await _imagePicker.pickImage(source: source, imageQuality: 85);

    if (pickedImage != null) {
      pickedImage.readAsBytes().then((value) {
        print('image Size: ${value.length / 1024 / 1024}');
        setState(() {
          imageSizeInKB = value.length / 1024;
        });
      });
      print(pickedImage.path);
    }

    setState(() {
      _imageFile = pickedImage;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<UserInformationProvider>(
              builder: (context, value, child) {
            if (value.state == UserInformationState.Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (value.state == UserInformationState.Error) {
              return const Center(
                child: Text('Error'),
              );
            }
            final Data? userInfo = value.userInformation;
            if (userInfo != null) {
              _notify_mobile =
                  TextEditingController(text: userInfo.notifyMobile);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    backgroundImage: _imageFile == null
                        ? NetworkImage(widget.image!)
                        : FileImage(File(_imageFile!.path)) as ImageProvider,
                    radius: 80,
                  ),
                  TextButtonWidget(
                    text: 'Select image',
                    onPressed: () {
                      takePhoto(ImageSource.gallery);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFieldCustom(
                    hintText: 'Enter your mobile number',
                    controller: _notify_mobile,
                    labelText: 'Mobile number',
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  MainButtonCustom(
                    onTap: () async {
                      if (_notify_mobile.text.isNotEmpty &&
                          _notify_mobile.text != userInfo.notifyMobile) {
                        await UpdateUserData.updateUserData(
                          _notify_mobile.text,
                        ).then(
                          (value) => showSnackBar(value, context,
                              color: kPrimaryColor),
                        );
                        if (mounted) {
                          Provider.of<UserInformationProvider>(context,
                                  listen: false)
                              .getUserInformation();
                        }
                      }

                      if (_imageFile != null) {
                        setState(() {
                          isLoading = true;
                        });
                        if (imageSizeInKB < 2048) {
                          var response = await UpdateUserData.updateUserImage(
                              _imageFile!.path);

                          if (response.statusCode == 200) {
                            if (mounted) {
                              showSnackBar('Updated successfully', context,
                                  color: kPrimaryColor);

                              Provider.of<UserInformationProvider>(context,
                                      listen: false)
                                  .getUserInformation();
                              setState(() {
                                isLoading = false;
                              });
                            }
                          } else {
                            if (mounted) {
                              showSnackBar('Error Occurred: Try again', context,
                                  color: Colors.red);
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          if (mounted) {
                            showSnackBar(
                                'The image must be less than 2mb', context,
                                color: Colors.green);
                          }
                        }
                      }
                    },
                    text: 'Save',
                    height: 60,
                    width: 300,
                  ),
                  const Spacer(),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}

// class UpdateImageScreen extends StatelessWidget {
//   static const id = '/updateImageScreen';

//   final String? image;

//   const UpdateImageScreen({Key? key, this.image}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         centerTitle: true,
//         title: const Text(
//           'Settings',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         iconTheme: const IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Consumer<ImagePickerProvider>(
//           builder: (context, value, child) {
//             final XFile? imageFile = value.image;
//             if (imageFile != null) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   CircleAvatar(
//                     backgroundColor: kPrimaryColor,
//                     backgroundImage: FileImage(File(imageFile.path)),
//                     radius: 80,
//                   ),
//                   TextButtonWidget(
//                     text: 'Select image',
//                     onPressed: () {
//                       value.getImageFromGallery();
//                     },
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   TextFieldCustom(
//                     hintText: 'Enter your mobile number',
//                     controller: TextEditingController(
//                       text: Provider.of<UserInformationProvider>(context)
//                           .userInformation!
//                           .notifyMobile,
//                     ),
//                     labelText: 'Mobile number',
//                   ),
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   MainButtonCustom(
//                     onTap: () async {
//                       if (Provider.of<UserInformationProvider>(context,
//                                   listen: false)
//                               .userInformation!
//                               .notifyMobile !=
//                           null) {
//                         UpdateUserData.updateUserData(
//                             Provider.of<UserInformationProvider>(context,
//                                     listen: false)
//                                 .userInformation!
//                                 .notifyMobile!);
//                       }

//                       Navigator.pop(context);
//                     },
//                     text: 'Save',
//                     height: 60,
//                     width: 300,
//                   ),
//                   const Spacer(),
//                 ],
//               );
//             } else if (imageFile == null) {
//               // Display user's image using NetworkImage
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Spacer(),
//                   CircleAvatar(
//                     backgroundColor: kPrimaryColor,
//                     backgroundImage: NetworkImage(image!),
//                     radius: 80,
//                   ),
//                   TextButtonWidget(
//                     text: 'Select image',
//                     onPressed: () {
//                       value.getImageFromGallery();
//                     },
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   TextFieldCustom(
//                     hintText: 'Enter your mobile number',
//                     controller: TextEditingController(
//                       text: Provider.of<UserInformationProvider>(context)
//                           .userInformation!
//                           .notifyMobile,
//                     ),
//                     labelText: 'Mobile number',
//                   ),
//                   const Spacer(
//                     flex: 1,
//                   ),
//                   MainButtonCustom(
//                     onTap: () async {
//                       if (Provider.of<UserInformationProvider>(context,
//                                   listen: false)
//                               .userInformation!
//                               .notifyMobile !=
//                           null) {
//                         UpdateUserData.updateUserData(
//                             Provider.of<UserInformationProvider>(context,
//                                     listen: false)
//                                 .userInformation!
//                                 .notifyMobile!);
//                       }

//                       Navigator.pop(context);
//                     },
//                     text: 'Save',
//                     height: 60,
//                     width: 300,
//                   ),
//                   const Spacer(),
//                 ],
//               );
//             }
//             // Handle loading state
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
