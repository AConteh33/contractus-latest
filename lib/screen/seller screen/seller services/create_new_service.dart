import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datasettercontroller.dart';
import 'package:contractus/controller/imagecontroller.dart';
import 'package:contractus/controller/mapcontroller.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/models/service.dart';
import 'package:contractus/screen/seller%20screen/seller%20home/seller_service_map.dart';
import 'package:contractus/screen/widgets/cards/price_package.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/seller%20screen/seller%20popUp/seller_popup.dart';
import 'package:contractus/screen/widgets/button_global.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../../controller/datacontroller.dart';
import '../../../models/imageModel.dart';
import '../../widgets/cards/upload_image_card.dart';
import '../../widgets/constant.dart';
import 'create_service.dart';

class CreateNewService extends StatefulWidget {
  const CreateNewService({Key? key}) : super(key: key);

  @override
  State<CreateNewService> createState() => _CreateNewServiceState();
}

class _CreateNewServiceState extends State<CreateNewService> {
  PageController pageController = PageController(initialPage: 0);

  int currentIndexPage = 0;
  double percent = 33.3;

  //setting database variables
  DataSetterController dataSetterController = Get.put(DataSetterController());
  final mediaController = Get.put(MediaController());
  Auth_Controller authy = Get.put(Auth_Controller());
  String errortest = '';
  final _formKey = GlobalKey<FormState>();
  String postid = '';
  String postedby = '';
  String title = '';
  String rating = '0.0';
  int ratingcount = 0;
  String price = '';
  String name = '';
  String selectedCategory = '';
  String selectedSubCategory = '';
  String selectedServiceType = '';
  String level = '';
  String image = '';
  String imageurl = "";
  List imageurls = [];
  List imagefile = ['', '', ''];
  MapController mapController = Get.put(MapController());
  bool favorite = true;
  String description = '';
  //Plans placeholder

  PlansModel basicPlan =
      PlansModel(price: '5', deliverydays: "", extra: {}, revisions: '3');
  TextEditingController basicctrl = TextEditingController();
  String basicprice = '5';

  PlansModel standardPlan =
      PlansModel(price: '30', deliverydays: "", extra: {}, revisions: '5');
  TextEditingController standardctrl = TextEditingController();
  String standardprice = '5';

  PlansModel premiumPLan =
      PlansModel(price: '60', deliverydays: "", extra: {}, revisions: '10');
  TextEditingController premiumctrl = TextEditingController();
  String premiumprice = '5';

  bool imageloading = false;
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

  //__________ServiceType_______________________________________________________

