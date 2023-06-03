import 'dart:async';
import 'dart:io';

import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:attendance/helpers/manager_strings.dart';
import 'package:attendance/providers/check_in_out_status_provider.dart';
import 'package:attendance/services/check_in_out_service.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../components/check_in_out_container.dart';
import '../helpers/manager_sizes.dart';
import '../helpers/show_snack_bar_custom.dart';
import '../models/logrow_model.dart';

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
    target: LatLng(Constants.latLnglatitude, Constants.latLnglongitude),
    zoom: Constants.zoom15,
  );

  // created method for getting user current location
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("${ManagerStrings.error}$error");
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

  static Widget buttonShimmer = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(
              color: Colors.green,
              width: ManagerWidth.wBorder,
              style: BorderStyle.none),
          borderRadius: BorderRadius.circular(ManagerRadius.r50),
        ),
        height: ManagerHeight.h60,
        width: double.infinity,
      ));

  @override
  void initState() {
    getDeviceInfo();

    getUserCurrentLocation().then((value) async {
      print("${value.latitude} ${value.longitude}");
      _myPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: Constants.zoom18,
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
          flex: Constants.flex3,
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
                  markerId: const MarkerId(ManagerStrings.marker),
                  position: LatLng(_myPosition.target.latitude,
                      _myPosition.target.longitude))
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w24,
            vertical: ManagerHeight.h24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<CheckStatusProvider>(builder: (context, value, child) {
                if (value.state == CheckStatusState.Loading) {
                  return buttonShimmer;
                }
                if (value.state == CheckStatusState.Error) {
                  return const Center(
                    child: Text(ManagerStrings.error),
                  );
                }
                final LogRawModel? checkStatus = value.checkStatus;

                if (checkStatus != null) {
                  Color btnColor;
                  String btnText;

                  if (checkStatus.errors.nextRecordType ==
                      NextRecordTypeConstants.zeroNextRecordType) {
                    btnColor = Colors.black;
                    btnText = ManagerStrings.noLocation;
                  } else if (checkStatus.errors.nextRecordType ==
                      NextRecordTypeConstants.firstNextRecordType) {
                    btnColor = Colors.green;
                    btnText = ManagerStrings.login;
                  } else if (checkStatus.errors.nextRecordType ==
                      NextRecordTypeConstants.secondNextRecordType) {
                    btnColor = Colors.red;
                    btnText = ManagerStrings.logout;
                  } else if (checkStatus.errors.nextRecordType ==
                      NextRecordTypeConstants.thirdNextRecordType) {
                    btnColor = Colors.red;
                    btnText = ManagerStrings.breakOut;
                  } else if (checkStatus.errors.nextRecordType ==
                      NextRecordTypeConstants.fourthNextRecordType) {
                    btnColor = Colors.green;
                    btnText = ManagerStrings.breakIN;
                  } else {
                    btnColor = Colors.red;
                    btnText = ManagerStrings.empty;
                  }

                  return MainButtonCustom(
                      text: btnText,
                      backgroudColor: btnColor,
                      onTap: () async {
                        try {
                          getUserCurrentLocation().then((pos) async {
                            final logRaw =
                                await CheckService.sendLocationToCheck(
                                    longitude: pos.longitude.toString(),
                                    latitude: pos.latitude.toString());
                            LogRawModel res = logRaw.data;

                            if (mounted) {
                              showSnackBar(res.errors.errorDescription, context,
                                  color: res.errors.errorCode ==
                                          Constants.errorCode
                                      ? Colors.green
                                      : Colors.red);
                              Provider.of<CheckStatusProvider>(context,
                                      listen: false)
                                  .getCheckStatus();
                            }
                          });
                        } catch (e) {
                          print(e);
                        }
                      });
                } else {
                  return buttonShimmer;
                }
              }),
              SizedBox(
                height: ManagerHeight.h12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CheckInOutContainer(
                    icon: FontAwesomeIcons.arrowRightToBracket,
                    title: ManagerStrings.lastCheckIn,
                    date: ManagerStrings.soon,
                  ),
                  SizedBox(
                    width: ManagerWidth.w15,
                  ),
                  CheckInOutContainer(
                    icon: FontAwesomeIcons.arrowRightFromBracket,
                    title: ManagerStrings.lastCheckOut,
                    date: ManagerStrings.soon,
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
