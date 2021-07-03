import 'package:flutter/cupertino.dart';

class SeparatorPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.quadraticBezierTo(size.width / 2, 0.0, size.width * 0.6, size.height * 0.1);
    path.quadraticBezierTo(
        size.width, size.height / 2, size.width / 2, size.height);
    path.lineTo(size.width / 2, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
