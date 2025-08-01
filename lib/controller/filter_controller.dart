import 'package:get/get.dart';

class FlightFilterController extends GetxController {
  // Sort options: 0=none, 1=airline, 2=duration, 3=price
  final sortBy = 0.obs;
  final sortAscending = true.obs;

  // Airlines list and selection
  final airlines = <String>[
    'Jazeera Airways',
    'Kuwait Airways',
    'Fly Dubai',
    'Saudi Arabian Airlines',
    'Qatar Airways',
    'Emirates Airlines',
    'Royal Jordanian',
    'Gulf Air Company',
    'Turkish Airlines',
    'Egyptair',
    'Etihad Airways',
    'Middle East Airlines',
  ].obs;

  final selectedAirlines = <String>{}.obs;

  void toggleAirline(String name) {
    if (selectedAirlines.contains(name)) {
      selectedAirlines.remove(name);
    } else {
      selectedAirlines.add(name);
    }
  }

  void resetAll() {
    sortBy.value = 0;
    sortAscending.value = true;
    selectedAirlines.clear();
  }
}
