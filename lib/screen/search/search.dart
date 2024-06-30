import 'package:contractus/screen/search/searchresult.dart';
import 'package:flutter/material.dart';
import 'package:contractus/screen/widgets/constant.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.istherenext});
  bool istherenext;
  List<String> searchItems = [
    'UI UX Designer',
    'Logo designer',
    'App developer',
    'Designer',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {

    return [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear, color: kNeutralColor),
        ),
      ),
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      color: kNeutralColor,
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: kNeutralColor,
      ),
    );

    return null;
  }

  @override
  Widget buildResults(BuildContext context) {

    List<String> matchQuery = [];

    for (var car in searchItems) {
      if (car.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(car);
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: matchQuery.length,
      itemBuilder: (_, i) {
        var result = matchQuery[i];
        return ListTile(
          title: Text(result),
        );
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var car in searchItems) {
      if (car.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(car);
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      itemCount: matchQuery.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: (){
            if(istherenext){
              SearchResultScreen(titlecategory: matchQuery[i].toString(), jobsearch: false,).launch(context);
            }else{
              Navigator.of(context).pop('results');
            }

          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Row(
              children: [
                Text(
                  matchQuery[i].toString(),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.clear, color: kNeutralColor),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
