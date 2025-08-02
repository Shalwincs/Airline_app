
import 'package:flutter/material.dart';

class TicketClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double notchDistanceFromBottom;

  TicketClipper({this.notchRadius = 10.0, this.notchDistanceFromBottom = 55.0});

  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double notchCenterY = size.height - notchDistanceFromBottom;

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, notchCenterY - notchRadius);
    path.arcToPoint(
      Offset(size.width, notchCenterY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, notchCenterY + notchRadius);
    path.arcToPoint(
      Offset(0, notchCenterY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant TicketClipper oldClipper) {
    return notchRadius != oldClipper.notchRadius ||
        notchDistanceFromBottom != oldClipper.notchDistanceFromBottom;
  }
}