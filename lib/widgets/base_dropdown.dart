import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import "../constants/colors.dart" as colors;

class BaseDropdown extends StatefulWidget {
  const BaseDropdown({super.key});

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  final List<String> items = [
    'A_Item1',
    'A_Item2',
    'A_Item3',
    'A_Item4',
    'B_Item1',
    'B_Item2',
    'B_Item3',
    'B_Item4',
  ];

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  Row menuItem(String itemValue) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 20,
          decoration: BoxDecoration(
            gradient: colors.loadingPlaceholderGradient,
            borderRadius: BorderRadius.circular(7)
          ),
        ),
        const SizedBox(width: 10,),
        Text(
          itemValue,
          style: const TextStyle(fontSize: 14, color: colors.lightThemeTextColor),
        ),
      ],
    );
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      decoration: BoxDecoration(
        gradient: colors.baseDropdownGradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            selectedValue ?? "Select Item",
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: items
              .map((item) => DropdownMenuItem(
                    value: item,
                    child: menuItem(item),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
          iconStyleData:
              const IconStyleData(iconEnabledColor: colors.lightThemeTextColor),
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            width: 180,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 250,
            elevation: 0,
            decoration: BoxDecoration(
              gradient: colors.baseDropdownGradient,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          dropdownSearchData: DropdownSearchData(
            searchController: textEditingController,
            searchInnerWidgetHeight: 50,
            searchInnerWidget: Container(
              height: 50,
              padding: const EdgeInsets.only(
                top: 4,
                bottom: 4,
                right: 8,
                left: 8,
              ),
              child: TextFormField(
                expands: true,
                maxLines: null,
                cursorColor: Colors.grey,
                cursorRadius: const Radius.circular(10),
                controller: textEditingController,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  hintText: 'Search for an item...',
                  hintStyle: const TextStyle(fontSize: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            searchMatchFn: (item, searchValue) {
              return item.value
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase());
            },
          ),
          //This to clear the search value when you close the menu
          onMenuStateChange: (isOpen) {
            if (!isOpen) {
              textEditingController.clear();
            }
          },
        ),
      ),
    );
  }
}
