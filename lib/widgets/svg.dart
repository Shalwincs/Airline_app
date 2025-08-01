import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class FlutterSvg extends StatelessWidget {
  const FlutterSvg({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.fit,
  });
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit ?? BoxFit.contain,
    );
  }
}
