import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/models/auth_data.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/contract.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Seller.dart';
import '../models/job_model.dart';
import '../models/sellermodels/earnings.dart';
import '../models/sellermodels/performance.dart';
import '../models/sellermodels/sellerstats.dart';
import '../models/sellermodels/statistics.dart';
import '../models/service.dart';

enum FilterType {
  all,
  byCategory,
  byRating,
  byPrice, // Add more filter types as needed
}

enum SortBy {
  none,
  priceAscending,
  priceDescending,
  ratingDescending, // Add more sorting options as needed
}

class DataController extends GetxController {

  RxBool loading = false.obs;

  RxList<OrderModel> ordermodel = <OrderModel>[].obs;

  late CategoryModel category;

  List<CategoryModel> categorylist = [
    CategoryModel(
      // icon: Icons,
      category: 'Home Maintenance and Repair',
      subcategory: [
        'Plumbing repairs',
        'Electrical work',
        'HVAC maintenance',
        'Carpentry',
        'Painting',
        'Roofing repairs',
        'Window and door installation',
        'Flooring installation and repair',
        'Appliance repair',
        'Construction and Renovation',
      ],
      icon: Icons.home_repair_service,
    ),
    CategoryModel(
        category: 'General contracting',
        subcategory: [
          'Home renovation projects',
          'Landscaping and gardening',
          'Concrete work',
          'Masonry',
          'Tile installation',
          'Demolition',
          'Cleaning and Housekeeping',
          'Home renovation projects',
          'Home renovation projects',
        ],
        icon: Icons.construction),
    CategoryModel(
        category: 'Transportation and Delivery',
        subcategory: [
          'Moving services',
          'Courier and delivery services',
          'Ride-sharing',
          'Vehicle detailing',
          'Towing services',
          'Logistics and transportation coordination',
        ],
        icon: Icons.local_shipping),
    CategoryModel(
        category: 'Residential cleaning',
        subcategory: [
          'Commercial cleaning',
          'Carpet cleaning',
          'Window washing',
          'Gutter cleaning',
          'Power washing',
          'Pool cleaning and maintenance',
          'Healthcare and Wellness',
        ],
        icon: Icons.cleaning_services),
    CategoryModel(
        category: 'Personal training',
        subcategory: [
          'Physical therapy',
          'Massage therapy',
          'Home healthcare services',
          'Elder care and companionship',
          'Nursing services',
          'Nutrition consultation',
          'Education and Tutoring',
        ],
        icon: Icons.fitness_center),
    CategoryModel(
        category: 'Private tutoring',
        subcategory: [
          'Music lessons',
          'Language instruction',
          'Test preparation',
          'Special education services',
          'College admissions coaching',
        ],
        icon: Icons.school),
  ];

  late Seller seller;

  RxList<Seller> sellerlist = <Seller>[].obs;

  RxList<ServiceModel> serviceModellist = <ServiceModel>[].obs;
  RxList<ServiceModel> serviceModelfilteredlist = <ServiceModel>[].obs;
  RxList<ServiceModel> myserviceModellist = <ServiceModel>[].obs;

  RxList<ContractModel> contractlist = <ContractModel>[].obs;

  RxList<JobModel> jobModellist = <JobModel>[].obs;

  RxList<JobModel> myjobModellist = <JobModel>[].obs;

  RxList<SellerstatModel> sellerstatslist = <SellerstatModel>[].obs;

  late ServiceModel serviceModel;

  SellerstatModel sellerstats = SellerstatModel(
      statisticModel: StatisticModel(impressions: 0, interaction: 0, reachedout: 0),
      earningModel: EarningModel(
          activeorders: 0.0,
          currentbalance: 0.0,
          totalearning: 0.0,
          withdrawearning: 0.0),
      performanceModel: PerformanceModel(
          ontimedelivery: '', orderscomplete: '', positiverating: '', totalgig: '')
  );

