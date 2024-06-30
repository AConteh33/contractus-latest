import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/controller/datasettercontroller.dart';
import 'package:contractus/controller/mapcontroller.dart';
import 'package:contractus/models/service.dart';
import 'package:contractus/screen/client%20screen/client%20service%20details/client_service_map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:contractus/screen/widgets/button_global.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import '../../../controller/authcontroller.dart';
import '../../../controller/imagecontroller.dart';
import '../../../models/categorymodel.dart';
import '../../../models/imageModel.dart';
import '../../widgets/constant.dart';
class CreateNewJobPost extends StatefulWidget {
  const CreateNewJobPost({Key? key}) : super(key: key);

  @override
  State<CreateNewJobPost> createState() => _CreateNewJobPostState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController pricenumber = TextEditingController();
TextEditingController description = TextEditingController();
String selectedCategory = '';
TextEditingController title = TextEditingController();
String selectedDeliveryTimeList = '';



class _CreateNewJobPostState extends State<CreateNewJobPost> {

  int currentIndexPage = 0;
  double percent = 33.3;

  DataController datactrl = Get.put(DataController());
  MediaController imagectrl = Get.put(MediaController());
  Auth_Controller authy = Get.put(Auth_Controller());
  MapController mapctrl = Get.put(MapController());
  PageController pagec = PageController();
  String image = '';
  String imageurl = "";
  String errortest = '';

  int categoryindex = 0;

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


  DataSetterController dataSetterController = Get.put(DataSetterController());


  //__________DeliveryTime________________________________________________________
  DropdownButton<String> getDeliveryTime() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in deliveryTimeList) {

      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );

