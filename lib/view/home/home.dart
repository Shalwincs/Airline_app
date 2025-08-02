import 'package:airline_app/constants/color.dart';
import 'package:airline_app/constants/images.dart';
import 'package:airline_app/view/home/widget/flight_card.dart';
import 'package:airline_app/widgets/svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../constants/style.dart';
import '../../controller/flight_controller.dart';
import 'widget/bottom_buttons.dart';
import 'widget/filter_bottom_sheet.dart';
import 'widget/flight_path.dart';
import 'widget/shimmer_flight_card.dart';
import 'widget/sort_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctr = Get.put(FlightController());
    final now = DateTime.now().toLocal();
    final formatted = DateFormat('d MMMM').format(now);

    return Scaffold(
      backgroundColor: AppColors.grey,
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        leading: BackButton(color: AppColors.white),
        title: Center(
          child: const FlightPathWidget(
            from: 'NYZ',
            to: 'CAI',
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: AppColors.white,
              letterSpacing: 1.2,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: FlutterSvg(assetName: AppImages.editOutline),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: SizedBox(
              height: 20,
              child: Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(formatted, style: AppStyles.appBarText),
                  VerticalDivider(color: AppColors.white, thickness: 1),
                  Text('2 Travellers', style: AppStyles.appBarText),
                  Obx(
                    () => ctr.filteredData.isEmpty
                        ? SizedBox.shrink()
                        : VerticalDivider(color: AppColors.white, thickness: 1),
                  ),
                  Obx(
                    () => ctr.filteredData.isEmpty
                        ? SizedBox.shrink()
                        : Text(
                            '${ctr.filteredData.length} Flights',
                            style: AppStyles.appBarText,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Obx(() {
              final listToShow = ctr.filteredData;

              if (ctr.isLoading.value) {
                return const FlightCardShimmerList(itemCount: 4);
              }
              if (listToShow.isEmpty) {
                return Center(
                  child: const Text(
                    "No flights found",
                    style: TextStyle(fontSize: 16, color: AppColors.lightGrey),
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                itemCount: listToShow.length,
                itemBuilder: (context, index) {
                  final f = listToShow[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: FlightCard(flight: f),
                  );
                },
              );
            }),
          ),
          Positioned(
            left: 50,
            right: 50,
            bottom: 30,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFFF39C12),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: BottomFilterButtons(
                      onTap: () {
                        showSortSheet(context);
                      },
                      title: 'Sort',
                      assetName: AppImages.sortDown,
                    ),
                  ),

                  Container(
                    width: 1,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white54,
                  ),
                  Expanded(
                    child: BottomFilterButtons(
                      onTap: () {
                        showFilterSheet(context);
                      },
                      title: 'Filter',
                      assetName: AppImages.filter,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
