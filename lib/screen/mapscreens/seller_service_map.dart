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
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

import '../../models/map/joblocation.dart';
import '../client screen/search/searchresult.dart';
import '../widgets/constant.dart';

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

  CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    addMarkers();
    mapController.analyzeDatajob(data: dataController.jobModellist);
    getinitiallocation();
  }

  final List<JobLocation> jobLocations = [
    // Alabama
    JobLocation('Birmingham, AL', 33.5186, -86.8104, 30),

    // Alaska
    JobLocation('Anchorage, AK', 61.2181, -149.9003, 25),

    // Arizona
    JobLocation('Phoenix, AZ', 33.4484, -112.0740, 55),

    // Arkansas
    JobLocation('Little Rock, AR', 34.7465, -92.2896, 20),

    // California
    JobLocation('Los Angeles, CA', 34.0522, -118.2437, 80),

    // Colorado
    JobLocation('Denver, CO', 39.7392, -104.9903, 65),

    // Connecticut
    JobLocation('Hartford, CT', 41.7658, -72.6734, 20),

    // Delaware
    JobLocation('Wilmington, DE', 39.7391, -75.5398, 15),

    // Florida
    JobLocation('Miami, FL', 25.7617, -80.1918, 40),

    // Georgia
    JobLocation('Atlanta, GA', 33.7490, -84.3880, 65),

    // Hawaii
    JobLocation('Honolulu, HI', 21.3069, -157.8583, 25),

    // Idaho
    JobLocation('Boise, ID', 43.6150, -116.2023, 15),

    // Illinois
    JobLocation('Chicago, IL', 41.8781, -87.6298, 60),

    // Indiana
    JobLocation('Indianapolis, IN', 39.7684, -86.1581, 30),

    // Iowa
    JobLocation('Des Moines, IA', 41.5868, -93.6250, 20),

    // Kansas
    JobLocation('Wichita, KS', 37.6872, -97.3301, 15),

    // Kentucky
    JobLocation('Louisville, KY', 38.2527, -85.7585, 25),

    // Louisiana
    JobLocation('New Orleans, LA', 29.9511, -90.0715, 30),

    // Maine
    JobLocation('Portland, ME', 43.6615, -70.2553, 10),

    // Maryland
    JobLocation('Baltimore, MD', 39.2904, -76.6122, 35),

    // Massachusetts
    JobLocation('Boston, MA', 42.3601, -71.0589, 70),

    // Michigan
    JobLocation('Detroit, MI', 42.3314, -83.0458, 50),

    // Minnesota
    JobLocation('Minneapolis, MN', 44.9778, -93.2650, 35),

    // Mississippi
    JobLocation('Jackson, MS', 32.2988, -90.1848, 10),

    // Missouri
    JobLocation('Kansas City, MO', 39.0997, -94.5786, 30),

    // Montana
    JobLocation('Billings, MT', 45.7833, -108.5007, 10),

    // Nebraska
    JobLocation('Omaha, NE', 41.2565, -95.9345, 15),

    // Nevada
    JobLocation('Las Vegas, NV', 36.1699, -115.1398, 40),

    // New Hampshire
    JobLocation('Manchester, NH', 42.9956, -71.4548, 10),

    // New Jersey
    JobLocation('Newark, NJ', 40.7357, -74.1724, 25),

    // New Mexico
    JobLocation('Albuquerque, NM', 35.0844, -106.6504, 20),

    // New York
    JobLocation('New York City, NY', 40.7128, -74.0060, 120),

    // North Carolina
    JobLocation('Charlotte, NC', 35.2271, -80.8431, 60),

    // North Dakota
    JobLocation('Fargo, ND', 46.8772, -96.7898, 10),

    // Ohio
    JobLocation('Columbus, OH', 39.9612, -82.9988, 55),

    // Oklahoma
    JobLocation('Oklahoma City, OK', 35.4676, -97.5164, 25),

    // Oregon
    JobLocation('Portland, OR', 45.5051, -122.6750, 35),

    // Pennsylvania
    JobLocation('Philadelphia, PA', 39.9526, -75.1652, 50),

    // Rhode Island
    JobLocation('Providence, RI', 41.8240, -71.4128, 15),

    // South Carolina
    JobLocation('Charleston, SC', 32.7765, -79.9311, 20),

    // South Dakota
    JobLocation('Sioux Falls, SD', 43.5446, -96.7311, 10),

    // Tennessee
    JobLocation('Nashville, TN', 36.1627, -86.7816, 40),

    // Texas
    JobLocation('Houston, TX', 29.7604, -95.3698, 90),

    // Utah
    JobLocation('Salt Lake City, UT', 40.7608, -111.8910, 25),

    // Vermont
    JobLocation('Burlington, VT', 44.4759, -73.2121, 10),

    // Virginia
    JobLocation('Virginia Beach, VA', 36.8529, -75.9780, 30),

    // Washington
    JobLocation('Seattle, WA', 47.6062, -122.3321, 80),

    // West Virginia
    JobLocation('Charleston, WV', 38.3498, -81.6326, 10),

    // Wisconsin
    JobLocation('Milwaukee, WI', 43.0389, -87.9065, 25),

    // Wyoming
    JobLocation('Cheyenne, WY', 41.1400, -104.8202, 10),
  ];

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
          zoom: 8.0,
        );
      });
    }
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
            width: widget.selectmap ? 300 : MediaQuery.of(context).size.width,
            height: widget.selectmap ? 500 : MediaQuery.of(context).size.height,
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
                                          height: MediaQuery.of(context).size
                                                  .height * 0.7,
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
                                initialMarkersCount: data.jobresultlist.length,
                                markerBuilder: (BuildContext context, int index) {

                                  final JobLocation jobLocation = data.jobresultlist[index];

                                  return MapMarker(
                                    latitude: jobLocation.latitude,
                                    longitude: jobLocation.longitude,
                                    child: GestureDetector(
                                      onTap: (){
                                        SearchResultScreen(
                                          titlecategory: '',
                                          jobsearch: false,)
                                            .launch(context);

                                      },
                                      child: CircleAvatar(
                                        backgroundColor: kPrimaryColor.withOpacity(0.5),
                                        radius: 15,
                                        child: Text(
                                            jobLocation.jobCount.toString(),
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

                              // ServiceCard(
                              //   servicedata: data.selecteddata ??
                              //       dataController.serviceModellist[0],
                              //   mapuse: true,
                              // ),

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