  EarningModel earningModel = EarningModel(
      activeorders: 0.0,
      currentbalance: 0.0,
      totalearning: 0.0,
      withdrawearning: 0.0);

  Auth_Controller authy = Get.put(Auth_Controller());

  PerformanceModel performanceModel = PerformanceModel(
      ontimedelivery: '', orderscomplete: '', positiverating: '', totalgig: '');

  StatisticModel statisticModel =
      StatisticModel(impressions: 0, interaction: 0, reachedout: 0);

  FirebaseFirestore fire = FirebaseFirestore.instance;
  FirebaseAuth fireauth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSellerListData();
    // getCategoryListData();
    getServiceListData();
    joblistData();
  }

  void loadalldata() {
    if (authy.signedin.value) {
      if (authy.authData.value!.role == 'seller') {
        if (authy.signedin.value) {
          joblistData();

          if (authy.authData.value!.role == 'seller') {
            getmyServiceListData(authy.authData.value!.id);
          } else {
            myJoblistData(authy.authData.value!.id);
          }
        }
        // getmyOrderListData('xSpMYGibU67gPjQkcF6x');
      }
    }
    update();
  }

  void showloading(bool load) {
    loading.value = load;
    update();
  }

  //Seller
  getSellerData(id) async {

    showloading(true);

    final tempseller = await fire.collection('users').doc(id).get();

    seller = Seller(
        id: tempseller['id'],
        name: tempseller['name'],
        image: tempseller['image'],
        level: tempseller['level'],
        rating: tempseller['rating'],
        ratingcount: tempseller['ratingcount']);

    showloading(false);

    return seller;

  }

  getSellerListData() async {

    showloading(true);

    final collection = FirebaseFirestore.instance.collection('sellers');

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      print('This is the date required');

      dataList.add(doc.data() as Map<String, dynamic>);
    }

    print('Data collection is completed');

    for (var element in dataList) {
      // print('Adding data : ' + element['id']);

      sellerlist.add(Seller(
        id: element['id'],
        name: element['name'],
        image: element['image'],
        level: element['level'],
        rating: element['rating'] ?? '',
        ratingcount: element['ratingcount'] ?? '',
      ));

    }
    showloading(false);
    update();

    return sellerlist;
  }

  //Category
  getCategoryData(id) async {
    showloading(true);
    final tempcategory = await fire.collection('category').doc(id).get();

    // category = CategoryModel(
    //     title: tempcategory[''],
    //     desc: tempcategory[''],
    //     img: tempcategory['']
    // );
    //
    // category = CategoryModel(category: '', subcategory: []);

    showloading(false);
    return category;
  }

  getCategoryListData() async {
    // final collection = FirebaseFirestore.instance.collection('category');
    // final querySnapshot = await collection.get();
    //
    // List<Map<String, dynamic>> dataList = [];
    //
    // for (var doc in querySnapshot.docs) {
    //
    //   print('This is the date required');
    //
    //   dataList.add(doc.data() as Map<String, dynamic>);
    //
    // }

    // print('Data collection is completed');
    //
    // for (var element in dataList) {
    //
    //   categorylist.value = CategoryModel.categorylist;
    // }

    // categorylist = CategoryModel(category: '', subcategory: []).categorylist;

    update();

    return categorylist;
  }

  //Service
  getServiceData(id) async {
    showloading(true);
    final tempService = await fire.collection('services').doc(id).get();

    final basictempService = await fire
        .collection('services')
        .doc(id)
        .collection('basic')
        .doc(tempService['postid'])
        .get();

    final standardtempService = await fire
        .collection('services')
        .doc(id)
        .collection('basic')
        .doc(tempService['postid'])
        .get();

    final premiumtempService = await fire
        .collection('services')
        .doc(id)
        .collection('basic')
        .doc(tempService['postid'])
        .get();

    serviceModel = ServiceModel(
        imageurls: tempService['imagelist'],
        postedby: tempService['postedby'],
        postid: tempService['postid'],
        title: tempService['title'],
        rating: tempService['rating'],
        level: tempService['level'],
        image: tempService['image'],
        price: tempService['price'],
        favorite: false,
        name: tempService['name'],
        ratingcount: tempService['ratingcount'],
        details: tempService['details'],
        location: LatLng(tempService['lat'], tempService['long']),
        address: tempService['address'],
        category: tempService['selectedCategory'],
        subcategory: tempService['subcategory']);
    showloading(false);
    return serviceModel;
  }

  getServiceListData() async {

    showloading(true);

    serviceModellist.value.clear();

    final collection = FirebaseFirestore.instance.collection('services');

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data() as Map<String, dynamic>);
    }

    for (var element in dataList) {

      print('get service list: ${element['title']}');

      serviceModellist.value.add(
        ServiceModel(
          imageurls: element['imagelist'],
          postedby: element['postedby'],
          postid: element['postid'],
          title: element['title'],
          rating: element['rating'],
          level: element['level'],
          image: element['image'],
          price: element['price'],
          favorite: false,
          name: element['name'] ?? '',
          ratingcount: element['ratingcount'] ?? '',
          details: element['details'] ?? '',
          location: LatLng(
            element['lat']?.toDouble() ?? 0.0,
            element['lat']?.toDouble() ?? 0.0,
          ),
          address: element['address'],
            category: element['selectedCategory'],
            subcategory: element['subcategory']
        ),
      );

    }

    update();

    showloading(false);

    return serviceModellist.value;
  }

  Future<List<ServiceModel>>
  getFilteredServiceListData({
    required FilterType filterType,
    String? category,
    double? minRating,
    double? minPrice,
    double? maxPrice,
    LatLng? location, // Optional filter by location (requires GeoFirestore)
    required SortBy sortBy,
  }) async {
    final collection = FirebaseFirestore.instance.collection('services');

    Query query = collection;

    switch (filterType) {
      case FilterType.all:
        // No filtering, use the original query
        break;
      case FilterType.byCategory:
        if (category != null) {
          query = query.where('category', isEqualTo: category);
        }
        break;
      case FilterType.byRating:
        if (minRating != null) {
          query = query.where('rating', isGreaterThanOrEqualTo: minRating);
        }
        break;
      case FilterType.byPrice:
        if (minPrice != null) {
          query = query.where('price', isGreaterThanOrEqualTo: minPrice);
        }
        if (maxPrice != null) {
          query = query.where('price', isLessThanOrEqualTo: maxPrice);
        }
        break;
    }

    // handling some cases
    if (category != null && filterType != FilterType.byCategory) {
      query = query.where('categoryField', isEqualTo: category);
    }
    if (minRating != null && filterType != FilterType.byRating) {
      query = query.where('ratingField', isGreaterThanOrEqualTo: minRating);
    }
    if (minPrice != null && filterType != FilterType.byPrice) {
      query = query.where('priceField', isGreaterThanOrEqualTo: minPrice);
    }
    if (maxPrice != null && filterType != FilterType.byPrice) {
      query = query.where('priceField', isLessThanOrEqualTo: maxPrice);
    }

    switch (sortBy) {
      case SortBy.none:
        // No sorting
        break;
      case SortBy.priceAscending:
        query = query.orderBy('priceField', descending: false);
        break;
      case SortBy.priceDescending:
        query = query.orderBy('priceField', descending: true);
        break;
      case SortBy.ratingDescending:
        query = query.orderBy('ratingField', descending: true);
        break;
    }

    final querySnapshot = await query.get();

    RxList<ServiceModel> newserviceModelList = <ServiceModel>[].obs;

    for (var doc in querySnapshot.docs) {
      final element = doc.data() as Map<String, dynamic>;

      newserviceModelList.value.add(ServiceModel(
        postedby: element['postedby'],
        postid: element['postid'],
        title: element['title'],
        rating: element['rating'],
        level: element['level'],
        image: element['image'],
        price: element['price'],
        favorite: false,
        name: element['name'],
        ratingcount: element['ratingcount'],
        details: element['details'],
        location: LatLng(element['lat'], element['long']),
        address: element['address'],
        imageurls: element['imagelist'],
          category: element['selectedCategory'],
          subcategory: element['subcategory']
      ));
    }

    serviceModelfilteredlist = newserviceModelList;

    update();

    return newserviceModelList;
  }

  getmyServiceListData(id) async {
    showloading(true);

    final collection = FirebaseFirestore.instance
        .collection('services')
        .where('postedby', isEqualTo: id);

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data());
    }

    for (var element in dataList) {

      // ignore: invalid_use_of_protected_member
      myserviceModellist.value.add(ServiceModel(
          address: element['address'],
          location: LatLng(element['lat'], element['long']),
          postedby: element['postedby'],
          postid: element['postid'],
          title: element['title'],
          rating: element['rating'],
          level: element['level'],
          image: element['image'],
          price: element['price'],
          favorite: element['favorite'],
          name: element['name'],
          ratingcount: element['ratingcount'],
          details: element['details'],
          imageurls: element['imagelist'],
          category: element['selectedCategory'],
          subcategory: element['subcategory'])
      );

    }
    showloading(false);
    update();
  }

  getmyOrderListData({id,required bool iseller}) async {

    showloading(true);

    ordermodel.value.clear();

    var collection;

    if(iseller){
      print('Sellerid : ' + id);
      collection = FirebaseFirestore.instance
        .collection('contracts')
        .where('sellerid', isEqualTo: id);


    }else{
      collection = FirebaseFirestore.instance
        .collection('contracts')
        .where('postbyid', isEqualTo: id);
      print('postbyid : ' + id);
    }

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data());
    }

    for (var element in dataList) {

      // ignore: invalid_use_of_protected_member
      ordermodel.value.add(
          OrderModel(
        description: element['description'],
        title: element['title'],
        deadline: element['deadline'],
        datestr: element['datestr'],
        seller: element['seller'],
        amount: element['amount'],
        duration: element['duration'],
        postid: element['id'],
        createdAt: element['createdAt'],
        status: element['status'],
        postbyid: element['postbyid'],
        client: element['client'],
        sellerid: element['sellerid'],
        clientid: element['clientid'],
        invoicedate: element['invoicedate'],
        contractid: element['contractid'],
        category: element['category'],
        subcategory: element['subcategory'],
      ));

    }

    showloading(false);

    update();

  }

  myJoblistData(id) async {

    showloading(true);

    final collection = FirebaseFirestore.instance
        .collection('jobs')
        .where('postby', isEqualTo: id);
    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data() as Map<String, dynamic>);
    }

    print('Data collection is completed');

    for (var element in dataList) {
      // print('Adding data : ' + element['id']);

      myjobModellist.value.add(JobModel(
        postby: element['postby'],
        postid: element['postid'],
        paymentrate: element['payment rate'],
        location: LatLng(element['lat'], element['long']),
        estduration: element['estimated duration'],
        title: element['title'],
        desc: element['desc'],
        status: element['status'],
        date: element['date'],
        datestr: element['datestr'],
        category: element['category'],
        subcategory: '', address: '',

        // img: element['img'],
      ));
    }
    showloading(false);
    update();
  }

  joblistData() async {
    showloading(true);

    final collection = FirebaseFirestore.instance.collection('jobs');
    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data() as Map<String, dynamic>);
    }

    for (var element in dataList) {
      // print('Adding data : ' + element['desc']);

      jobModellist.value.add(
          JobModel(
        postby: element['postby'],
        postid: element['postid'],
        paymentrate: element['payment rate'],
        location: LatLng(element['lat'], element['long']),
        estduration: element['estimated duration'],
        title: element['title'],
        desc: element['desc'] ?? '',
        status: element['status'],
        date: element['date'],
        datestr: element['datestr'],
        category: element['category'], subcategory: '', address: '',
        // img: element['img'],
      ));
    }
    showloading(false);
    update();
  }


}
