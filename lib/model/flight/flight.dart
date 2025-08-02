class FlightModel {
  String? version;
  String? code;
  List<String>? message;
  String? sessionKey;
  Data? data;

  FlightModel({
    this.version,
    this.code,
    this.message,
    this.sessionKey,
    this.data,
  });

  factory FlightModel.fromJson(Map<String, dynamic> json) => FlightModel(
    version: json["Version"],
    code: json["Code"],
    message: json["Message"] == null
        ? []
        : List<String>.from(json["Message"]!.map((x) => x)),
    sessionKey: json["SessionKey"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Version": version,
    "Code": code,
    "Message": message == null
        ? []
        : List<dynamic>.from(message!.map((x) => x)),
    "SessionKey": sessionKey,
    "Data": data?.toJson(),
  };
}

class Data {
  List<FlightTrip>? flightTrips;

  Data({this.flightTrips});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    flightTrips: json["FlightTrips"] == null
        ? []
        : List<FlightTrip>.from(
            json["FlightTrips"]!.map((x) => FlightTrip.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "FlightTrips": flightTrips == null
        ? []
        : List<dynamic>.from(flightTrips!.map((x) => x.toJson())),
  };
}

class FlightTrip {
  FareDetails? fareDetails;
  List<AdditionalFare>? additionalFares;
  List<FlightJourney>? flightJourneys;

  FlightTrip({this.fareDetails, this.additionalFares, this.flightJourneys});

  factory FlightTrip.fromJson(Map<String, dynamic> json) => FlightTrip(
    fareDetails: json["FareDetails"] == null
        ? null
        : FareDetails.fromJson(json["FareDetails"]),
    additionalFares: json["AdditionalFares"] == null
        ? []
        : List<AdditionalFare>.from(
            json["AdditionalFares"]!.map((x) => AdditionalFare.fromJson(x)),
          ),
    flightJourneys: json["FlightJourneys"] == null
        ? []
        : List<FlightJourney>.from(
            json["FlightJourneys"]!.map((x) => FlightJourney.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "FareDetails": fareDetails?.toJson(),
    "AdditionalFares": additionalFares == null
        ? []
        : List<dynamic>.from(additionalFares!.map((x) => x.toJson())),
    "FlightJourneys": flightJourneys == null
        ? []
        : List<dynamic>.from(flightJourneys!.map((x) => x.toJson())),
  };

  // For sqflite:
  factory FlightTrip.fromMap(Map<String, dynamic> map) =>
      FlightTrip.fromJson(map);
  Map<String, dynamic> toMap() => toJson();
}

class AdditionalFare {
  bool? isRefundable;
  RefundInfo? refundInfo;
  FareDetails? fareDetails;

  AdditionalFare({this.isRefundable, this.refundInfo, this.fareDetails});

  factory AdditionalFare.fromJson(Map<String, dynamic> json) => AdditionalFare(
    isRefundable: json["IsRefundable"],
    refundInfo: json["RefundInfo"] == null
        ? null
        : RefundInfo.fromJson(json["RefundInfo"]),
    fareDetails: json["FareDetails"] == null
        ? null
        : FareDetails.fromJson(json["FareDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "IsRefundable": isRefundable,
    "RefundInfo": refundInfo?.toJson(),
    "FareDetails": fareDetails?.toJson(),
  };
}

class RefundInfo {
  int? value;
  String? name;
  dynamic notes;

  RefundInfo({this.value, this.name, this.notes});

  factory RefundInfo.fromJson(Map<String, dynamic> json) => RefundInfo(
    value: json["Value"],
    name: json["Name"],
    notes: json["Notes"],
  );

  Map<String, dynamic> toJson() => {
    "Value": value,
    "Name": name,
    "Notes": notes,
  };
}

class FareDetails {
  String? currency;

  String? total;

  FareDetails({this.currency, this.total});

  factory FareDetails.fromJson(Map<String, dynamic> json) =>
      FareDetails(currency: json["Currency"], total: json["Total"]);

  Map<String, dynamic> toJson() => {"Currency": currency, "Total": total};
}

class FlightJourney {
  List<FlightItem>? flightItems;

  FlightJourney({this.flightItems});

  factory FlightJourney.fromJson(Map<String, dynamic> json) => FlightJourney(
    flightItems: json["FlightItems"] == null
        ? []
        : List<FlightItem>.from(
            json["FlightItems"]!.map((x) => FlightItem.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "FlightItems": flightItems == null
        ? []
        : List<dynamic>.from(flightItems!.map((x) => x.toJson())),
  };
}

class FlightItem {
  Arrival? departure;
  Arrival? arrival;
  FlightItemFlightInfo? flightInfo;

  FlightItem({this.departure, this.arrival, this.flightInfo});

  factory FlightItem.fromJson(Map<String, dynamic> json) => FlightItem(
    departure: json["Departure"] == null
        ? null
        : Arrival.fromJson(json["Departure"]),
    arrival: json["Arrival"] == null ? null : Arrival.fromJson(json["Arrival"]),
    flightInfo: json["FlightInfo"] == null
        ? null
        : FlightItemFlightInfo.fromJson(json["FlightInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "Departure": departure?.toJson(),
    "Arrival": arrival?.toJson(),
    "FlightInfo": flightInfo?.toJson(),
  };
}

class FlightItemFlightInfo {
  Name? name;
  String? code;

  FlightItemFlightInfo({this.name, this.code});

  factory FlightItemFlightInfo.fromJson(Map<String, dynamic> json) =>
      FlightItemFlightInfo(
        name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
        code: json["Code"],
      );

  Map<String, dynamic> toJson() => {"Name": name?.toJson(), "Code": code};
}

class Arrival {
  String? airportCode;
  Name? countryName;
  Name? cityName;
  Name? airportName;
  DateTime? dateTime;
  String? terminal;

  Arrival({
    this.airportCode,
    this.countryName,
    this.cityName,
    this.airportName,
    this.dateTime,
    this.terminal,
  });

  factory Arrival.fromJson(Map<String, dynamic> json) => Arrival(
    airportCode: json["AirportCode"],
    countryName: json["CountryName"] == null
        ? null
        : Name.fromJson(json["CountryName"]),
    cityName: json["CityName"] == null ? null : Name.fromJson(json["CityName"]),
    airportName: json["AirportName"] == null
        ? null
        : Name.fromJson(json["AirportName"]),
    dateTime: json["DateTime"] == null
        ? null
        : DateTime.parse(json["DateTime"]),
    terminal: json["Terminal"],
  );

  Map<String, dynamic> toJson() => {
    "AirportCode": airportCode,
    "CountryName": countryName?.toJson(),
    "CityName": cityName?.toJson(),
    "AirportName": airportName?.toJson(),
    "DateTime": dateTime?.toIso8601String(),
    "Terminal": terminal,
  };
}

class Name {
  String? en;
  String? ar;

  Name({this.en, this.ar});

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(en: json["en"], ar: json["ar"]);

  Map<String, dynamic> toJson() => {"en": en, "ar": ar};
}
