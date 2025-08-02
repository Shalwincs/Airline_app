import 'package:airline_app/constants/images.dart';
import 'package:airline_app/widgets/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/color.dart';
import '../../../constants/style.dart';

void showSortSheet(BuildContext context) {
  Get.bottomSheet(
    Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 5),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Sort Flight By',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.lightGrey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 8),
              // Option row builder
              _SortOptionRow(label: 'Airline', optionIndex: 1),
              const Divider(),
              _SortOptionRow(label: 'Duration', optionIndex: 2),
              const Divider(),
              _SortOptionRow(label: 'Price', optionIndex: 3),
              const SizedBox(height: 16),
              // Actions
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF39C12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Reset', style: AppStyles.buttonText),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF39C12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text('Done', style: AppStyles.buttonText),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Close
        Positioned(
          top: -12,
          right: 12,
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: const Icon(Icons.close, size: 18, color: AppColors.white),
            ),
          ),
        ),
      ],
    ),
    isScrollControlled: false,
    barrierColor: Colors.black26,
  );
}

class _SortOptionRow extends StatelessWidget {
  final String label;
  final int optionIndex;
  const _SortOptionRow({required this.label, required this.optionIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          spacing: 12,
          children: [
            FlutterSvg(assetName: AppImages.upArrow),
            FlutterSvg(assetName: AppImages.downArrow),
          ],
        ),
      ],
    );
  }
}
