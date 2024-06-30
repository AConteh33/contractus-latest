import 'package:contractus/screen/search/searchresult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'constant.dart';

class SearchBox extends StatefulWidget {

  String hint;
  bool istherenext;
  bool jobsearch;
  final controller;

  SearchBox({
    this.hint = '',
    required this.istherenext,
    required this.jobsearch,
    this.controller});


  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: kDarkWhite,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: ListTile(
          horizontalTitleGap: 0,
          visualDensity: const VisualDensity(vertical: -2),
          leading: const Icon(
            FeatherIcons.search,
            color: kNeutralColor,
          ),
          title: Center(
            child: TextField(
              enabled: !widget.istherenext,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Search...",
              ),
              controller: widget.controller,
                style: const TextStyle(
                  fontSize: 13,
                ),

            ),
          ),
          // Text(
          //   widget.hint,
          //   style: kTextStyle.copyWith(color: kSubTitleColor),
          // ),
          onTap: () {

            if(widget.istherenext){
              SearchResultScreen(
                titlecategory: '',
                jobsearch: widget.jobsearch,
              ).launch(context);
            }else{

            }


            // showSearch(
            //   context: context,
            //   delegate: CustomSearchDelegate(istherenext: widget.istherenext),
            // );
            // if(widget.istherenext){
            //
            // }else{
            //   Navigator.of(context).pop('results');
            // }

          },
        ),
      ),
    );
  }
}
