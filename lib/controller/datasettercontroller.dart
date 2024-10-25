import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:contractus/models/service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class DataSetterController extends GetxController {

  DataController datactrl = Get.put(DataController());

  Auth_Controller authy = Get.put(Auth_Controller());

  FirebaseFirestore fire = FirebaseFirestore.instance;

  FirebaseAuth fireAuth = FirebaseAuth.instance;

  CategoryModel categoryModel = CategoryModel(
    category: '',
    subcategory: [],
    icon: null,
  );

  changestatusContract({contractId,status,name,iseller}) async {

    // authy.

    await fire.collection('contracts')
        .doc(contractId)
        .update({
      'seller' : name,
      'status': status,
        });
    datactrl.getmyOrderListData(id:fireAuth.currentUser!.uid,iseller: iseller);
  }

  addContract({required OrderModel contract}) async {

    var uuid = const Uuid();

    // Generate a v1 (time-based) id
    var v1 = uuid.v1();

    await fire.collection('contracts')
        .doc(contract.contractid)
        .set(contract.toMap());

  }

  addnewservice({
    required String postedby,
    required String name,
    required String rating,
    required String level,
    required bool favorite,
    required String title,
    required String details, //service description
    required String selectedCategory,
    required String subcategory,
    required String selectedServiceType,
    required List images,
    required String price,
    required int ratingcount,
    required String image,
    required String? address,
    required LatLng location,
  }) async {

    //
    var uuid = const Uuid();

    // Generate a v1 (time-based) id
    var v1 = uuid.v1();

    await fire.collection('services').doc(v1).set({
      'selectedCategory': selectedCategory,
      'subcategory': subcategory,
      'selectedServiceType': selectedServiceType,
      'postedby': postedby,
      'postid': v1,
      'title': title,
      'level': level,
      'price': price,
      'name': name,
      'rating': rating,
      'image': image,
      'imagelist': images,
      'ratingcount': rating,
      'details': details,
      'address': address,
      'lat': location.latitude,
      'long': location.longitude,
    });

    // await fire.collection('services').doc(v1).collection('basic').doc(v1).set({
    //   'price': basic.price,
    //   'delivery': basic.deliverydays,
    // });
    //
    // await fire
    //     .collection('services')
    //     .doc(v1)
    //     .collection('standard')
    //     .doc(v1)
    //     .set({
    //   'price': standard.price,
    //   'delivery': standard.deliverydays,
    // });
    // await fire
    //     .collection('services')
    //     .doc(v1)
    //     .collection('premium')
    //     .doc(v1)
    //     .set({
    //   'price': premium.price,
    //   'delivery': premium.deliverydays,
    // });

    datactrl.getServiceListData();

    update();
  }

  addnewjob({
    required String imageurl,
    required String postby,
    required String category,
    required Timestamp date,
    required String datestr,
    required String desc,
    required String status,
    required String title,
    required String subcategory,
    //shit you forget
    required String deliveryTime,
    required String estimatedDuration,
    // required String price,
    required String payRate,
    required LatLng location,
    required String address,
  }) async {

    //
    var uuid = const Uuid();

    // Generate a v1 (time-based) id
    var v1 = uuid.v1();

    await fire.collection('jobs').doc(v1).set({
      'postby': postby,
      'postid': v1,
      'category': category,
      'subcategory': subcategory,
      'date': date,
      'datestr': datestr,
      'desc': desc,
      'status': status,
      'title': title,
      'deliveryTime': deliveryTime,
      "estimated duration": estimatedDuration,
      // 'price': price,
      "payment rate": payRate,
      'address': address,
      'lat': location.latitude,
      'long': location.longitude,
    });
  }
}
