import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppUrls {
  static final String baseurl = dotenv.env['BASE_URL']!;
  static final String flightData = 'result.json';
}