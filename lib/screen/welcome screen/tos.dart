import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../client screen/client home/client_home.dart';
import '../widgets/constant.dart';
import '../widgets/simplebutton.dart';

class TOS_Screen extends StatefulWidget {
  const TOS_Screen({super.key});

  @override
  State<TOS_Screen> createState() => _TOS_ScreenState();
}

class _TOS_ScreenState extends State<TOS_Screen> {

  ScrollController _controller = ScrollController();
  bool enablebutton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // You've reached the end of the scroll.
      setState(() {
        enablebutton = true;
      });
      print('End of scroll');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Image.asset('images/logo2.png'),
              ),
            ),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5.0,
                    color: Colors.grey[100],
                    child: SingleChildScrollView(
                      controller: _controller,
                      child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Terms and Conditions of Service\n\n'



                            'These Terms and Conditions of Service (“Terms”) govern your use of the [Platform Name] platform (“Platform”), operated by [Company Name]. By accessing or using the Platform, you agree to be bound by these Terms. If you do not agree with these Terms, you may not use the Platform.\n'
                                            '\\User Accounts\n\n'



                                            '1.1. In order to use certain features of the Platform, you may need to create an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.\n\n'



                                            '1.2. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.\n\n'
                                            '\\Services'



                                            '2.1. The Platform connects users seeking freelance services (“Clients”) with independent contractors offering their services (“Freelancers”). The Platform facilitates communication, project management, and payment processing between Clients and Freelancers.\n\n'



                                        '2.2. Clients and Freelancers are solely responsible for the content of their listings, proposals, and communications on the Platform. [Company Name] does not endorse, guarantee, or verify the quality, accuracy, or legality of any services offered or provided by Freelancers, or the ability of Clients to pay for such services.\n'
                                        '\\Fees and Payments\n\n'



                                        '3.1. [Company Name] may charge fees for certain services provided through the Platform. These fees are subject to change at any time, and [Company Name] will provide notice of any fee changes prior to implementing them.\n\n'



                                        '3.2. Clients agree to pay Freelancers for services rendered in accordance with the terms agreed upon between the Client and Freelancer. [Company Name] may facilitate payment processing but is not responsible for any disputes between Clients and Freelancers regarding payment.\n'
                                        '\\Prohibited Conduct\n\n'



                                        '4.1. Users agree not to use the Platform for any unlawful or prohibited purpose. This includes, but is not limited to, engaging in fraudulent, abusive, or harassing behavior, violating intellectual property rights, or uploading malicious software.\n\n'



                                        '4.2. Users agree not to circumvent or manipulate the Platform’s features or systems, including but not limited to submitting false information or engaging in activities that artificially inflate ratings or reviews.\n'
                                        '\\Intellectual Property\n\n'



                                            '5.1. [Company Name] retains all rights, title, and interest in and to the Platform, including all intellectual property rights. Users may not copy, modify, distribute, or create derivative works based on the Platform without [Company Name]’s prior written consent.\n'
                                        '\\Termination\n\n'



                                        '6.1. [Company Name] reserves the right to suspend or terminate access to the Platform, with or without cause and without prior notice, in its sole discretion. Upon termination, all rights granted to you under these Terms will immediately cease.\n'
                                        '\\Disclaimer of Warranties\n\n'



                                        '7.1. THE PLATFORM IS PROVIDED ON AN “AS-IS” AND “AS AVAILABLE” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED. [COMPANY NAME] DISCLAIMS ALL WARRANTIES, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT.\n'
                                        '\\Limitation of Liability\n\n'



                                        '8.1. TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, [COMPANY NAME] SHALL NOT BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES, OR ANY LOSS OF PROFITS OR REVENUES, WHETHER INCURRED DIRECTLY OR INDIRECTLY, OR ANY LOSS OF DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES, ARISING OUT OF OR IN CONNECTION WITH THESE TERMS OR YOUR USE OF THE PLATFORM.\n'
                                        '\\Governing Law\n\n'



                                        '9.1. These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflicts of law principles.'
                                        '\\Miscellaneous\n\n'



                                            '10.1. These Terms constitute the entire agreement between you and [Company Name] regarding your use of the Platform and supersede all prior or contemporaneous agreements, representations, warranties, or understandings.\n\n'



                                        '10.2. [Company Name]’s failure to enforce any right or provision of these Terms will not be deemed a waiver of such right or provision.\n\n',
                          style: kTextStyle.copyWith(
                              // color: Colors.,
                            fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],),
                    ),
                  ),
                ),
            ),
            SimpleButton(
                enabled: enablebutton,
                title:'I Agree',ontap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                  prefs.setBool('tos', true);
              ClientHome(signedin: false,).launch(context);
            })

          ],
        ),
      ),
    );
  }
}
