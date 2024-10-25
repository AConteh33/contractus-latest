import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:contractus/controller/datacontroller.dart';
import 'package:contractus/models/categorymodel.dart';
import 'package:contractus/screen/widgets/custom_buttons/button_global.dart';

import '../../models/service.dart';
import 'constant.dart';

class BottomSheetFilter extends StatefulWidget {
  @override
  _BottomSheetFilterState createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  final DataController dataController = Get.put(DataController());

  final List<String> serviceList = [
    'All',
    'Logo Design',
    'Brand Style Guide',
    'Fonts & Typography',
  ];

  final List<String> distanceList = [
    'All',
    '1 km',
    '5 km',
    '10 km',
    '20 km',
  ];

  final List<String> priceList = [
    'All',
    'Ascend',
    'Descend',
  ];

  String selectedService = 'All';
  String selectedDistance = 'All';
  String selectedPrice = 'All';
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10.0)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Filter Options',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _buildFilterOption(
            category: 'Category',
            list: dataController.categorylist.map((e) => e.category).toList(),
            selected: selectedCategory,
            onSelected: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
          _buildFilterOption(
            category: 'Price',
            list: priceList,
            selected: selectedPrice,
            onSelected: (value) {
              setState(() {
                selectedPrice = value;
              });
            },
          ),
          _buildFilterOption(
            category: 'Distance',
            list: distanceList,
            selected: selectedDistance,
            onSelected: (value) {
              setState(() {
                selectedDistance = value;
              });
            },
          ),
          const Spacer(),
          ButtonGlobal(
            buttontext: 'Apply',
            onPressed: () async {
              List<ServiceModel> serviceList = await dataController.getFilteredServiceListData(
                filterType: FilterType.byCategory,
                category: selectedCategory,
                sortBy: selectedPrice == 'Ascend'
                    ? SortBy.priceAscending
                    : SortBy.priceDescending,
              );
              Navigator.pop(context, serviceList);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption({
    required String category,
    required List<String> list,
    required String selected,
    required Function(String) onSelected,
  }) {
    return ListTile(
      title: Text(
        category,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: HorizontalList(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];
          final isSelected = selected == item;
          return GestureDetector(
            onTap: () => onSelected(item),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                color: isSelected ? kPrimaryColor : kDarkWhite,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Text(
                item,
                style: kTextStyle.copyWith(
                  color: isSelected ? kWhite : kNeutralColor,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
