import 'dart:async';

import 'package:contractus/controller/mapcontroller.dart';
import 'package:contractus/models/Seller.dart';
import 'package:contractus/models/job_model.dart';
import 'package:contractus/screen/widgets/cards/jobcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controller/datacontroller.dart';
import '../../widgets/constant.dart';

class ClientServiceMap extends StatefulWidget {

  ClientServiceMap({required this.selectmap});
  bool selectmap;

  @override
  State<ClientServiceMap> createState() => _ClientServiceMapState();

}

class _ClientServiceMapState extends State<ClientServiceMap> {

  MapController mapController = Get.put(MapController());

  DataController dataController = Get.put(DataController());

  String address = '';

  LatLng pointlocation = const LatLng(0.0, 0.0);

  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    if (widget.selectmap) {
    } else {
      addMarkers();
    }
  }

  Future<void> addMarkers() async {
    int counter = 0;
    mapController.markers.clear();
    for (JobModel job in dataController.jobModellist) {
      counter++;
      await mapController.addJobMarker(
        markerId: counter.toString(),
        jobModel: job,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
        init: MapController(),
        builder: (data) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 7),
              child: Stack(
                children: [
                  Positioned(
                    right: 0,
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: Column(
                      children: [
                        widget.selectmap
                            ? const SizedBox(
                          height: 20,
                        )
                            : const SizedBox(
                          height: 0,
                        ),
                        widget.selectmap
                            ? const SizedBox()
                            : AppBar(
                          backgroundColor: kDarkWhite,
                          elevation: 0,
                          iconTheme: const IconThemeData(color: kNeutralColor),
                          title: Text(
                            'Map view search',
                            style: kTextStyle.copyWith(
                                color: kNeutralColor,
                                fontWeight: FontWeight.bold),
                          ),
                          centerTitle: true,
                        ),

                        Expanded(
                          child: GoogleMap(
                            markers: data.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
                            zoomControlsEnabled: false,
                            myLocationEnabled: true,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            onCameraMove: (positioned) async {

                              if (widget.selectmap) {
                                data.pointlocation = positioned.target;
                                data.getAddressFromLatLng(positioned.target);
                                // print('Get location : ${positioned.target}');
                              }

                              data.update();
                              // data.showupcard = false;

                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  widget.selectmap
                      ? const Positioned(
                    right: 0,
                    top: 0,
                    left: 0,
                    bottom: 10,
                    child: Center(
                      child: Icon(
                        Icons.add_location,
                        color: Colors.green,
                        size: 40,
                      ),
                    ),
                  ) : const SizedBox(),

                  widget.selectmap ?
                  const SizedBox() :
                  AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    bottom: data.showupcard ? 10 : -120 ,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(width: 20,),

                        JobCard(
                            jobmodel:
                            data.selectedjob ??
                                dataController.jobModellist[0]
                        ),

                        // HorizontalList(
                        //   controller: scrollController,
                        //   spacing: 10.0,
                        //   itemCount: dataController.serviceModellist.length,
                        //   itemBuilder: (_, i) {
                        //
                        //     return ServiceCard(
                        //         servicedata: dataController.serviceModellist[i]
                        //     );
                        //
                        //   },
                        // ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        }
    );
  }
}
