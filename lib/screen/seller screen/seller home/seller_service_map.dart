import 'dart:async';

import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:contractus/controller/mapcontroller.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/Seller.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/service.dart';
import 'package:contractus/screen/widgets/cards/servicecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../widgets/constant.dart';

class SellerServiceMap extends StatefulWidget {
  SellerServiceMap({required this.selectmap});
  bool selectmap;

  @override
  _SellerServiceMapState createState() => _SellerServiceMapState();
}

class _SellerServiceMapState extends State<SellerServiceMap> {
  MapController mapController = Get.put(MapController());

  DataController dataController = Get.put(DataController());

  List<CategoryModel> categoryList = DataController().categorylist;

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
    addMarkers();
  }

  Future<void> addMarkers() async {
    int counter = 0;
    mapController.markers.clear();
    for (ServiceModel service in dataController.serviceModellist) {
      counter++;
      // This is where you can add new markers according to the data that's being received.
      await mapController.addServiceMarker(
        markerId: counter.toString(),
        serviceModel: service,
      );
    }
    setState(() {});
  }

  ScrollController scrollController = ScrollController();

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
                        Expanded(
                          child: GoogleMap(
                            markers: data.markers,
                            mapType: MapType.normal,
                            initialCameraPosition: _kGooglePlex,
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

                              ServiceCard(
                                servicedata: data.selecteddata ??
                                    dataController.serviceModellist[0],
                                mapuse: true,
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
