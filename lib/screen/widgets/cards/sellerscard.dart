import 'package:contractus/models/Seller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

import '../constant.dart';

class SellersCard extends StatefulWidget {
  SellersCard({required this.seller});

  Seller seller;

  @override
  State<SellersCard> createState() => _SellersCardState();
}

class _SellersCardState extends State<SellersCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        height: 220,
        width: 156,
        decoration: BoxDecoration(
          color: kWhite,
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
            Container(
              height: 135,
              width: 156,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                ),
                image: DecorationImage(
                    image: AssetImage(
                      'images/dev1.png',
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.seller.name,
                    style: kTextStyle.copyWith(
                        color: kNeutralColor,
                        fontSize: fontnormalsize,
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6.0),
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
                        widget.seller.rating,
                        style: kTextStyle.copyWith(
                          color: kNeutralColor,
                          fontSize: fontsmallsize,
                        ),
                      ),
                      const SizedBox(width: 2.0),
                      Text(
                        '(${widget.seller.ratingcount} review)',
                        style: kTextStyle.copyWith(
                          color: kLightNeutralColor,
                          fontSize: fontsmallsize,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),
                  RichText(
                    text: TextSpan(
                      text: 'Seller Level - ',
                      style: kTextStyle.copyWith(
                        color: kNeutralColor,
                        fontSize: fontsmallsize,
                      ),
                      children: [
                        TextSpan(
                          text: widget.seller.level,
                          style: kTextStyle.copyWith(color: kLightNeutralColor,fontSize: fontsmallsize,),
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
