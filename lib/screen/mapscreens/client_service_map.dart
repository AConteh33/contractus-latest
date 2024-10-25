import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:contractus/controller/mapcontroller.dart';
import 'package:contractus/models/Seller.dart';
import 'package:contractus/models/job_model.dart';
import 'package:contractus/screen/client%20screen/client%20job%20post/client_job_post.dart';
import 'package:contractus/screen/widgets/cards/jobcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../controller/datacontroller.dart';
import '../../models/categorymodel.dart';
import '../../models/map/servicelocation.dart';
import '../client screen/search/searchresult.dart';
import '../widgets/cards/servicecard.dart';
import '../widgets/constant.dart';

class ClientServiceMap extends StatefulWidget {

  ClientServiceMap({required this.selectmap});
  bool selectmap;

  @override
  State<ClientServiceMap> createState() => _ClientServiceMapState();

}

class _ClientServiceMapState extends State<ClientServiceMap> {

  MapController mapController = Get.put(MapController());

  DataController dataController = Get.put(DataController());

  List<CategoryModel> categoryList = DataController().categorylist;

  String address = '';

  LatLng pointlocation = const LatLng(0.0, 0.0);

  CameraPosition kGooglePlex = const CameraPosition(
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
      mapController.analyzeDataService(data: dataController.serviceModellist);
      addMarkers();
    }
    getinitiallocation();
  }

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
                          iconTheme:
                          const IconThemeData(color: kNeutralColor),
                          title: Text(
                            'Map view search',
                            style: kTextStyle.copyWith(
                                color: kNeutralColor,
                                fontWeight: FontWeight.bold),
                          ),
                          centerTitle: true,
                          actions: [
                            // Add filters button here
                            TextButton.icon(
                              onPressed: () {
                                showFlexibleBottomSheet(
                                  context: context,
                                  builder:
                                      (context, controller, explorer) =>
                                      Container(
                                        height: MediaQuery.of(context)
                                            .size
                                            .height *
                                            0.7,
                                        color: Colors.white,
                                        child: SingleChildScrollView(
                                          child: ExpansionTile(
                                            title: Text("By Category"),
                                            children: [
                                              for (int index = 0;
                                              index < categoryList.length;
                                              index++)
                                                ListTile(
                                                  title: ElevatedButton(
                                                      onPressed: () {},
                                                      child: Text(
                                                          categoryList[index]
                                                              .category)),
                                                ),
                                            ],
                                            onExpansionChanged:
                                                (bool expanded) {},
                                            controlAffinity:
                                            ListTileControlAffinity
                                                .leading,
                                          ),
                                        ),
                                      ),
                                );
                              },
                              icon: const Icon(
                                Icons.filter_list,
                                color: kNeutralColor,
                              ),
                              label: Text(
                                'Filters',
                                style: kTextStyle.copyWith(
                                  color: kNeutralColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        widget.selectmap ? Expanded(
                          child: GoogleMap(
                            markers: data.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: kGooglePlex,
                            zoomControlsEnabled: false,
                            mapToolbarEnabled: false,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                            onCameraMove: (positioned) async {
                              if (widget.selectmap) {
                                data.pointlocation = positioned.target;
                                data.getAddressFromLatLng(positioned.target);
                                data.showupcard = false;
                              }

                              data.update();

                              // data.showupcard = false;
                            },
                          ),
                        ): Expanded(
                          child: SfMaps(
                            layers: [
                              MapTileLayer(
                                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                                initialFocalLatLng: const MapLatLng(39.8283, -98.5795),
                                initialZoomLevel: 4,
                                zoomPanBehavior: MapZoomPanBehavior(minZoomLevel: 4,maxZoomLevel: 8),
                                initialMarkersCount: data.serviceresultlist.length,
                                markerBuilder: (BuildContext context, int index) {

                                  final ServiceLocation serviceLocation = data.serviceresultlist[index];

                                  return MapMarker(
                                    latitude: serviceLocation.latitude,
                                    longitude: serviceLocation.longitude,
                                    child: GestureDetector(
                                      onTap: (){
                                        SearchResultScreen(
                                          titlecategory: '',
                                          jobsearch: false,
                                        ).launch(context);
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: kPrimaryColor.withOpacity(0.5),
                                        radius: 15,
                                        child: Text(
                                          serviceLocation.serviceCount.toString(),
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  );

                                },
                              ),
                            ],
                          ),
                        )
                        ,
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
                  )
                      : const SizedBox(),
                  widget.selectmap
                      ? const SizedBox()
                      : AnimatedPositioned(
                    duration: const Duration(seconds: 1),
                    bottom: data.showupcard ? 5 : -130,
                    left: 0,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // const SizedBox(width: 20,),

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
        });
  }
}
