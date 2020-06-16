import 'dart:ui';
import 'package:flutter/widgets.dart';
class ProfileCliper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path p = new Path();
    p.lineTo(size.width, 0.0);
    p.lineTo(size.width, size.height * 0.90);
    p.arcToPoint(
      Offset(0.0, size.height * 0.86),
      // radius: const Radius.circular(45),
      radius: const Radius.elliptical(89.0,10.0),
      rotation: 1.0,
    );
    p.lineTo(0.0, 0.0);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}