      dropDownItems.add(item);

    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedDeliveryTimeList.isEmpty ? null : selectedDeliveryTimeList,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (String? value) {
        setState(() {
          selectedDeliveryTimeList = value ??'';
        });
      },
    );
  }


  @override
  void initState() {
    super.initState();
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
          'Create New Job Post',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      body: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
      width: context.widthTransformer(),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: const BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30.0),
          topLeft: Radius.circular(30.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              'Overview',
              style: kTextStyle.copyWith(
                  color: kNeutralColor, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              child:
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 5.0),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: kNeutralColor,
                          textInputAction: TextInputAction.next,
                          controller: title,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your title';
                            } else {
                              return null;
                            }
                          },
                          decoration: kInputDecoration.copyWith(
                            labelText: 'Job Title',
                            labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                            hintText: 'Enter job title',
                            hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                            focusColor: kNeutralColor,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        FormField(
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: kInputDecoration.copyWith(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: kBorderColorTextField, width: 2),
                                ),
                                contentPadding: const EdgeInsets.all(7.0),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: 'Choose a Category',
                                labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                              ),
                              child:
                              DropdownButtonHideUnderline(child: getCategory()),
                            );

                          },
                          // validator: (String? value) {
                          //   if (selectedCategory.isEmpty) {
                          //     return 'Please enter category';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        const SizedBox(height: 20.0),
                        FormField(
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: kInputDecoration.copyWith(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: kBorderColorTextField,
                                      width: 2),
                                ),
                                contentPadding: const EdgeInsets.all(7.0),
                                floatingLabelBehavior:
                                FloatingLabelBehavior.always,
                                labelText: 'Subcategory',
                                labelStyle: kTextStyle.copyWith(
                                    color: kNeutralColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              child: DropdownButtonHideUnderline(
                                  child: getSubCategory()),
                            );
                          },
                          // validator: (String? value) {
                          //   if (selectedSubCategory.isEmpty) {
                          //     return 'Please enter subcategory';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        const SizedBox(height: 20.0),
                        FormField(
                          builder: (FormFieldState<dynamic> field) {
                            return InputDecorator(
                              decoration: kInputDecoration.copyWith(
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                  borderSide: BorderSide(
                                      color: kBorderColorTextField, width: 2),
                                ),
                                contentPadding: const EdgeInsets.all(7.0),
                                floatingLabelBehavior: FloatingLabelBehavior.always,
                                labelText: 'Delivery Time',
                                labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                              ),
                              child: DropdownButtonHideUnderline(child: getDeliveryTime()),
                            );
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: kNeutralColor,
                          textInputAction: TextInputAction.next,
                          controller: pricenumber,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your price';
                            } else {
                              return null;
                            }
                          },
                          decoration: kInputDecoration.copyWith(
                            labelText: 'Service Price',
                            labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                            hintText: '\$ 5 minimum',
                            hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                            focusColor: kNeutralColor,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          cursorColor: kNeutralColor,
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          controller: description,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please describe the service';
                            } else {
                              return null;
                            }
                          },
                          decoration: kInputDecoration.copyWith(
                            labelText: 'Describe The Service',
                            labelStyle: kTextStyle.copyWith(color: kNeutralColor),
                            hintText: 'I need a ui ux designer...',
                            hintStyle: kTextStyle.copyWith(color: kSubTitleColor),
                            focusColor: kNeutralColor,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          onTap: () async {
                            ImageModel imagedata =
                            await imagectrl.getImageGallery();
                            setState(() {
                              image = imagedata.file!.path;
                            });
                          },
                          // enabled: false,
                          showCursor: false,
                          readOnly: true,
                          keyboardType: TextInputType.url,
                          cursorColor: kNeutralColor,
                          textInputAction: TextInputAction.next,
                          decoration: kInputDecoration.copyWith(
                            labelText: image == ''
                                ? 'Upload file and image'
                                : 'Image Uploaded',
                            labelStyle:
                            kTextStyle.copyWith(color: kNeutralColor),
                            hintText: image == ''
                                ? 'Upload file and image'
                                : 'Image Uploaded',
                            hintStyle: kTextStyle.copyWith(
                                color: kSubTitleColor),
                            focusColor: kNeutralColor,
                            border: const OutlineInputBorder(),
                            suffixIcon: const Icon(FeatherIcons.upload,
                                color: kLightNeutralColor),
                          ),
                          // validator: (String? value) {
                          //   if (value!.isEmpty) {
                          //     return 'Please upload file and image';
                          //   } else {
                          //     return null;
                          //   }
                          // },
                        ),
                        const SizedBox(height: 10.0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: ClientServiceMap(
                            selectmap: true,
                          ),
                        ),

                        Text(
                          errortest,
                          style: kTextStyle.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  )
            ),
          ],
        ),
      ),
              ),
            ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: kWhite),
        child: ButtonGlobalWithoutIcon(
            buttontext: 'Post',
            buttonDecoration: kButtonDecoration.copyWith(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            onPressed: () {

              if (_formKey.currentState!.validate()) {

              //   if (title.text.isEmpty) {
              //     errortest = 'Enter the Title';
              //   }else if (description.text.isEmpty){
              //     errortest = 'Enter the Description';
              //   }else if (pricenumber.text.isEmpty){
              //     errortest = 'Enter the Price';
              //   }else {

                _formKey.currentState!.save();  // Save the form fields
                // add job to database
                Timestamp timestamp = Timestamp.now();
                String dateString = timestamp.toDate().toString();

                print('submit ' + authy.authData.value!.id);

                  dataSetterController.addnewjob(
                    postby: authy.authData.value!.id,
                    category: selectedCategory,
                    date: timestamp,
                    datestr: dateString,
                    desc: description.text,
                    status: 'pending',
                    title: title.text,
                    deliveryTime: selectedDeliveryTimeList,
                    price: pricenumber.text,
                    subcategory: selectedSubCategory,
                    location: mapctrl.pointlocation,
                    address: mapctrl.address!,
                    imageurl: image,
                  );

                description.setText('');
                pricenumber.setText('');
                title.setText('');
                selectedSubCategory = '';
                selectedCategory = '';
                selectedDeliveryTimeList = '';

                  Get.back();

                }

                setState(() {});
                // const JobPost().launch(context);
            },
            buttonTextColor: kWhite),
    
      ),
    );
  }
}
