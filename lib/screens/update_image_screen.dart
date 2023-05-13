import 'dart:io';

import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/update_user_information.dart';

class UpdateImageScreen extends StatefulWidget {
  static const id = '/updateImageScreen';
  final String? image;
  const UpdateImageScreen({Key? key, this.image}) : super(key: key);
  @override
  State<UpdateImageScreen> createState() => _UpdateImageScreenState();
}

class _UpdateImageScreenState extends State<UpdateImageScreen> {
  XFile? _imageFile;
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
            'Update Image',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                backgroundImage: _imageFile == null
                    ? NetworkImage(widget.image!)
                    : FileImage(File(_imageFile!.path)) as ImageProvider,
                radius: 120,
              ),
              const SizedBox(
                height: 45,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainButtonCustom(
                    onTap: () {
                      takePhoto(ImageSource.gallery);
                    },
                    text: 'Select Image',
                    width: 300,
                    height: 60,
                    backgroudColor: kDarkColor,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MainButtonCustom(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });

                      if (_imageFile != null) {
                        if (imageSizeInKB < 2048) {
                          var response = await UpdateUserData()
                              .updateUserImage(_imageFile!.path);

                          if (response.statusCode == 200) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Updated successfully')));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Error Occurred: Try again')));
                          }
                          setState(() {
                            isLoading = false;
                          });
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('The image must be less than 2mb')));
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Choose a photo first')));
                      }
                    },
                    text: 'Upload',
                    height: 60,
                    width: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
