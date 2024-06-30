import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:contractus/screen/seller%20screen/seller%20home/seller_home_screen.dart';
import 'package:contractus/screen/widgets/constant.dart';
import '../orders/seller_orders.dart';
import '../profile/seller_profile.dart';
import '../seller messgae/chat_list.dart';
import '../seller services/create_service.dart';

class SellerHome extends StatefulWidget {
  const SellerHome({Key? key}) : super(key: key);

  @override
  State<SellerHome> createState() => _SellerHomeState();
}

class _SellerHomeState extends State<SellerHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget> [
    SellerHomeScreen(),
    ChatScreen(),
    CreateService(),
    SellerOrderList(),
    SellerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: Stack(
        children: [

          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
                boxShadow: [BoxShadow(color: kDarkWhite, blurRadius: 5.0, spreadRadius: 3.0, offset: Offset(0, -2))]),
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
                        IconlyBold.plus,
                        color: Colors.white,
                      ),
                      label: "Connect",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(IconlyBold.document),
                      label: "Orders",
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
                      onTap: (){
                        setState(() => _currentPage = 2);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: SizedBox(
                          height: 30,
                          child: Image.asset(
                            "images/IMG_9391.png",
                            colorBlendMode: BlendMode.color,
                            color: _currentPage == 2 ?
                            Colors.green : Colors.grey,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

              ],
            ),
          ),


        ],
      ),
    );
  }
}
