import 'package:airline_app/constants/color.dart';
import 'package:airline_app/constants/images.dart';
import 'package:airline_app/widgets/svg.dart';
import 'package:flutter/material.dart';

class FlightPathWidget extends StatelessWidget {
  final String from;
  final String to;
  final TextStyle? textStyle;
  final double lineThickness;

  const FlightPathWidget({
    super.key,
    required this.from,
    required this.to,
    this.textStyle,
    this.lineThickness = 2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Left label
        Text(from, style: textStyle),
        const SizedBox(width: 8),
        // Dotted line with airplane overlay
        SizedBox(
          height: 24,
          width: MediaQuery.of(context).size.width * 0.19,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Dotted line
              Positioned.fill(
                child: CustomPaint(
                  painter: _DottedLinePainter(
                    color: AppColors.white,
                    thickness: lineThickness,
                    dashWidth: 2,
                    dashSpace: 4,
                  ),
                ),
              ),
              FlutterSvg(assetName: AppImages.airplane),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Right label
        Text(to, style: textStyle),
      ],
    );
  }
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  final double thickness;
  final double dashWidth;
  final double dashSpace;

  _DottedLinePainter({
    required this.color,
    this.thickness = 2,
    required this.dashWidth,
    required this.dashSpace,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double x = 0;
    final y = size.height / 2;
    while (x < size.width) {
      final end = (x + dashWidth).clamp(0, size.width);
      canvas.drawLine(Offset(x, y), Offset(end.toDouble(), y), paint);
      x += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant _DottedLinePainter old) {
    return old.color != color ||
        old.thickness != thickness ||
        old.dashWidth != dashWidth ||
        old.dashSpace != dashSpace;
  }
}
