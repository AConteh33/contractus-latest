import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../consts.dart';
import '../client screen/client home/client_home.dart';
import '../widgets/constant.dart';
import '../widgets/custom_buttons/simplebutton.dart';

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
                            tos,
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
            }),
            const SizedBox(height: 20,),

          ],
        ),
      ),
    );
  }
}
