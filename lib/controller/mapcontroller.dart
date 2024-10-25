import 'package:contractus/models/job_model.dart';
import 'package:contractus/models/map/joblocation.dart';
import 'package:contractus/models/map/servicelocation.dart';
import 'package:contractus/models/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapController extends GetxController {

  final List<ServiceLocation> serviceLocations = [
    // Alabama
    ServiceLocation('Birmingham', 33.5186, -86.8104, 30),

    // Alaska
    ServiceLocation('Anchorage', 61.2181, -149.9003, 25),

    // Arizona
    ServiceLocation('Phoenix', 33.4484, -112.0740, 55),

    // Arkansas
    ServiceLocation('Little Rock', 34.7465, -92.2896, 20),

    // California
    ServiceLocation('Los Angeles', 34.0522, -118.2437, 80),

    // Colorado
    ServiceLocation('Denver', 39.7392, -104.9903, 65),

    // Connecticut
    ServiceLocation('Hartford', 41.7658, -72.6734, 20),

    // Delaware
    ServiceLocation('Wilmington', 39.7391, -75.5398, 15),

    // Florida
    ServiceLocation('Miami', 25.7617, -80.1918, 40),

    // Georgia
    ServiceLocation('Atlanta', 33.7490, -84.3880, 65),

    // Hawaii
    ServiceLocation('Honolulu', 21.3069, -157.8583, 25),

    // Idaho
    ServiceLocation('Boise', 43.6150, -116.2023, 15),

    // Illinois
    ServiceLocation('Chicago', 41.8781, -87.6298, 60),

    // Indiana
    ServiceLocation('Indianapolis', 39.7684, -86.1581, 30),

    // Iowa
    ServiceLocation('Des Moines', 41.5868, -93.6250, 20),

    // Kansas
    ServiceLocation('Wichita', 37.6872, -97.3301, 15),

    // Kentucky
    ServiceLocation('Louisville', 38.2527, -85.7585, 25),

    // Louisiana
    ServiceLocation('New Orleans', 29.9511, -90.0715, 30),

    // Maine
    ServiceLocation('Portland', 43.6615, -70.2553, 10),

    // Maryland
    ServiceLocation('Baltimore', 39.2904, -76.6122, 35),

    // Massachusetts
    ServiceLocation('Boston', 42.3601, -71.0589, 70),

    // Michigan
    ServiceLocation('Detroit', 42.3314, -83.0458, 50),

    // Minnesota
    ServiceLocation('Minneapolis', 44.9778, -93.2650, 35),

    // Mississippi
    ServiceLocation('Jackson', 32.2988, -90.1848, 10),

    // Missouri
    ServiceLocation('Kansas City', 39.0997, -94.5786, 30),

    // Montana
    ServiceLocation('Billings', 45.7833, -108.5007, 10),

    // Nebraska
    ServiceLocation('Omaha', 41.2565, -95.9345, 15),

    // Nevada
    ServiceLocation('Las Vegas', 36.1699, -115.1398, 40),

    // New Hampshire
    ServiceLocation('Manchester', 42.9956, -71.4548, 10),

    // New Jersey
    ServiceLocation('Newark', 40.7357, -74.1724, 25),

    // New Mexico
    ServiceLocation('Albuquerque', 35.0844, -106.6504, 20),

    // New York
    ServiceLocation('New York City', 40.7128, -74.0060, 120),

    // North Carolina
    ServiceLocation('Charlotte', 35.2271, -80.8431, 60),

    // North Dakota
    ServiceLocation('Fargo', 46.8772, -96.7898, 10),

    // Ohio
    ServiceLocation('Columbus', 39.9612, -82.9988, 55),

    // Oklahoma
    ServiceLocation('Oklahoma City', 35.4676, -97.5164, 25),

    // Oregon
    ServiceLocation('Portland', 45.5051, -122.6750, 35),

    // Pennsylvania
    ServiceLocation('Philadelphia', 39.9526, -75.1652, 50),

    // Rhode Island
    ServiceLocation('Providence', 41.8240, -71.4128, 15),

    // South Carolina
    ServiceLocation('Charleston', 32.7765, -79.9311, 20),

    // South Dakota
    ServiceLocation('Sioux Falls', 43.5446, -96.7311, 10),

    // Tennessee
    ServiceLocation('Nashville', 36.1627, -86.7816, 40),

    // Texas
    ServiceLocation('Houston', 29.7604, -95.3698, 90),

    // Utah
    ServiceLocation('Salt Lake City', 40.7608, -111.8910, 25),

    // Vermont
    ServiceLocation('Burlington', 44.4759, -73.2121, 10),

    // Virginia
    ServiceLocation('Virginia Beach', 36.8529, -75.9780, 30),

    // Washington
    ServiceLocation('Seattle', 47.6062, -122.3321, 80),

    // West Virginia
    ServiceLocation('Charleston', 38.3498, -81.6326, 10),

    // Wisconsin
    ServiceLocation('Milwaukee', 43.0389, -87.9065, 25),

    // Wyoming
    ServiceLocation('Cheyenne', 41.1400, -104.8202, 10),
  ];

  List<ServiceLocation> serviceresultlist = [];
  List<JobLocation> jobresultlist = [];

  analyzeDataService({required List<ServiceModel> data}){

    serviceresultlist.clear();

    print('It\'s starts');

    for (var serviceitem in serviceLocations) {

      int count = 0;

      print('This location ${serviceitem.location} Counts: $count');

      for (var element in data) {
        if(element.address.contains(serviceitem.location)){
          count++;
          print('we got one location ${serviceitem.location} Counts: $count');
        }
      }

      serviceresultlist.add(
          ServiceLocation(
            serviceitem.location,
            serviceitem.latitude,
            serviceitem.longitude,
            count,
      ));
    }

    update();

  }

  analyzeDatajob({required List<JobModel> data}){

    jobresultlist.clear();

    for (var serviceitem in serviceLocations) {
      
      int count = 0;

      for (var element in data) {
        if(element.address.contains(serviceitem.location)){
          count++;
          print('we got one location ${serviceitem.location} Counts: $count');
        }
      }

      print('This location ${serviceitem.location} Counts: $count');

      jobresultlist.add(
          JobLocation(
            serviceitem.location,
            serviceitem.latitude,
            serviceitem.longitude,
            count,
          ));
    }

    update();

  }

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

      var inaddress = placemarks.first.administrativeArea; // Access street name or other address details from Place

      address = '${placemarks.first.administrativeArea}'
          ' ${placemarks.first.subLocality}';

      print('New address : ${address!}');

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
