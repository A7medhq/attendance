import 'dart:async';

import 'package:attendance/components/date_picker_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

import '../components/main_button_custom.dart';
import '../components/my_text_field.dart';

class LocationRequestScreen extends StatefulWidget {
  static const id = '/locationRequestScreen';
  const LocationRequestScreen({Key? key}) : super(key: key);

  @override
  State<LocationRequestScreen> createState() => _LocationRequestScreenState();
}

class _LocationRequestScreenState extends State<LocationRequestScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  TextEditingController locationTextFieldController = TextEditingController();
  TextEditingController startDateTextFieldController = TextEditingController();
  TextEditingController endDateTextFieldController = TextEditingController();

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

  @override
  void initState() {
    startDateTextFieldController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    endDateTextFieldController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldCustom(
                prefixIconData: FontAwesomeIcons.calendar,
                controller: locationTextFieldController,
                hintText: 'Gaza Strip',
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  DatePickerCustom(controller: startDateTextFieldController),
                  const SizedBox(
                    width: 10,
                  ),
                  DatePickerCustom(controller: endDateTextFieldController),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              MainButtonCustom(
                text: 'Send Request',
              )
            ],
          ),
        )
      ],
    ));
  }
}
