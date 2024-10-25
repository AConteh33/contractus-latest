import 'package:contractus/controller/authcontroller.dart';
import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/auth_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:get/get.dart';

import '../../seller screen/seller messgae/chat_list.dart';
import '../client job post/client_job_post.dart';
import '../client orders/client_orders.dart';
import '../client profile/client_profile.dart';
import 'client_home_screen.dart';

class ClientHome extends StatefulWidget {
  ClientHome({
    this.signedin = false,
    this.onback = true,
  });

  bool signedin;
  bool onback;

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int _currentPage = 0;

  static List<Widget> _widgetOptions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // datactrlr.getSellerStats(uid: authy.authData.value!.id);
    _widgetOptions = <Widget>[
      ClientHomeScreen(
        signedin: widget.signedin,
      ),
      const ChatScreen(),
      const JobPost(),
      const ClientOrderList(),
      const ClientProfile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: widget.signedin
          ? Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: kDarkWhite,
                        blurRadius: 5.0,
                        spreadRadius: 3.0,
                        offset: Offset(0, -2))
                  ]),
              child: Stack(
                children: [
                  BottomNavigationBar(
                    elevation: 0.0,
                    selectedItemColor: kPrimaryColor,
                    unselectedItemColor: kLightNeutralColor,
                    backgroundColor: kWhite,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(IconlyBold.home),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconlyBold.chat),
                        label: "Message",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(
                          IconlyBold.paperPlus,
                          color: Colors.white,
                        ),
                        label: "Connect",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconlyBold.document),
                        label: "Contracts",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(IconlyBold.profile),
                        label: "Profile",
                      ),
                    ],
                    onTap: (int index) {
                      setState(() => _currentPage = index);
                    },
                    currentIndex: _currentPage,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() => _currentPage = 2);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: SizedBox(
                            height: 30,
                            child: Image.asset(
                              "images/IMG_9391.png",
                              colorBlendMode: BlendMode.color,
                              color: _currentPage == 2
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox(),
    );
  }
}
