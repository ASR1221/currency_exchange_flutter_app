import 'package:flutter/material.dart';

import "../widgets/list_item.dart";
import "../widgets/background_gradient_wrapper.dart";
import '../constants/colors.dart' as colors;

class CurrenciesPage extends StatefulWidget {
  const CurrenciesPage({super.key});

  @override
  State<CurrenciesPage> createState() => _CurrenciesPageState();
}

class _CurrenciesPageState extends State<CurrenciesPage> {

  TextEditingController _controller = TextEditingController();
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return BackGroundGradientWrapper(
      childApp: Padding(
        padding: const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 55),
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return Column(
                children: [
                  const SizedBox(height: 30,),
                  TextField(
                    controller: _controller,
                    cursorColor: Colors.cyan,
                    // style: const TextStyle(color: colors.lightThemeTextColor),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: colors.darkThemeBorderColor.withOpacity(0.8),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      suffixIcon: searchText == "" ? null : IconButton(
                        onPressed: () {
                          setState(() {
                            searchText = "";
                          });
                          _controller.text = "";
                        },
                        icon: const Icon(Icons.clear_rounded),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchText = value.trim();
                      });
                    }
                  ),
                  const SizedBox(height: 10,),
                  const ListItem(),
                ],
              );
              } else {
                return const ListItem();
              }
            }
          ),
        ),
      ),
    );
  }
}