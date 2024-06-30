import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../models/service.dart';
import '../constant.dart';

class PricePackage extends StatefulWidget {

  PricePackage({
    required this.getDeliveryTime,
    required this.txtctrl,
    required this.title,
    required this.onchange
  });

  Widget getDeliveryTime;
  String title;
  Function(String) onchange;
  TextEditingController txtctrl;


  @override
  State<PricePackage> createState() => _PricePackageState();
}

class _PricePackageState extends State<PricePackage> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.txtctrl.text = '5';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 200,
      // width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: kBorderColorTextField)),
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: true,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          iconColor: kLightNeutralColor,
          collapsedIconColor: kLightNeutralColor,
          title: Text(
            widget.title,
            style: kTextStyle.copyWith(
                color: kNeutralColor,
                fontWeight: FontWeight.bold),
          ),
          children: [

            ListTile(
              visualDensity:
              const VisualDensity(vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Price',
                style: kTextStyle.copyWith(
                    color: kSubTitleColor),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Container(
                    color: Colors.grey[200],
                    width: 35,
                    child: EditableText(
                        controller: widget.txtctrl, focusNode: FocusNode(),
                        style: kTextStyle.copyWith(color: kSubTitleColor),
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        onChanged: (data) => widget.onchange(data),
                        backgroundCursorColor: Colors.grey,
                    ),
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  Text(
                    currencySign,
                    style: kTextStyle.copyWith(
                        color: kNeutralColor,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                ],
              ),
            ),
            const Divider(
              height: 0.0,
              thickness: 1.0,
              color: kBorderColorTextField,
            ),
            ListTile(
              visualDensity:
              const VisualDensity(vertical: -4),
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Delivery Time',
                style: kTextStyle.copyWith(
                    color: kSubTitleColor),
              ),
              trailing: DropdownButtonHideUnderline(
                  child: widget.getDeliveryTime),
            ),
          ],
        ),
      ),
    );
  }
}
