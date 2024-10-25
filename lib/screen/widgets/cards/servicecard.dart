import 'package:contractus/const/textformat.dart';
import 'package:contractus/screen/seller%20screen/seller%20home/my%20service/service_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../models/service.dart';
import '../../client screen/client service details/client_service_details.dart';
import '../constant.dart';

class ServiceCard extends StatefulWidget {
  ServiceCard({required this.servicedata, this.mapuse = false});

  ServiceModel servicedata;
  bool mapuse;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {

  Widget carddetail({text}) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: kBorderColorTextField),
      ),
      child: Text(
        text,
        style: kTextStyle.copyWith(
            color: kNeutralColor,
            fontWeight: FontWeight.bold,fontSize: 12),
      ),
    );
  }

  tile({title, desc}) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: kTextStyle.copyWith(
                color: kNeutralColor, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          desc,
          style: kTextStyle.copyWith(
            color: kNeutralColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () => ServiceDetails(
          servicemodel: widget.servicedata,
        ).launch(context),
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width - 30,
          decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kBorderColorTextField),
            boxShadow: widget.mapuse
                ? []
                : const [
                    BoxShadow(
                      color: kDarkWhite,
                      blurRadius: 5.0,
                      spreadRadius: 2.0,
                      offset: Offset(0, 5),
                    ),
                  ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Stack(
              //   alignment: Alignment.topLeft,
              //   children: [
              //     Container(
              //       height: 120,
              //       width: 120,
              //       decoration: const BoxDecoration(
              //         borderRadius: BorderRadius.only(
              //           bottomLeft: Radius.circular(8.0),
              //           topLeft: Radius.circular(8.0),
              //         ),
              //         image: DecorationImage(
              //             image: AssetImage(
              //               // widget.servicedata.image
              //               'images/shot1.png',
              //             ),
              //             fit: BoxFit.cover),
              //       ),
              //     ),
              //     // GestureDetector(
              //     //   onTap: () {
              //     //     setState(() {
              //     //       isFavorite = !isFavorite;
              //     //     });
              //     //   },
              //     //   child: Padding(
              //     //     padding: const EdgeInsets.all(5.0),
              //     //     child: Container(
              //     //       height: 25,
              //     //       width: 25,
              //     //       decoration: const BoxDecoration(
              //     //         color: Colors.white,
              //     //         shape: BoxShape.circle,
              //     //         boxShadow: [
              //     //           BoxShadow(
              //     //             color: Colors.black12,
              //     //             blurRadius: 10.0,
              //     //             spreadRadius: 1.0,
              //     //             offset: Offset(0, 2),
              //     //           ),
              //     //         ],
              //     //       ),
              //     //       child: isFavorite
              //     //           ? const Center(
              //     //         child: Icon(
              //     //           Icons.favorite,
              //     //           color: Colors.red,
              //     //           size: 16.0,
              //     //         ),
              //     //       )
              //     //           : const Center(
              //     //         child: Icon(
              //     //           Icons.favorite_border,
              //     //           color: kNeutralColor,
              //     //           size: 16.0,
              //     //         ),
              //     //       ),
              //     //     ),
              //     //   ),
              //     // ),
              //   ],
              // ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Material(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          widget.servicedata.title,
                          style: kTextStyle.copyWith(
                            color: kNeutralColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          carddetail(
                              text: widget.servicedata.category
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          carddetail(
                            text: widget.servicedata.subcategory,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(
                          limitText(widget.servicedata.details,150),
                          style: kTextStyle.copyWith(
                              color: kNeutralColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            'Posted by :',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: kTextStyle.copyWith(
                              color: kNeutralColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
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
                                style: kTextStyle.copyWith(
                                  color: kNeutralColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
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
