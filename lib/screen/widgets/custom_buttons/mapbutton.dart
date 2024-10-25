import 'dart:async';

import 'package:contractus/screen/mapscreens/seller_service_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constant.dart';

class MapButton extends StatefulWidget {
  const MapButton({super.key});

  @override
  State<MapButton> createState() => _MapButtonState();
}

class _MapButtonState extends State<MapButton> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 5.4746,
  );

  getinitiallocation() async {

    LocationPermission permit = await Geolocator.checkPermission();
    if(permit == LocationPermission.denied){
      Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);


    if (mounted) {
      setState(() {
        kGooglePlex = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 3.0,
        );
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getinitiallocation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        // clipper: RoundedCornerClipper(),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            height: 150,
            // width: 304,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: kBorderColorTextField),
              boxShadow: const [
                BoxShadow(
                  color: kDarkWhite,
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: kGooglePlex,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: ((LatLng latlng) => Get.to(SellerServiceMap(
                    selectmap: false,
                  ))),
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedCornerClipper extends CustomClipper<RRect> {
  @override
  RRect getClip(Size size) {
    return RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(20.0),
    );
  }

  @override
  bool shouldReclip(CustomClipper<RRect> oldClipper) => false;
}
