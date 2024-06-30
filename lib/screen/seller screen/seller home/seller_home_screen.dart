import 'package:contractus/controller/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/seller%20screen/profile/seller_profile.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../controller/datacontroller.dart';
import '../../widgets/analytics/earningscard.dart';
import '../../widgets/analytics/performancecard.dart';
import '../../widgets/analytics/statisticscard.dart';
import '../../widgets/cards/myservicecard.dart';
import '../../widgets/loading.dart';
import '../../widgets/mapbutton.dart';
import '../../widgets/searcbox.dart';
import '../notification/seller_notification.dart';
import 'my service/my_service.dart';

class SellerHomeScreen extends StatefulWidget {
  const SellerHomeScreen({Key? key}) : super(key: key);

  @override
  State<SellerHomeScreen> createState() => _SellerHomeScreenState();

}

class _SellerHomeScreenState extends State<SellerHomeScreen> {

  Auth_Controller authy = Auth_Controller();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      authy.signedin;
      authy.getuserdata();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkWhite,
        appBar: AppBar(
          backgroundColor: kDarkWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: GetBuilder<Auth_Controller>(
              init: Auth_Controller(),
              builder: (auth) {
              return Padding(
                padding: const EdgeInsets.only(left: 5,top: 5,right: 5),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: GestureDetector(
                    onTap: () => const SellerProfile().launch(context),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('images/profilepic.png'),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    auth.authData.value!.name ,
                    style: kTextStyle.copyWith(
                        color: kNeutralColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    'Seller',
                    style: kTextStyle.copyWith(color: kLightNeutralColor),
                  ),
                  trailing: GestureDetector(
                    onTap: () => const SellerNotification().launch(context),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: kPrimaryColor.withOpacity(0.2),
                        ),
                      ),
                      child: const Icon(
                        IconlyLight.notification,
                        color: kNeutralColor,
                      ),
                    ),
                  ),
                ),
              );
            }
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Container(
            width: context.width(),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: const BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: GetBuilder<DataController>(
                  init: DataController(),
                  builder: (data) {

                    // data.getmyServiceListData(authy.authData.value?.id);

                    return LoadingWidget(
                      isloading: data.loading.value,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          SearchBox(
                            hint: 'Job Search...',
                            istherenext: true,
                            jobsearch: true,
                          ),

                          const MapButton(),

                          const SizedBox(height: 15.0),
                          PerformanceCard(sellerstatModel: data.sellerstats.value!),

                          const SizedBox(height: 20.0),
                          StatiscticsCard(sellerstatModel: data.sellerstats.value!),

                          const SizedBox(height: 20.0),
                          EarningsCard(sellerstatModel: data.sellerstats.value!),

                          const SizedBox(height: 10.0),
                          // LevelSelection(),

                          // const SizedBox(height: 20.0),

                          Row(
                            children: [
                              Text(
                                'My Services',
                                style: kTextStyle.copyWith(
                                    color: kNeutralColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () => const MyServices().launch(context),
                                child: Text(
                                  'view All',
                                  style: kTextStyle.copyWith(
                                      color: kLightNeutralColor),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15.0),

                          data.myserviceModellist.value.isEmpty ?
                              SizedBox(
                                height: 205,
                                child: Center(
                                  child: Text(
                                    'You don\'t have a service uploaded yet',
                                    style: kTextStyle.copyWith(
                                        color: kLightNeutralColor),
                                  ),
                                ),
                              ):
                          HorizontalList(
                            spacing: 10.0,
                            padding: const EdgeInsets.only(bottom: 10.0),
                            itemCount: data.myserviceModellist.length,
                            itemBuilder: (_, i) {
                              return MyServiceCard(
                                myservice: data.myserviceModellist[i],
                              );
                            },
                          ),

                        ],
                      ),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    Key? key,
    required this.iconColor,
    required this.title,
    required this.value,
  }) : super(key: key);

  final Color iconColor;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.circle,
          size: 16.0,
          color: iconColor,
        ),
        const SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: kTextStyle.copyWith(
                  color: kSubTitleColor
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              value,
              style: kTextStyle.copyWith(
                  color: kNeutralColor,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ),
      ],
    );
  }
}
