import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/Seller.dart';
import '../models/category.dart';
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

  RxList<JobModel> jobModellist = <JobModel>[].obs;

  RxList<JobModel> myjobModellist = <JobModel>[].obs;

  RxList<SellerstatModel> sellerstatslist = <SellerstatModel>[].obs;

  late ServiceModel serviceModel;

  Rxn<SellerstatModel> sellerstats = Rxn<SellerstatModel>();

  EarningModel earningModel = EarningModel(
      activeorders: 0.0,
      currentbalance: 0.0,
      totalearning: 0.0,
      withdrawearning: 0.0);

  PerformanceModel performanceModel = PerformanceModel(
      ontimedelivery: '', orderscomplete: '', positiverating: '', totalgig: '');

  StatisticModel statisticModel =
  StatisticModel(impressions: 0, interaction: 0, reachedout: 0);

  FirebaseFirestore fire = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getSellerListData();
    getCategoryListData();
    getServiceListData();
    getmyServiceListData('xSpMYGibU67gPjQkcF6x');
    getmyOrderListData('xSpMYGibU67gPjQkcF6x');
    myJoblistData('ItrqyV310X2R4Jhqdh2D');
    getSellerStats('lGYqdVhFaT08pZiVfL6i');
  }

  void showloading(bool load){
    loading.value = load;
    update();
  }

  //Seller
  getSellerData(id) async {
    showloading(true);
    final tempseller = await fire.collection('sellers').doc(id).get();

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
      print('Adding data : ' + element['id']);

      sellerlist.add(Seller(
        id: element['id'],
        name: element['name'],
        image: element['image'],
        level: element['level'],
        rating: element['rating'],
        ratingcount: element['ratingcount'],
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
        basic: PlansModel(
            price: basictempService['price'],
            deliverydays: basictempService['delivery'],
            extra: {},
            revisions: ''),
        standard: PlansModel(
            price: standardtempService['price'],
            deliverydays: standardtempService['delivery'],
            extra: {},
            revisions: ''),
        premium: PlansModel(
            price: premiumtempService['price'],
            deliverydays: premiumtempService['delivery'],
            extra: {},
            revisions: ''),
        location: LatLng(tempService['lat'], tempService['long']),
        address: tempService['address']);
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
      final basictempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

      final standardtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('standard')
          .doc(element['postid'])
          .get();

      final premiumtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('premium')
          .doc(element['postid'])
          .get();

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
              name: element['name'],
              ratingcount: element['ratingcount'],
              details: element['details'],
              basic: PlansModel(
                  price: basictempService['price'],
                  deliverydays: basictempService['delivery'],
                  extra: {},
                  revisions: ''),
              standard: PlansModel(
                  price: standardtempService['price'],
                  deliverydays: standardtempService['delivery'],
                  extra: {},
                  revisions: ''),
              premium: PlansModel(
                  price: premiumtempService['price'],
                  deliverydays: premiumtempService['delivery'],
                  extra: {},
                  revisions: ''),
              location: LatLng(element['lat'], element['long']),
              address: element['address']));
    }

    update();

    // ratingcount
    // msg.docs.forEach((element) async {
    //
    //   final id = await element.data()['id'];
    //   final rating = await element.data()['id'];
    //   final level = await element.data()['id'];
    //   final image = await element.data()['id'];
    //   final price = await element.data()['id'];
    //   final name = await element.data()['id'];
    //   final ratingcount = await element.data()['id'];
    //
    //   serviceModellist.add(
    //       ServiceModel(
    //         title: id, rating: rating,
    //         level: level, image: image,
    //         price: price, favorite: false,
    //         name: name, ratingcount: ratingcount,
    //   ));
    //
    // });

    showloading(false);

    return serviceModellist;
  }

  Future<List<ServiceModel>> getFilteredServiceListData({
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
          query = query.where('categoryField', isEqualTo: category);
        }
        break;
      case FilterType.byRating:
        if (minRating != null) {
          query = query.where('ratingField', isGreaterThanOrEqualTo: minRating);
        }
        break;
      case FilterType.byPrice:
        if (minPrice != null) {
          query = query.where('priceField', isGreaterThanOrEqualTo: minPrice);
        }
        if (maxPrice != null) {
          query = query.where('priceField', isLessThanOrEqualTo: maxPrice);
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

      final basictempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

      final standardtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

      final premiumtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

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
        basic: PlansModel(
          price: basictempService['price'],
          deliverydays: basictempService['delivery'],
          extra: {},
          revisions: '',
        ),
        standard: PlansModel(
          price: standardtempService['price'],
          deliverydays: standardtempService['delivery'],
          extra: {},
          revisions: '',
        ),
        premium: PlansModel(
          price: premiumtempService['price'],
          deliverydays: premiumtempService['delivery'],
          extra: {},
          revisions: '',
        ),
        location: LatLng(element['lat'], element['long']),
        address: element['address'],
        imageurls: element['imagelist'],
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
        .where('id', isEqualTo: id);

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      dataList.add(doc.data());
    }

    print('Data collection is completed');

    for (var element in dataList) {
      // print('Adding data services : '+ element['id']);

      final basictempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

      final standardtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

      final premiumtempService = await fire
          .collection('services')
          .doc(element['postid'])
          .collection('basic')
          .doc(element['postid'])
          .get();

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
          basic: PlansModel(
              price: basictempService['price'],
              deliverydays: basictempService['delivery'],
              extra: {},
              revisions: ''),
          standard: PlansModel(
              price: standardtempService['price'],
              deliverydays: standardtempService['delivery'],
              extra: {},
              revisions: ''),
          premium: PlansModel(
              price: premiumtempService['price'],
              deliverydays: premiumtempService['delivery'],
              extra: {},
              revisions: ''),
          imageurls: element['imagelist']
      ));
    }
    showloading(false);
    update();
  }

  getmyOrderListData(id) async {

    showloading(true);

    ordermodel.add(
      OrderModel(
          amount: '2000',
          client: 'Dre',
          createdAt: Timestamp.now(),
          datestr: '2013/30/14',
          deadline: Timestamp.now(),
          duration: '3',
          id: '3io4h45',
          seller: 'Doctor',
          status: 'Active',
          title: 'New Project Bl',
          postbyid: 'sfdfefersfad'),
    );
    ordermodel.add(
      OrderModel(
          amount: '2000',
          client: 'Dre',
          createdAt: Timestamp.now(),
          datestr: '2013/30/34',
          deadline: Timestamp.now(),
          duration: '3',
          id: '3lfjkld',
          seller: 'Doctor',
          status: 'Pending',
          title: 'New Proct Bl',
          postbyid: '83948'),
    );

    final collection = FirebaseFirestore.instance
        .collection('orders')
        .where('postbyid', isEqualTo: id);

    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      print('This is the date required');

      dataList.add(doc.data() as Map<String, dynamic>);
    }

    print('Data collection is completed');

    for (var element in dataList) {
      print('Adding data services : ' + element['id']);

      // ignore: invalid_use_of_protected_member
      ordermodel.value.add(OrderModel(
        title: element['title'],
        deadline: element['deadline'],
        datestr: element['datestr'],
        seller: element['seller'],
        amount: element['amount'],
        duration: element['duration'],
        id: element['id'],
        createdAt: element['createdAt'],
        status: element['status'],
        postbyid: element['postbyid'],
        client: element['client'],
      ));
    }
    showloading(false);
    update();
  }

  myJoblistData(id) async {
    showloading(true);
    final collection = FirebaseFirestore.instance
        .collection('jobs')
        .where('id', isEqualTo: id);
    final querySnapshot = await collection.get();

    List<Map<String, dynamic>> dataList = [];

    for (var doc in querySnapshot.docs) {
      print('This is the date required');

      dataList.add(doc.data() as Map<String, dynamic>);
    }

    print('Data collection is completed');

    for (var element in dataList) {
      // print('Adding data : ' + element['id']);

      myjobModellist.value.add(JobModel(
        postby: '',
        postid: '',
        title: element['title'],
        desc: element['desc'],
        id: element['id'],
        status: element['status'],
        date: element['date'],
        datestr: element['datestr'],
        category: element['category'],
        location: LatLng(0.0, 0.0),
        // img: element['img'],
      ));
    }
    showloading(false);
    update();
  }

  getSellerStats(id) async {
    // final collectionperformance = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(id).collection('performance');
    //
    // final collectionearnings = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(id).collection('earning');
    //
    // final collectionstatistics = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(id).collection('statistics');
    //
    // final querySnapshotp = await collectionperformance.get();
    // final querySnapshote = await collectionearnings.get();
    // final querySnapshots = await collectionstatistics.get();
    //
    // List<Map<String, dynamic>> dataList = [];
    //
    // for (var element in dataList) {}

    showloading(true);

    final userperformance = await fire
        .collection('users')
        .doc(id)
        .collection('performance')
        .doc('10/5/2020')
        .get();
    final userearning = await fire
        .collection('users')
        .doc(id)
        .collection('earning')
        .doc('10/5/2020')
        .get();
    final userstats = await fire
        .collection('users')
        .doc(id)
        .collection('statistics')
        .doc('10/5/2020')
        .get();

    // print('Adding data services : '+ element['id']);
    print('Now collection performance data');

    if (userperformance.exists) {
      print('Performance exists');

      performanceModel = PerformanceModel(
        ontimedelivery: userperformance['ontimedelivery'],
        orderscomplete: userperformance['orderscomplete'],
        positiverating: userperformance['positiverating'],
        totalgig: userperformance['totalgig'],
      );
    } else {
      print('Performance doesn\'t exists');

      performanceModel = PerformanceModel(
          ontimedelivery: '0',
          orderscomplete: '0',
          positiverating: '0.0',
          totalgig: '0 of 0');
    }

    if (userearning.exists) {
      print('Performance Exists');

      earningModel = EarningModel(
          activeorders: userearning['activeorders'],
          currentbalance: userearning['currentbalance'],
          totalearning: userearning['totalearning'],
          withdrawearning: userearning['withdrawearning']);
    } else {
      print('Performance doesn\'t exists');

      earningModel = EarningModel(
          activeorders: 0.0,
          currentbalance: 0.0,
          totalearning: 0.0,
          withdrawearning: 0.0);
    }

    if (userstats.exists) {
      print('Performance Exists');

      statisticModel = StatisticModel(
          impressions: userstats['impressions'],
          interaction: userstats['interaction'],
          reachedout: userstats['reachedout']);
    } else {
      print('Performance doesn\'t exists');

      statisticModel =
          StatisticModel(impressions: 0.0, interaction: 0.0, reachedout: 0.0);
    }

    sellerstats.value = SellerstatModel(
        statisticModel: statisticModel,
        earningModel: earningModel,
        performanceModel: performanceModel);
    showloading(false);
    update();
  }
}
