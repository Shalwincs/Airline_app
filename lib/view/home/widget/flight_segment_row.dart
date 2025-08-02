import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/images.dart';
import '../../../model/flight/flight.dart';
import '../../../utils/time_format.dart';
import '../../../widgets/svg.dart';

class FlightSegmentRow extends StatelessWidget {
  final FlightTrip flight;
  final bool isOutbound;
  const FlightSegmentRow({
    super.key,
    required this.flight,
    required this.isOutbound,
  });

  Widget _infoColumn(String label, String time, String code) {
    return Flexible(
      flex: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2),
          // Time
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              time,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 2),
          // Code
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              code,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String airlineCode =
        flight.flightJourneys?[0].flightItems?[0].flightInfo?.code ?? '';

    final departureTime = formatFlightTime(
      flight.flightJourneys?[0].flightItems?[0].departure?.dateTime,
    );
    final arivalTime = formatFlightTime(
      flight.flightJourneys?[0].flightItems?[0].departure?.dateTime,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl:
                  "https://booksultanuat.caxita.ca/images/AirlineIcons/$airlineCode.png",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      Colors.red,
                      BlendMode.colorBurn,
                    ),
                  ),
                ),
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(width: 40, height: 40, color: Colors.white),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          // Departure info
          _infoColumn(
            'Departure',
            departureTime,
            flight.flightJourneys?[0].flightItems?[0].departure?.airportCode ??
                '',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: FlutterSvg(assetName: AppImages.darrival),
          ),
          // Arrival info
          _infoColumn(
            'Arrival',
            arivalTime,
            flight.flightJourneys?[0].flightItems?[0].arrival?.airportCode ??
                '',
          ),
        ],
      ),
    );
  }
}
