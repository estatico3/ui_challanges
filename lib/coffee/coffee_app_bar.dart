import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoffeeAppBar extends StatelessWidget {
  final appBarIconSize = 32.0;
  final appBarHeight = 56.0;
  final Color actionsColor;

  const CoffeeAppBar({Key key, this.actionsColor = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      child: Row(
        children: [
          IconButton(
            iconSize: appBarIconSize,
            icon: Icon(
              Icons.navigate_before_rounded,
              size: appBarIconSize,
              color: actionsColor,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Spacer(),
          IconButton(
            iconSize: appBarIconSize,
            icon: Icon(
              Icons.shopping_bag_outlined,
              size: appBarIconSize,
              color: actionsColor,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
