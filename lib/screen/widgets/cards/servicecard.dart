import 'package:contractus/screen/seller%20screen/seller%20home/my%20service/service_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/service.dart';
import '../constant.dart';


class ServiceCard extends StatefulWidget {

  ServiceCard({required this.servicedata,this.mapuse = false});

  ServiceModel servicedata;
  bool mapuse;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => ServiceDetails(
          servicemodel: widget.servicedata,
        ).launch(context),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width -30,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kBorderColorTextField),
            boxShadow: widget.mapuse ? [] : const [
              BoxShadow(
                color: kDarkWhite,
                blurRadius: 5.0,
                spreadRadius: 2.0,
                offset: Offset(
                    0, 5
                ),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                      ),
                      image: DecorationImage(
                          image: AssetImage(
                            // widget.servicedata.image
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
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 1.0,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: isFavorite
                            ? const Center(
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 16.0,
                          ),
                        )
                            : const Center(
                          child: Icon(
                            Icons.favorite_border,
                            color: kNeutralColor,
                            size: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: 190,
                          child: Text(
                            widget.servicedata.title,
                            style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                            widget.servicedata.rating,
                            style: kTextStyle.copyWith(color: kNeutralColor),
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            "(${widget.servicedata.ratingcount})",
                            style: kTextStyle.copyWith(color: kLightNeutralColor),
                          ),
                          const SizedBox(width: 40),
                          RichText(
                            text: TextSpan(
                              text: 'Price: ',
                              style: kTextStyle.copyWith(color: kLightNeutralColor),
                              children: [
                                TextSpan(
                                  text: widget.servicedata.price,
                                  style: kTextStyle.copyWith(color: kPrimaryColor, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 5.0),

                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'images/profilepic2.png'
                                  ),
                                  fit: BoxFit.cover
                              ),
                            ),
                          ),

                          const SizedBox(width: 5.0),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.servicedata.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: kTextStyle.copyWith(color: kNeutralColor, fontWeight: FontWeight.bold),
                              ),
                              // Text(
                              //   widget.servicedata.level,
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: kTextStyle.copyWith(color: kSubTitleColor),
                              // ),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
