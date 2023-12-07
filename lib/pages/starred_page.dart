import 'package:flutter/material.dart';

import "../widgets/fav_card.dart";

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> with AutomaticKeepAliveClientMixin<StarredPage> {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return Padding(
      padding: const EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 22),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return const Column(
              children: [
                SizedBox(height: 30,),
                FavCard(),
              ],
            );
            } else {
              return const FavCard();
            }
          }
        ),
      ),
    );
  }
}