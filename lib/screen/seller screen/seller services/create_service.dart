import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/screen/widgets/cards/jobcard.dart';
import 'package:contractus/screen/widgets/cards/myservicecard.dart';
import 'package:contractus/screen/widgets/cards/servicecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';
import 'create_new_service.dart';

class CreateService extends StatefulWidget {
  const CreateService({Key? key}) : super(key: key);

  @override
  State<CreateService> createState() => _CreateServiceState();
}

class _CreateServiceState extends State<CreateService> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kDarkWhite,
        // appBar: AppBar(
        //   backgroundColor: kDarkWhite,
        //   elevation: 0,
        //   iconTheme: const IconThemeData(color: kNeutralColor),
        //   title: Text(
        //     'Create Service',
        //     style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
        //   ),
        //   centerTitle: true,
        // ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateNewService(),
                    ),
                  );
                },
              );
            },
            backgroundColor: kPrimaryColor,
            child: const Icon(
              FeatherIcons.plus,
              color: kWhite,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Column(
          children: [
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Create Service',
                  style: kTextStyle.copyWith(
                      color: kNeutralColor,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Expanded(
              child: GetBuilder<DataController>(
                init: DataController(),
                builder: (data) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 0.0),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 15.0),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(height: 50.0),
                                Container(
                                  height: 213,
                                  width: 269,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage('images/emptyservice.png'),
                                        fit: BoxFit.cover
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                Text(
                                  'Empty Service',
                                  style: kTextStyle.copyWith(
                                      color: kNeutralColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0
                                  ),
                                ),
                              ],
                            ).visible(data.myjobModellist.isEmpty),

                            // GridView.count(
                            //   shrinkWrap: true,
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   mainAxisSpacing: 10.0,
                            //   crossAxisSpacing: 10.0,
                            //   childAspectRatio: 0.7,
                            //   crossAxisCount: 2,
                            //   children: List.generate(
                            //     data.serviceModellist.length,
                            //     (index) => ServiceCard(
                            //         servicedata: data.serviceModellist[index]
                            //     )
                            //   )
                            // ),

                            ListView.builder(
                              itemCount: data.myjobModellist.value.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 10.0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {
                                return JobCard(jobmodel: data.myjobModellist.value[i],);
                              },
                            ),



                          ],
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
