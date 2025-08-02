import 'package:airline_app/constants/color.dart';
import 'package:airline_app/constants/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/flight_controller.dart';

void showFilterSheet(BuildContext context) {
  final ctr = Get.find<FlightController>();
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12), 
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Filter Your Search',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.lightGrey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(height: 1),
                const SizedBox(height: 10),
                // Airlines section title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Airlines',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => ctr.clearFilters(),
                      child: const Text('Clear'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // List of airline checkboxes
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.4,
                  ),
                  child: Obx(() {
                    // extract unique airline names
                    final airlineNames =
                        ctr.data
                            .map(
                              (trip) =>
                                  trip
                                      .flightJourneys?[0]
                                      .flightItems?[0]
                                      .flightInfo
                                      ?.name
                                      ?.en
                                      ?.trim() ??
                                  '',
                            )
                            .where((name) => name.isNotEmpty)
                            .toSet()
                            .toList()
                          ..sort(); 
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: airlineNames.length,
                      itemBuilder: (context, idx) {
                        final name = airlineNames[idx];
                        return InkWell(
                          onTap: () => ctr.toggleAirlineSelection(name),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                              Obx(() {
                                return Checkbox(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  side: WidgetStateBorderSide.resolveWith((
                                    states,
                                  ) {
                                    if (!states.contains(WidgetState.selected)) {
                                      return const BorderSide(
                                        color: AppColors.secondary,
                                        width: 1,
                                      );
                                    }
                                    return const BorderSide(
                                      color: AppColors.secondary,
                                      width: 1,
                                    );
                                  }),
                                  fillColor: WidgetStateProperty.resolveWith((states) {
                                    if (states.contains(WidgetState.selected))return AppColors.secondary;
                                    return Colors.transparent; 
                                  }),
                                  value: ctr.selectedAirlines.contains(name),
                                  onChanged: (_) {
                                    ctr.toggleAirlineSelection(name);
                                  },
                                );
                              }),
                            ],
                          ),
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
                        onPressed: () => ctr.resetFilters(),
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
                          ctr.applyFilter();
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
              child: const Icon(
                Icons.close,
                size: 18,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    ),
    isScrollControlled: true,
    barrierColor: Colors.black26,
  );
}
