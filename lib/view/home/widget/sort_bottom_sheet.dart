import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../controller/filter_controller.dart';

void showSortSheet(BuildContext context) {
  final ctr = Get.find<FlightFilterController>();
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Sort Flight By',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
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
                  onPressed: () {
                    ctr.resetAll();
                  },
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
    final ctr = Get.find<FlightFilterController>();
    return Obx(() {
      final selected = ctr.sortBy.value == optionIndex;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              // ascending / descending toggle arrow
              InkWell(
                onTap: () {
                  if (selected) {
                    ctr.sortAscending.value = !ctr.sortAscending.value;
                  } else {
                    ctr.sortBy.value = optionIndex;
                    ctr.sortAscending.value = true;
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: 18,
                      color: selected ? Colors.black : Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_downward,
                      size: 18,
                      color: selected ? Colors.black : Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Radio<int>(
                value: optionIndex,
                groupValue: ctr.sortBy.value,
                onChanged: (v) {
                  if (v != null) {
                    ctr.sortBy.value = v;
                  }
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}
