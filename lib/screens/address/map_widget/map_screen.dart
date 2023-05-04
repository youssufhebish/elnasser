import 'dart:async';

import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:elnasser/screens/address/address_bloc/address_cubit.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.colorsValue, required this.edit})
      : super(key: key);
  final ColorsInitialValue colorsValue;
  final bool edit;
  @override
  State<MapWidget> createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.033333, 31.233334),
    zoom: 10.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.033333, 31.233334),
      tilt: 59.440717697143555,
      zoom: 10.151926040649414);

  ///
  ///
  ///
  ///
//   Location location = new Location();
//
//   late bool _serviceEnabled;
//  late PermissionStatus _permissionGranted;
//   late LocationData _locationData;
// getLocation()async{
//   _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//     _serviceEnabled = await location.requestService();
//     if (!_serviceEnabled) {
//       return;
//     }
//   }
//
//   _permissionGranted = await location.hasPermission();
//   if (_permissionGranted == PermissionStatus.denied) {
//     _permissionGranted = await location.requestPermission();
//     if (_permissionGranted != PermissionStatus.granted) {
//       DataErrorAlert.LocationError(title: "Alert", data: "Please allow location permission", colorValue: HomeMobileCubit.get(context).theInitialModel.data!.account!.mobileAppColors, context: context);
//       // Navigator.of(context, rootNavigator: true).pop();
//     }
//   }
//
//   _locationData = await location.getLocation();
//
//
//
//   }
  ///
  ///

  LatLng _center = LatLng(45.521563, -122.677433);
  final Map<String, Marker> _markers = {};

  _mapTappedSetLoca(LatLng selectedLocation) {
    _center = selectedLocation;
    setState(() {
      //On select location add marker
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: selectedLocation,
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });

    AddressCubit.get(context).getAddressString(
        lat: selectedLocation.latitude, long: selectedLocation.longitude);
    AddressCubit.get(context).getTappedLocation(
        LatLng(selectedLocation.latitude, selectedLocation.longitude));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: FloatingActionButton(
          backgroundColor: Colors.black12,
          elevation: 0,
          child: Icon(
            Icons.my_location,
            color: ColorsConstant.getColorBackground3(widget.colorsValue),
          ),
          onPressed: () {
            _goToTheLake();
          },
        ),
      ),
      body: GoogleMap(
        onTap: _mapTappedSetLoca,
        mapType: MapType.normal,
        initialCameraPosition: widget.edit == true
            ? CameraPosition(
                target: AddressCubit.get(context).latLngData,
                zoom: 12.4746,
              )
            : _kGooglePlex,
        compassEnabled: true,
        markers: _markers.values.toSet(),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          AddressCubit.get(context).getLocationService(context);
          widget.edit == true
              ? _mapTappedSetLoca(AddressCubit.get(context).latLngData)
              : print("");
        },
      ),
    );
  }

  Future<void> _goToTheLake() async {
    // getLocation().whenComplete(()async{
    //   _locationData = await location.getLocation();
    // } );

    AddressCubit.get(context).getLocationService(context);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(AddressCubit.get(context).locationData.latitude!,
            AddressCubit.get(context).locationData.longitude!),
        tilt: 59.440717697143555,
        zoom: 17.151926040649414)));
    _mapTappedSetLoca(LatLng(AddressCubit.get(context).locationData.latitude!,
        AddressCubit.get(context).locationData.longitude!));
    AddressCubit.get(context).getAddressString(
        lat: AddressCubit.get(context).locationData.latitude!,
        long: AddressCubit.get(context).locationData.longitude!);
    AddressCubit.get(context).getTappedLocation(LatLng(
        AddressCubit.get(context).locationData.latitude!,
        AddressCubit.get(context).locationData.longitude!));
  }
}
