import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_controller.dart';
import "../constants/colors.dart" as colors;
import "../constants/currencies.dart" as currencies;

class BaseDropdown extends StatefulWidget {
  BaseDropdown({super.key, required this.isMainBase, required this.selectedValue});

  final bool isMainBase;
  String selectedValue;

  @override
  State<BaseDropdown> createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {

  final TextEditingController textEditingController = TextEditingController();

  Row menuItem(String item, bool isBase) {
    return Row(
      children: [
        Container(
          width: 25,
          height: 25,
          color: Colors.transparent,
          child: Image.asset('images/${isBase ? "base" : "crypto"}/${item.toLowerCase()}.png'),
        ),
        const SizedBox(width: 10,),
        Text(
          item,
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

    final currencyList = !widget.isMainBase && widget.selectedValue == "BTC" ? currencies.allCryptos : currencies.allBases;

    return Consumer<ProviderController>(
      builder: (context, provider, child) => Container(
        width: 160,
        decoration: BoxDecoration(
          gradient: colors.baseDropdownGradient,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              widget.isMainBase ? provider.baseCurrency : widget.selectedValue,
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: currencyList
                .map((item) => DropdownMenuItem(
                  value: item,
                  child: menuItem(item, widget.isMainBase || (!widget.isMainBase && widget.selectedValue != "BTC")),
                ))
                .toList(),
            value: widget.isMainBase ? provider.baseCurrency : widget.selectedValue,
            onChanged: (value) {
              if (widget.isMainBase) {
                provider.setBaseCurrency(value ?? "USD");
              } else {
                setState(() {
                  widget.selectedValue = value ?? "USD";
                });
              }
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
                    hintText: 'Search for a currency...',
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
      )
    );
  }
}
