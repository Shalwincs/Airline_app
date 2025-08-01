
import 'package:flutter/material.dart';

import '../../../widgets/svg.dart';

class BottomFilterButtons extends StatelessWidget {
  final VoidCallback onTap;

  final String title;
  final String assetName;
  const BottomFilterButtons({
    super.key,
    required this.onTap,
    required this.title,
    required this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterSvg(assetName: assetName),
            SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
