import 'package:contractus/screen/widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../../controller/datacontroller.dart';
import '../../../models/categorymodel.dart';

class FilterPopup extends StatefulWidget {
  final Function(FilterType, String?, double?, double?, double?, SortBy) onApply;

  FilterPopup({required this.onApply});

  @override
  _FilterPopupState createState() => _FilterPopupState();
}

class _FilterPopupState extends State<FilterPopup> {

  DataController datactrl = Get.put(DataController());

  FilterType selectedFilterType = FilterType.all;
  String? selectedCategory;
  String? selectedSubCategory;
  double? minRating;
  double? minPrice;
  double? maxPrice;
  SortBy selectedSortBy = SortBy.none;

  final List<String> subcategories = [];
  final List<String> prices = ['All', 'Low to High', 'High to Low'];
  final List<String> distances = ['All', '5 km', '10 km', '20 km'];

  void getSubCategory({category}){
    datactrl.categorylist.forEach((element) {
      if(category == element.category){
        setState(() {
          subcategories.addAll(element.subcategory);
        });
      }
    });
  }

  // String selectedCategory = 'All';
  String selectedPrice = 'All';
  String selectedDistance = 'All';

  Widget listingcategory({category,required List<CategoryModel> list}){

    String selected = 'All';

    return ListTile(

      title: Text(category),
      subtitle: HorizontalList(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        itemCount: list.length,
        itemBuilder: (_, i) {

          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: GestureDetector(
              onTap: () {
                setState(() async{
                  selectedCategory = list[i].category;
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: selectedCategory == list[i] ? kPrimaryColor : kDarkWhite,
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(
                  list[i].category,
                  style: kTextStyle.copyWith(
                    color: selected == list[i] ? kWhite : kNeutralColor,
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Filter & Sort Services'),
      content: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              isExpanded: true,
              items: datactrl.categorylist.map((CategoryModel category) {
                return DropdownMenuItem<String>(
                  value: category.category,
                  child: Text(category.category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                  getSubCategory(category: newValue!);
                });
              },
            ),
            SizedBox(height: 16),
            subcategories.isEmpty ? SizedBox() : Text(
              'Sub-Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subcategories.isEmpty ? SizedBox() :DropdownButton<String>(
              value: selectedSubCategory,
              isExpanded: true,
              items: subcategories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedSubCategory = newValue!;
                });
              },
            ),
            subcategories.isEmpty ? SizedBox() : SizedBox(height: 16),
            Text(
              'Price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedPrice,
              isExpanded: true,
              items: prices.map((String price) {
                return DropdownMenuItem<String>(
                  value: price,
                  child: Text(price),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedPrice = newValue!;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Distance',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedDistance,
              isExpanded: true,
              items: distances.map((String distance) {
                return DropdownMenuItem<String>(
                  value: distance,
                  child: Text(distance),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedDistance = newValue!;
                });
              },
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Apply filters and search logic here
                print('Selected Category: $selectedCategory');
                print('Selected Price: $selectedPrice');
                print('Selected Distance: $selectedDistance');
                widget.onApply(
                  selectedFilterType,
                  selectedCategory,
                  minRating,
                  minPrice,
                  maxPrice,
                  selectedSortBy,
                );
                Navigator.of(context).pop();
              },
              child: Text('Apply Filters'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
      // actions: <Widget>[
      //   TextButton(
      //     child: Text('Cancel'),
      //     onPressed: () {
      //       Navigator.of(context).pop();
      //     },
      //   ),
      //   TextButton(
      //     child: Text('Apply'),
      //     onPressed: () {
      //
      //     },
      //   ),
      // ],
    );
  }
}

void showFilterPopup(BuildContext context, Function(FilterType, String?, double?, double?, double?, SortBy) onApply) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FilterPopup(onApply: onApply);
    },
  );
}
