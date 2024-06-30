import 'package:contractus/models/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../seller screen/seller home/my service/service_details.dart';
import '../constant.dart';

class MyServiceCard extends StatefulWidget {
  MyServiceCard({required this.myservice});
  ServiceModel myservice;

  @override
  State<MyServiceCard> createState() => _MyServiceCardState();
}

class _MyServiceCardState extends State<MyServiceCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> ServiceDetails(servicemodel: widget.myservice,).launch(context),
      child: Container(
        height: 205,
        width: 156,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kBorderColorTextField),
          boxShadow: const [
            BoxShadow(
              color: kDarkWhite,
              blurRadius: 5.0,
              spreadRadius: 2.0,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [

                Container(
                  height: 100,
                  width: 156,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                        image: AssetImage(
                          'images/shot1.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavorite = !isFavorite;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: isFavorite
                          ? const Center(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 18.0,
                        ),
                      )
                          : const Center(
                        child: Icon(
                          Icons.favorite_border,
                          color: kNeutralColor,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    widget.myservice.title,
                    style: kTextStyle.copyWith(
                        color: kNeutralColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 5.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        IconlyBold.star,
                        color: Colors.amber,
                        size: 18.0,
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        widget.myservice.rating,
                        style: kTextStyle.copyWith(color: kNeutralColor),
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        '(${widget.myservice.ratingcount} review)',
                        style: kTextStyle.copyWith(color: kLightNeutralColor,fontSize: 10),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5.0),

                  RichText(
                    text: TextSpan(
                      text: 'Price: ',
                      style: kTextStyle.copyWith(color: kLightNeutralColor),
                      children: [
                        TextSpan(
                          text: '$currencySign${
                              widget.myservice.price
                          }',
                          style: kTextStyle.copyWith(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
