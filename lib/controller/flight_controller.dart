import 'dart:convert';
import 'dart:developer';

import 'package:airline_app/constants/urls.dart';
import 'package:airline_app/services/server.dart';
import 'package:get/get.dart';

import '../model/flight/flight.dart';
import '../services/database_service.dart';
import '../utils/snackbar.dart';

class FlightController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadFlights();
  }

  late final RxList<FlightTrip> _data = RxList<FlightTrip>([]);
  RxList<FlightTrip> get data => _data;

  /// Holds the currently applied (visible) list after filter.
  RxList<FlightTrip> filteredData = RxList<FlightTrip>([]);

  /// Selected airline names for filtering.
  RxSet<String> selectedAirlines = <String>{}.obs;

  RxBool isLoading = false.obs;

  final _cacheDb = FlightCacheDb();

  fetchFlights() async {
    try {
      var response = await ApiHelper(
        AppUrls.baseurl,
      ).postmethod(method: HttpMethod.get, url: AppUrls.flightData);

      if (response.isSuccessfull && response.data != null) {
        // Cache
        final jsonString = jsonEncode(response.data);
        await _cacheDb.upsertPayload(jsonString);
        // Parsed into model
        FlightModel tempdata = FlightModel.fromJson(response.data);
        List<FlightTrip> projects = tempdata.data?.flightTrips ?? [];
        _data
          ..clear()
          ..addAll(projects);
        applyFilter(); // update filteredData
      } else {
        errorToast(msg: "Something went wrong. Please try again.");
        log("API Error: ${response.message}");
      }
    } catch (e) {
      errorToast(msg: "Something went wrong. Please try again.");
      log("Exception: $e");
    }
  }

  loadFlights() async {
    isLoading.value = true;
    try {
      final cached = await _cacheDb.getCachedPayload();
      if (cached != null) {
        log("Loaded from cache");
        // Load from cache
        final Map<String, dynamic> decoded = jsonDecode(cached);
        FlightModel tempdata = FlightModel.fromJson(decoded);
        List<FlightTrip> projects = tempdata.data?.flightTrips ?? [];
        _data
          ..clear()
          ..addAll(projects);
        applyFilter(); // update filteredData
      } else {
        log("No cache found, fetching from API.");
        // No cache, fetch from API
        await fetchFlights();
      }
    } finally {
      isLoading.value = false;
    }
  }

  /// Apply filter.
  void applyFilter() {
    if (selectedAirlines.isEmpty) {
      filteredData
        ..clear()
        ..addAll(_data);
    } else {
      final filtered = _data.where((trip) {
        final name =
            trip.flightJourneys?[0].flightItems?[0].flightInfo?.name?.en ?? '';
        return selectedAirlines.contains(name);
      }).toList();
      filteredData
        ..clear()
        ..addAll(filtered);
    }
  }

  void toggleAirlineSelection(String airline) {
    if (selectedAirlines.contains(airline)) {
      selectedAirlines.remove(airline);
    } else {
      selectedAirlines.add(airline);
    }
  }

  void clearFilters() {
    selectedAirlines.clear();
    applyFilter();
  }

  void resetFilters() {
    clearFilters();
    Get.back();
  }
}
