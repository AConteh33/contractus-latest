import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/chatcontroller.dart';
import 'package:contractus/models/auth_data.dart';
import 'package:contractus/screen/seller%20screen/seller%20messgae/chat_inbox.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../models/service.dart';
import '../../../widgets/review.dart';
import '../../../widgets/seller/package_tab.dart';

class ServiceDetails extends StatefulWidget {
  ServiceDetails({required this.servicemodel});
  ServiceModel servicemodel;

  @override
  State<ServiceDetails> createState() => _ServiceDetailsState();
}

class _ServiceDetailsState extends State<ServiceDetails>
    with TickerProviderStateMixin {

  ChatController chatController = ChatController();

  PageController pageController = PageController(initialPage: 0);

  TabController? tabController;

  ScrollController? _scrollController;

  bool lastStatus = false;

  double height = 200;

  void _scrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }
  }

  bool get _isShrink {
    return _scrollController != null &&
        _scrollController!.hasClients &&
        _scrollController!.offset > (height - kToolbarHeight);
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_scrollListener);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_scrollListener);
    _scrollController?.dispose();
    super.dispose();
  }

  // final CarouselController _controller = CarouselController();

  Auth_Controller authy = Get.put(Auth_Controller());

  Widget detailtile({title,desc}){
    return Row(
      children: [
        Text(
          title + ' :',
          maxLines: 1,
          style: kTextStyle.copyWith(
              color: kNeutralColor,
              fontWeight: FontWeight.w400,
              fontSize: 15),
        ),
        const SizedBox(width: 10.0),
        Text(
          desc,
          style:
          kTextStyle.copyWith(fontSize: 15),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: const Text('Contractor Details'),
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: kWhite,
          ),
          child: ButtonGlobalWithoutIcon(
            buttontext: 'Start a chat with ${widget.servicemodel.name}',
            buttonDecoration: kButtonDecoration.copyWith(
              color: kPrimaryColor,
            ),
            onPressed: () async {

              AuthData userdata = await authy.getotheruser(
                  userid: widget.servicemodel.postedby
              );

              String newchatroom = await chatController.createChatRoom(
                  message: 'New chat room created',
                  timestamp: Timestamp.now(),
                  recieverID: userdata.id,
                  recieverName: userdata.name,
                  senderName: authy.authData.value!.id
              );

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatInbox(
                      recieverName: userdata.name,
                      recieverID: widget.servicemodel.postedby,
                    iseller: authy.authData.value!.role == 'seller',
                    chatRoomID: newchatroom,
                  ),
                ),
              );

              // cancelOrderPopUp();

            },
            buttonTextColor: kWhite,
          ),
        ),
        body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: 1,
                  (BuildContext context, int index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(15.0),
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: kWhite,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.servicemodel.title,
                                maxLines: 2,
                                style: kTextStyle.copyWith(
                                    color: kNeutralColor,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 4.0,
                              ),
                              const Divider(
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 15.0, top: 10,bottom: 10,right: 15.0),
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: kBorderColorTextField),
                                    boxShadow: const [BoxShadow(color: kDarkWhite, spreadRadius: 4.0, blurRadius: 4.0, offset: Offset(0, 2))]),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Offer',
                                      maxLines: 1,
                                      style: kTextStyle.copyWith(
                                          color: kNeutralColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(height: 5,),
                                    detailtile(title: 'Budget',desc:widget.servicemodel.price ),
                                    const SizedBox(height: 5.0),
                                    detailtile(title: 'Category',desc:widget.servicemodel.category),
                                    const SizedBox(height: 5.0),
                                    detailtile(title: 'Sub-Category',desc:widget.servicemodel.subcategory),
                                    const SizedBox(height: 5.0),
                                  ],
                                ) ,
                              ),

                              const Divider(
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: kBorderColorTextField),
                                    boxShadow: const [BoxShadow(color: kDarkWhite, spreadRadius: 4.0, blurRadius: 4.0, offset: Offset(0, 2))]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Details',
                                        maxLines: 1,
                                        style: kTextStyle.copyWith(
                                            color: kNeutralColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const SizedBox(height: 5.0),
                                      ReadMoreText(
                                        widget.servicemodel.details,
                                        style: kTextStyle.copyWith(
                                            fontSize: 15,
                                            color: kLightNeutralColor),
                                        trimLines: 3,
                                        colorClickableText: kPrimaryColor,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Read more',
                                        trimExpandedText: 'Read less',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1.0,
                                color: kBorderColorTextField,
                              ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: kBorderColorTextField),
                                boxShadow: const [BoxShadow(color: kDarkWhite, spreadRadius: 4.0, blurRadius: 4.0, offset: Offset(0, 2))]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personal',
                                    maxLines: 1,
                                    style: kTextStyle.copyWith(
                                        color: kNeutralColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(height: 5,),
                                  detailtile(
                                      title: 'Posted by',
                                      desc:widget.servicemodel.name,
                                  ),
                                  detailtile(
                                      title: 'Address',
                                      desc:widget.servicemodel.address,
                                  ),
                                ],
                              ),
                            ),

                          ),
                              const SizedBox(height: 15.0),

                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),

      ),
    );
  }
}
