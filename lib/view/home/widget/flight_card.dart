import 'package:flutter/material.dart';

import '../../../model/flight/flight.dart';

class FlightCard extends StatelessWidget {
  final Flight flight;
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
            _FlightSegmentRow(flight: flight, isOutbound: true),
            const Divider(height: 1),
            _FlightSegmentRow(flight: flight, isOutbound: false),
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
                    flight.refundable ? 'Refundable' : 'Non Refundable',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.redAccent,
                    ),
                  ),
                  Text(
                    flight.price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

class _FlightSegmentRow extends StatelessWidget {
  final Flight flight;
  final bool isOutbound;
  const _FlightSegmentRow({required this.flight, required this.isOutbound});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              flight.airline,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Departure',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    Text(
                      'Arrival',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      flight.departureTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      flight.arrivalTime,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            children: [
              Row(
                children: const [
                  CircleAvatar(radius: 3, backgroundColor: Colors.orange),
                  SizedBox(width: 4),
                  Text(
                    'RUH',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(width: 4),
                  Text(
                    '06H:0M',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.flight, size: 16, color: Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TicketClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double notchDistanceFromBottom;

  TicketClipper({this.notchRadius = 10.0, this.notchDistanceFromBottom = 55.0});

  @override
  Path getClip(Size size) {
    final Path path = Path();

    // Compute the vertical center of the notches (distance from top)
    final double notchCenterY = size.height - notchDistanceFromBottom;

    // Start at top-left
    path.moveTo(0, 0);
    // Top edge
    path.lineTo(size.width, 0);
    // Right edge down to start of right notch
    path.lineTo(size.width, notchCenterY - notchRadius);
    // Right inward semicircle notch
    path.arcToPoint(
      Offset(size.width, notchCenterY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    // Continue down to bottom-right
    path.lineTo(size.width, size.height);
    // Bottom edge
    path.lineTo(0, size.height);
    // Left edge up to start of left notch
    path.lineTo(0, notchCenterY + notchRadius);
    // Left inward semicircle notch
    path.arcToPoint(
      Offset(0, notchCenterY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    // Up to top-left
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant TicketClipper oldClipper) {
    return notchRadius != oldClipper.notchRadius ||
        notchDistanceFromBottom != oldClipper.notchDistanceFromBottom;
  }
}
