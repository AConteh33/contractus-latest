import 'package:contractus/models/job_model.dart';
import 'package:contractus/models/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {

  // Make markers observable
  var _markers = <Marker>{}.obs;

  String? address = '';
  String? myaddress = '';
  LatLng pointlocation = const LatLng(0.0, 0.0);

  JobModel? selectedjob;

  bool showupcard = false;
  ServiceModel? selecteddata;

  @override
  Future<void> onInit() async {
    super.onInit();
    // Initial marker
  }


  // Getter to access markers outside the controller
  // ignore: invalid_use_of_protected_member
  Set<Marker> get markers => _markers;


  // Method to add a marker
  Future<void> addServiceMarker({
    required String markerId,
    required ServiceModel serviceModel
  }) async{
    markers.clear();
    MarkerId markerID = MarkerId(markerId);

    final customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'images/marker.bmp', // Path to your custom icon asset
    );

    final marker =
        Marker(
            markerId: markerID,
            position: serviceModel.location,
            icon: customIcon,
            onTap: (){
          showupcard = true;
          selecteddata = serviceModel;
        });

    markers.add(marker);

    update(); // Add marker to the internal markers set

  }

  // Method to add a marker
  Future<void> addJobMarker({
    required String markerId,
    required JobModel jobModel,
  }) async {
    markers.clear();
    MarkerId markerID = MarkerId(markerId);

    final customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'images/marker.bmp', // Path to your custom icon asset
    );

    final marker =
        Marker(markerId: markerID, position: jobModel.location, icon: customIcon,
            onTap: (){
          showupcard = true;
          selectedjob = jobModel;
        });

    markers.add(marker);

    update(); // Add marker to the internal markers set

  }

  Future<String?> getAddressFromLatLng(LatLng position) async {
    final List<Placemark> placemarks =
    await placemarkFromCoordinates(
        position.latitude,
        position.longitude
    );

    if (placemarks.isNotEmpty) {
      var inaddress = placemarks.first
          .locality; // Access street name or other address details from Place
      address = placemarks.first.locality;

      update();
      return inaddress;
    } else {
      return "";
    }
  }

  Future<dynamic> getUserCurrentLocation() async {
    if (pointlocation != const LatLng(0.0, 0.0)) {
      return getAddressFromLatLng(pointlocation);
    } else {
      // Get user's current location (if not already stored)
      Position? position;

      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      pointlocation = LatLng(position.latitude, position.longitude);

      return getAddressFromLatLng(pointlocation);
    }

  }

}
