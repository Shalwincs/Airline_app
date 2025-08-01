import 'package:get/get.dart';

import '../model/flight/flight.dart';

class FlightController extends GetxController {
  final flights = <Flight>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Dummy round-trip pairs; each pair shows outbound/inbound stacked in one card group
    flights.addAll([
      Flight(
        airline: 'Jazeera',
        from: 'DXB',
        to: 'CAI',
        departureTime: '21:30',
        arrivalTime: '08:30',
        price: 'EGP 596.230',
        refundable: false,
      ),
      Flight(
        airline: 'Qatar',
        from: 'DXB',
        to: 'CAI',
        departureTime: '21:30',
        arrivalTime: '08:30',
        price: 'EGP 596.230',
        refundable: false,
      ),
      Flight(
        airline: 'flydubai',
        from: 'DXB',
        to: 'CAI',
        departureTime: '21:30',
        arrivalTime: '08:30',
        price: 'EGP 596.230',
        refundable: false,
      ),
       Flight(
        airline: 'flydubai',
        from: 'DXB',
        to: 'CAI',
        departureTime: '21:30',
        arrivalTime: '08:30',
        price: 'EGP 596.230',
        refundable: false,
      ),
       Flight(
        airline: 'flydubai',
        from: 'DXB',
        to: 'CAI',
        departureTime: '21:30',
        arrivalTime: '08:30',
        price: 'EGP 596.230',
        refundable: false,
      ),
    ]);
  }
}
