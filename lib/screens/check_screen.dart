import 'dart:async';
import 'dart:io';

import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:attendance/providers/check_in_out_status_provider.dart';
import 'package:attendance/services/check_in_out_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../components/check_in_out_container.dart';
import '../helpers/show_snack_bar_custom.dart';
import '../models/admin_info_model.dart';
import '../models/logrow_model.dart';
import '../providers/admin_data_provider.dart';

class CheckInOutScreen extends StatefulWidget {
  static const id = '/checkInOutScreen';
  const CheckInOutScreen({Key? key}) : super(key: key);

  @override
  State<CheckInOutScreen> createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _myPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 15.4746,
  );

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR$error");
    });
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  void getDeviceInfo() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      print('Android $release (SDK $sdkInt), $manufacturer $model');
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }
  }

  @override
  void initState() {
    getDeviceInfo();

    getUserCurrentLocation().then((value) async {
      print("${value.latitude} ${value.longitude}");
      _myPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 18,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_myPosition));
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 3,
          child: GoogleMap(
            scrollGesturesEnabled: false,
            buildingsEnabled: false,
            zoomGesturesEnabled: false,
            tiltGesturesEnabled: false,
            myLocationEnabled: true,
            rotateGesturesEnabled: true,
            zoomControlsEnabled: false,
            compassEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: _myPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                  markerId: const MarkerId('marker'),
                  position: LatLng(_myPosition.target.latitude,
                      _myPosition.target.longitude))
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<CheckStatusProvider>(
                builder: (context,value,child) {

                  if (value.state == CheckStatusState.Loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (value.state == CheckStatusState.Error) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  final LogRawModel? checkStatus = value.checkStatus;

                  if (checkStatus!= null) {

                    Color btnColor;
                    String btnText;

                    switch(checkStatus.errors.recordType) {
                      case 0: {
                        btnColor = Colors.black;
                        btnText = 'No Location for this user';
                      }
                      break;

                      case 1: {
                        btnColor = Colors.red;
                        btnText = 'CHECK OUT';
                      }
                      break;
                      case 2: {
                        btnColor = kPrimaryColor;
                        btnText = 'CHECK IN';
                      }
                      break;
                      case 3: {
                        btnColor = kPrimaryColor;
                        btnText = 'BREK IN';
                      }
                      break;case 4: {
                      btnColor = Colors.red;
                      btnText = 'BREK OUT';
                      }
                      break;

                      default: {
                        btnColor = Colors.red;
                        btnText = '';
                      }
                      break;
                    }

                  return MainButtonCustom(text: btnText,backgroudColor: btnColor, onTap: () async {
                    try{

                      getUserCurrentLocation().then((pos) async{
                        final logRaw = await CheckService.sendLocationToCheck(longitude: pos.longitude.toString(), latitude: pos.latitude.toString());
                        LogRawModel res = logRaw.data;

                        if(mounted) {
                          showSnackBar(res.errors.errorDescription,context, color: res.errors.errorCode == 0 ? Colors.green : Colors.red);
                        }

                      });

                    }catch (e) {
                      print(e);
                    }
                  }); }
                  else {
                    return const CircularProgressIndicator();
                  }
                }
              ),

              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CheckInOutContainer(
                    icon: FontAwesomeIcons.arrowRightToBracket,
                    title: "Last Check-In",
                    date: 'Mar 12-05-2022',
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  CheckInOutContainer(
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    title: "Last Check-Out",
                    date: 'Mar 12-05-2022',
                  ),
                ],
              )
            ],
          ),
        )
      ],
    ));
  }
}
