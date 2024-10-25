import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datasettercontroller.dart';
import 'package:contractus/models/sellermodels/ordermodel.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:contractus/screen/widgets/custom_buttons/customformfield.dart';
import 'package:contractus/screen/widgets/custom_buttons/simplebutton.dart';
import 'package:contractus/screen/widgets/textfield.dart';
import 'package:contractus/screen/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../controller/datacontroller.dart';
import '../models/categorymodel.dart';

class GenerateContract extends StatefulWidget {
  GenerateContract({
    required this.postid,
    required this.sellerid,
  });

  String postid;
  String sellerid;

  @override
  State<GenerateContract> createState() => _GenerateContractState();
}

class _GenerateContractState extends State<GenerateContract> {

  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String selectedEstimatedDurationList = '';

  final _formKey = GlobalKey<FormState>();
  DataController datactrl = Get.put(DataController());

  String selectedCategory = '';
  String selectedSubCategory = '';

  DataSetterController setterController = Get.put(DataSetterController());
  Auth_Controller authy = Get.put(Auth_Controller());
  int categoryindex = 0;

  //__________Estimated Duration________________________________________________________
  DropdownButton<String> getEstimatedDuration() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in estimatedDuration) {

      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );

      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedEstimatedDurationList.isEmpty
          ? null
          : selectedEstimatedDurationList,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (String? value) {
        setState(() {
          selectedEstimatedDurationList = value ?? '';
        });
      },
    );
  }

  //__________Category_______________________________________________________________
  DropdownButton<String> getCategory() {
    List<DropdownMenuItem<String>> dropDownItems = [];

    for (CategoryModel des in datactrl.categorylist) {
      var item = DropdownMenuItem(
        value: des.category,
        child: Text(des.category),
      );
      dropDownItems.add(item);
    }

    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedCategory.isEmpty ? null : selectedCategory,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedCategory = value ?? '';
          int index = 0;

          for (var element in datactrl.categorylist) {
            if (element.category.contains(selectedCategory)) {
              categoryindex = index;
              selectedSubCategory = '';
            } else {
              index++;
            }
          }
        });
      },
    );
  }

  //__________SubCategory____________________________________________________________
  DropdownButton<String> getSubCategory() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in datactrl.categorylist[categoryindex].subcategory) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedSubCategory.isEmpty ? null : selectedSubCategory,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedSubCategory = value!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Generate a new contract',
          style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [

                CustomTextFormField(
                  hint:'Service title',
                  textController: titlecontroller,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(
                      title: 'Category',
                      child: getCategory()
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(
                      title: 'Sub-Category',
                      child: getSubCategory()
                  ),
                ),

                CustomTextFormField(
                  hint:'Description',
                  maxline: 5,
                  textController: descController,
                ),

                CustomTextFormField(
                  hint:'Amount',
                  textController: amountController,
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomFormField(
                      title: 'Estimation Duration',
                      child: getEstimatedDuration()
                  ),
                ),



              ],
                ),
            ),
            SimpleButton(
              title: 'Send Offer',
              ontap: () {

                final Timestamp timestamp = Timestamp.now();

                if(_formKey.currentState!.validate()){

                  var uuid = const Uuid();

                  // Generate a v1 (time-based) id
                  var v1 = uuid.v1();

                  setterController.addContract(
                      contract: OrderModel(
                      sellerid: widget.sellerid,
                        category: selectedCategory,
                        subcategory: selectedSubCategory,
                      clientid: authy.authData.value!.id,
                      amount: amountController.text,
                      client: authy.authData.value!.name,
                      createdAt: Timestamp.now(),
                      datestr: '',
                      deadline: Timestamp.now(),
                      duration: selectedEstimatedDurationList,
                      postid: widget.postid,
                      seller: '',
                      status: 'Pending',
                      description: descController.text,
                      title: titlecontroller.text,
                      postbyid: authy.authData.value!.id,
                      invoicedate: Timestamp.now(),
                        contractid: authy.authData.value!.id+v1,
                      )
                  );
                  Get.back( result: authy.authData.value!.id+v1 );
                }

            },),
          ],
        ),
      ),
    );
  }
}
