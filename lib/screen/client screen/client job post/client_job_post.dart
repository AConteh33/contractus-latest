import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/screen/widgets/cards/jobcard.dart';
import 'package:contractus/screen/widgets/cards/servicecard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:nb_utils/nb_utils.dart';

import 'create_new_job_post.dart';
import 'job_details.dart';

class JobPost extends StatefulWidget {
  const JobPost({Key? key}) : super(key: key);

  @override
  State<JobPost> createState() => _JobPostState();

}


class _JobPostState extends State<JobPost> {
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
              setState(
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateNewJobPost(),
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
        body: GetBuilder<DataController>(
          init: DataController(),
          builder: (data) {
            return Column(
              children: [
                SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Connect with freelancers',
                      style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
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
                            SizedBox(
                              height: 400,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 50.0),
                                  Container(
                                    height: 213,
                                    width: 269,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(image: AssetImage('images/emptyservice.png'), fit: BoxFit.cover),
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Text(
                                    'No Services',
                                    style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold, fontSize: 24.0),
                                  ),

                                ],
                              )
                            ).visible(
                                data.serviceModellist.isEmpty
                            ),

                            // Text(
                            //   // ignore: invalid_use_of_protected_member
                            //   'Total Job Post (${data.serviceModellist.value.length})',
                            //   style: kTextStyle.copyWith(
                            //       color: kNeutralColor,
                            //       fontWeight: FontWeight.bold
                            //   ),
                            // ),

                            const SizedBox(height: 15.0),

                            // ListView.builder(
                            //   itemCount: data.myjobModellist.value.length,
                            //   shrinkWrap: true,
                            //   padding: const EdgeInsets.only(bottom: 10.0),
                            //   physics: const NeverScrollableScrollPhysics(),
                            //   itemBuilder: (_, i) {
                            //     return JobCard(jobmodel: data.myjobModellist.value[i],);
                            //   },
                            // ),

                            ListView.builder(
                              itemCount: data.serviceModellist.value.length,
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(bottom: 10.0),
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, i) {

                                return ServiceCard(
                                  servicedata: data.serviceModellist.value[i],
                                );

                              },
                            ),
                            

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
