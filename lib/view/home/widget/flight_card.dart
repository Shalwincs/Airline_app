import 'package:flutter/material.dart';

import '../../../model/flight/flight.dart';
import '../../../widgets/ticket_clipper.dart';
import 'flight_segment_row.dart';

class FlightCard extends StatelessWidget {
  final FlightTrip flight;
  const FlightCard({super.key, required this.flight});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TicketClipper(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            FlightSegmentRow(flight: flight, isOutbound: true),
            FlightSegmentRow(flight: flight, isOutbound: false),
            SizedBox(
              height: 20,
              child: Stack(
                children: [
                  Center(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            (constraints.maxWidth / 6).floor(),
                            (index) => Container(
                              width: 3,
                              height: 1,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    (flight.additionalFares?[0].isRefundable ?? false)
                        ? 'Refundable'
                        : 'Non Refundable',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "${flight.additionalFares?[0].fareDetails?.currency ?? ''} ${flight.additionalFares?[0].fareDetails?.total ?? ''}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
