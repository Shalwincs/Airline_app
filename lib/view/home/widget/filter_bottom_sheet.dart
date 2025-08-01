import 'package:airline_app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/filter_controller.dart';

void showFilterSheet(BuildContext context) {
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
                'Filter Your Search',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Divider(height: 1),
          const SizedBox(height: 8),
          // Airlines section title
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Airlines',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
              TextButton(
                onPressed: () {
                  ctr.selectedAirlines.clear();
                },
                child: const Text('Clear'),
              ),
            ],
          ),
          const SizedBox(height: 4),
          // List of airline checkboxes
          SizedBox(
            height: 300, // make scrollable if too tall
            child: Obx(() {
              return ListView.separated(
                shrinkWrap: true,
                itemCount: ctr.airlines.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, idx) {
                 
                  return Obx(() {
                     final name = ctr.airlines[idx];
                  final checked = ctr.selectedAirlines.contains(name);
                      return InkWell(
                        onTap: () => ctr.toggleAirline(name),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(name),
                              Checkbox(
                                value: checked,
                                onChanged: (_) => ctr.toggleAirline(name),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  );
                },
              );
            }),
          ),
          const SizedBox(height: 12),
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
           const SizedBox(height: 12),
        ],
      ),
    ),
    isScrollControlled: false,
    barrierColor: Colors.black26,
  );
}