  DropdownButton<String> getServiceType() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in serviceType) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(FeatherIcons.chevronDown),
      items: dropDownItems,
      value: selectedServiceType.isNotEmpty ? selectedServiceType : null,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          selectedServiceType = value ?? '';
        });
      },
    );
  }

  void updateDeliveryDays(String newValue, PlansModel planType) {
    setState(() {
      planType.deliverydays = newValue;
    });
  }

  //__________DeliveryTime___________________________________________________________
  DropdownButton<String> getDeliveryTime(PlansModel planType) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in deliveryTime) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(
        FeatherIcons.chevronDown,
        color: kLightNeutralColor,
        size: 18,
      ),
      items: dropDownItems,
      value: planType.deliverydays.isNotEmpty ? planType.deliverydays : null,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        updateDeliveryDays(value!, planType);
        setState(() {});
      },
    );
  }

  //__________totalScreen____________________________________________________________
  DropdownButton<String> getTotalScreen(PlansModel plan) {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String des in pageCount) {
      var item = DropdownMenuItem(
        value: des,
        child: Text(des),
      );
      dropDownItems.add(item);
    }
    return DropdownButton(
      icon: const Icon(
        FeatherIcons.chevronDown,
        color: kLightNeutralColor,
        size: 18,
      ),
      items: dropDownItems,
      value: plan.revisions.isEmpty ? plan.revisions : null,
      style: kTextStyle.copyWith(color: kSubTitleColor),
      onChanged: (value) {
        setState(() {
          plan.revisions = value!;
        });
      },
    );
  }

  double? _distanceToField;

  final TextfieldTagsController _controller = TextfieldTagsController();
  final TextEditingController titlecontroller = TextEditingController();
  final TextEditingController desccontroller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<String> serviceTags = const [
    'UI UX Design',
    'Flutter',
    'Java',
    'Graphic',
    'language'
  ];

  @override
  void initState() {
    super.initState();
  }

  DataController datactrl = Get.put(DataController());
  MediaController imagectrl = Get.put(MediaController());

  //__________Create_FAQ_PopUP_______________________________________________

  void showAddFAQPopUp() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder:
              (BuildContext context, void Function(void Function()) setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const AddFAQPopUp(),
            );
          },
        );
      },
    );
  }

  bool isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      appBar: AppBar(
        backgroundColor: kDarkWhite,
        elevation: 0,
        iconTheme: const IconThemeData(color: kNeutralColor),
        title: Text(
          'Create New Service',
          style: kTextStyle.copyWith(
              color: kNeutralColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: PageView.builder(
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (int index) => setState(() => currentIndexPage = index),
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentIndexPage == 0
                              ? 'Step 1 of 4'
                              : currentIndexPage == 1
                                  ? currentIndexPage == 2
                                      ? 'Step 2 of 4'
                                      : 'Step 3 of 4'
                                  : 'Step 4 of 4',
                          style: kTextStyle.copyWith(color: kNeutralColor),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: 4,
                            currentStep: currentIndexPage + 1,
                            size: 8,
                            padding: 0,
                            selectedColor: kPrimaryColor,
                            unselectedColor: kPrimaryColor.withOpacity(0.2),
                            roundedEdges: const Radius.circular(10),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20.0),
                              Text(
                                'Overview',
                                style: kTextStyle.copyWith(
                                    color: kNeutralColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 15.0),
                              TextFormField(
                                onSaved: (String? value) {
                                  setState(() {
                                    title = value!;
                                  });
                                },
                                controller: titlecontroller,
                                keyboardType: TextInputType.name,
                                cursorColor: kNeutralColor,
                                textInputAction: TextInputAction.next,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(60),
                                ],
                                maxLength: 20,
                                decoration: kInputDecoration.copyWith(
                                  labelText: 'Service Title',
                                  labelStyle:
                                      kTextStyle.copyWith(color: kNeutralColor),
                                  hintText: 'Enter service title',
                                  hintStyle: kTextStyle.copyWith(
                                      color: kSubTitleColor),
                                  focusColor: kNeutralColor,
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter service title';
                                  } else {
                                    return null;
                                  }
                                },
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
                                      labelText: 'Category',
                                      labelStyle: kTextStyle.copyWith(
                                          color: kNeutralColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                        child: getCategory()),
                                  );
                                },
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter category';
                                  } else {
                                    return null;
                                  }
                                },
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
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter subcategory';
                                  } else {
                                    return null;
                                  }
                                },
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
                                      labelText: 'Service Type',
                                      labelStyle: kTextStyle.copyWith(
                                          color: kNeutralColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                        child: getServiceType()),
                                  );
                                },
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter service type';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              const SizedBox(height: 20.0),
                              TextFormField(
                                controller: desccontroller,
                                keyboardType: TextInputType.multiline,
                                cursorColor: kNeutralColor,
                                textInputAction: TextInputAction.next,
                                maxLines: 5,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(80),
                                ],
                                maxLength: 800,
                                decoration: kInputDecoration.copyWith(
                                  labelText: 'Service Description',
                                  labelStyle:
                                      kTextStyle.copyWith(color: kNeutralColor),
                                  hintText: 'Briefly describe your service...',
                                  hintStyle: kTextStyle.copyWith(
                                      color: kSubTitleColor),
                                  focusColor: kNeutralColor,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: const OutlineInputBorder(),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please describe your service';
                                  } else {
                                    return null;
                                  }
                                },
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
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please upload file and image';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              // const SizedBox(height: 5.0),
                              // Text(
                              //   'Service tags',
                              //   style: kTextStyle.copyWith(
                              //       color: kNeutralColor,
                              //       fontWeight: FontWeight.bold),
                              // ),

                              const SizedBox(height: 10.0),

                              Text(
                                errortest,
                                style: kTextStyle.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(
                                height: 10,
                              ),

                              // TextFieldTags(
                              //   textfieldTagsController: _controller,
                              //   textSeparators: const [' ', ','],
                              //   letterCase: LetterCase.normal,
                              //   validator: (String! tag) {
                              //     if (tag == 'php') {
                              //       return 'Try else';
                              //     } else if (_controller.getTags!.contains(tag)) {
                              //       return 'you already entered that';
                              //     }
                              //     return null;
                              //   },
                              //   inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
                              //     return ((context, sc, tags, onTagDelete) {
                              //       return TextFormField(
                              //         controller: tec,
                              //         focusNode: fn,
                              //         cursorColor: kNeutralColor,
                              //         decoration: kInputDecoration.copyWith(
                              //           isDense: true,
                              //           border: const OutlineInputBorder(),
                              //           focusColor: kNeutralColor,
                              //           hintText: _controller.hasTags ? '' : "Enter tag...",
                              //           errorText: error,
                              //           prefixIconConstraints: BoxConstraints(maxWidth: _distanceToField! * 0.74),
                              //           prefixIcon: tags.isNotEmpty
                              //               ? SingleChildScrollView(
                              //                   controller: sc,
                              //                   scrollDirection: Axis.horizontal,
                              //                   child: Row(
                              //                       children: tags.map((String tag) {
                              //                     return Container(
                              //                       decoration: const BoxDecoration(
                              //                         borderRadius: BorderRadius.all(
                              //                           Radius.circular(4.0),
                              //                         ),
                              //                         color: kBorderColorTextField,
                              //                       ),
                              //                       margin: const EdgeInsets.symmetric(horizontal: 10.0),
                              //                       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                              //                       child: Row(
                              //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //                         children: [
                              //                           InkWell(
                              //                             child: Text(
                              //                               tag,
                              //                               style: kTextStyle.copyWith(color: kNeutralColor),
                              //                             ),
                              //                             onTap: () {
                              //                             },
                              //                           ),
                              //                           const SizedBox(width: 4.0),
                              //                           InkWell(
                              //                             child: const Icon(
                              //                               Icons.cancel,
                              //                               size: 14.0,
                              //                               color: kNeutralColor,
                              //                             ),
                              //                             onTap: () {
                              //                               onTagDelete(tag);
                              //                             },
                              //                           )
                              //                         ],
                              //                       ),
                              //                     );
                              //                   }).toList()),
                              //                 )
                              //               : null,
                              //         ),
                              //         onChanged: onChanged,
                              //         onFieldSubmitted: onSubmitted,
                              //       );
                              //     });
                              //   },
                              //   inputFieldBuilder: (BuildContext context, InputFieldValues<dynamic> textFieldTagValues) {},
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ).visible(currentIndexPage == 0),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20.0),
                          Text(
                            'Pricing Package',
                            style: kTextStyle.copyWith(
                                color: kNeutralColor,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15.0),
                          PricePackage(
                              getDeliveryTime: getDeliveryTime(basicPlan),
                              txtctrl: basicctrl,
                              title: 'Basic Package',
                              onchange: (price) {
                                setState(() {
                                  basicprice = price;
                                });
                              }),
                          const SizedBox(height: 15.0),
                          PricePackage(
                              getDeliveryTime: getDeliveryTime(standardPlan),
                              txtctrl: standardctrl,
                              title: 'Standard Package',
                              onchange: (price) {
                                setState(() {
                                  standardprice = price;
                                });
                              }),
                          const SizedBox(height: 15.0),
                          PricePackage(
                              getDeliveryTime: getDeliveryTime(premiumPLan),
                              txtctrl: premiumctrl,
                              title: 'Premium Package',
                              onchange: (price) {
                                setState(() {
                                  premiumprice = price;
                                });
                              }),
                        ],
                      ),
                    ).visible(currentIndexPage == 1),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          'Image (Up to 3)',
                          style: kTextStyle.copyWith(
                              color: kNeutralColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 1.6,
                          child: ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: 3,
                              // physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return GestureDetector(
                                  onTap: () async {
                                    try {
                                      final ImageModel imagedata =
                                          await imagectrl.getImageGallery();
                                      await MediaController()
                                          .uploadImage(imagedata.file!);
                                    } catch (error) {
                                      // Handle image selection or upload error (e.g., display error message)
                                      print(
                                          'Error selecting or uploading image: $error');
                                      Get.snackbar(
                                        "Error",
                                        "There was an error selecting or uploading the image. Please try again.",
                                        snackPosition: SnackPosition.BOTTOM,
                                      );
                                    }
                                  },
                                );
                              }),
                        ),
                      ],
                    ).visible(currentIndexPage == 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20.0),
                        Text(
                          'Select your location',
                          style: kTextStyle.copyWith(
                              color: kNeutralColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 15.0),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 1.6,
                            child: SellerServiceMap(
                              selectmap: true,
                            )),
                      ],
                    ).visible(currentIndexPage == 3),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: ButtonGlobalWithoutIcon(
          buttontext: 'Next',
          buttonDecoration: kButtonDecoration.copyWith(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(30.0),
          ),
          onPressed: () async {
            if (titlecontroller.text.isEmpty) {
              errortest = 'Enter the Title';
            } else if (desccontroller.text.isEmpty) {
              errortest = 'Enter the Description';
            } else {
              _formKey.currentState?.save();

              currentIndexPage < 3
                  ? pageController.nextPage(
                      duration: const Duration(microseconds: 3000),
                      curve: Curves.bounceInOut)
                  : dataSetterController.addnewservice(
                      address: mapController.address,
                      location: mapController.pointlocation,
                      images: imageurls,
                      postedby: authy.authData.value!.id,
                      name: authy.authData.value!.name,
                      selectedCategory: selectedCategory,
                      subcategory: selectedSubCategory,
                      rating: rating,
                      level: '',
                      favorite: favorite,
                      title: titlecontroller.text,
                      details: desccontroller.text,
                      basic: PlansModel(
                        price: basicprice,
                        deliverydays: basicctrl.text,
                        extra: {},
                        revisions: '',
                      ),
                      standard: PlansModel(
                        price: standardprice,
                        deliverydays: standardctrl.text,
                        extra: {},
                        revisions: '',
                      ),
                      premium: PlansModel(
                        price: premiumprice,
                        deliverydays: premiumctrl.text,
                        extra: {},
                        revisions: '',
                      ),
                      price: '$basicprice - $premiumprice',
                      ratingcount: ratingcount,
                      image: image,
                      selectedServiceType: selectedServiceType,
                    );
            }

            currentIndexPage == 3 ? Get.back() : null;

            setState(() {});
          },
          buttonTextColor: kWhite),
    );
  }

  Widget titleList(String name, bool isSelected, int index, PlansModel plan) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name, style: kTextStyle.copyWith(color: kSubTitleColor)),
      trailing: isSelected
          ? const Icon(
              Icons.radio_button_checked_outlined,
              color: kPrimaryColor,
            )
          : const Icon(
              Icons.radio_button_off_outlined,
              color: Colors.grey,
            ),
      onTap: () {
        setState(() {
          if (isSelected) {
            plan.extra[name] = name; // Add to map if selected
          } else {
            plan.extra.remove(name); // Remove from map if deselected
          }
          list[index].isSelected = !isSelected; // Toggle isSelected
        });
      },
    );
  }
}
