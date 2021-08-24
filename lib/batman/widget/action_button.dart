import 'dart:math';

import 'package:flutter/material.dart';

enum BatPosition {
  topLeft,
  bottomLeft,
  topRight,
  bottomRight,
}

class BatmanActionButton extends StatelessWidget {
  final String actionTitle;
  final Function() onPressed;
  final BatPosition batPosition;

  const BatmanActionButton({
    Key key,
    this.actionTitle,
    this.onPressed,
    this.batPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.yellow,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 64.0,
          child: Stack(
            children: [
              Center(
                child: Text(
                  actionTitle,
                  style: Theme.of(context).textTheme.button.copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              if (batPosition != null) buildPositionedBat(batPosition)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPositionedBat(BatPosition batPosition) {
    double top;
    double left;
    double right;
    double bottom;
    double rotationAngle;

    switch (batPosition) {
      case BatPosition.topLeft:
        top = 0.0;
        left = -24.0;
        rotationAngle = 3 * pi / 4;
        break;
      case BatPosition.bottomLeft:
        bottom = 0.0;
        left = -24.0;
        rotationAngle = pi / 4;
        break;
      case BatPosition.topRight:
        top = 0.0;
        right = -24.0;
        rotationAngle = -3 * pi / 4;
        break;
      case BatPosition.bottomRight:
        bottom = 0.0;
        right = -24.0;
        rotationAngle = -pi / 4;
        break;
    }
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(rotationAngle),
        child: Image.asset(
          "assets/batman/batman_logo.png",
          height: 48,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
