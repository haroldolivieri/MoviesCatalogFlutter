import 'package:flutter/material.dart';

import '../view_utils.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              addSymetricMargin(
                horizontal: 8,
                vertical: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ),
              ),
              Text(
                "Movies",
                style: textStyleLight(fontSize: 26),
                textAlign: TextAlign.start,
              ),
              addSymetricMargin(
                horizontal: 8,
                vertical: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
