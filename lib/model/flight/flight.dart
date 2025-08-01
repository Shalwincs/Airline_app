// ignore_for_file: constant_identifier_names

import 'dart:convert';

class Flight {
  final String airline;
  final String from;
  final String to;
  final String departureTime;
  final String arrivalTime;
  final String price;
  final bool refundable;

  Flight({
    required this.airline,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.arrivalTime,
    required this.price,
    this.refundable = false,
  });
}

FlightModel flightModelFromJson(String str) =>
    FlightModel.fromJson(json.decode(str));

String flightModelToJson(FlightModel data) => json.encode(data.toJson());

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
  int? resultCount;
  bool? polStatus;
  Currency? currency;
  List<String>? suppliers;
  List<FlightTrip>? flightTrips;

  Data({
    this.resultCount,
    this.polStatus,
    this.currency,
    this.suppliers,
    this.flightTrips,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    resultCount: json["ResultCount"],
    polStatus: json["PolStatus"],
    currency: currencyValues.map[json["Currency"]]!,
    suppliers: json["Suppliers"] == null
        ? []
        : List<String>.from(json["Suppliers"]!.map((x) => x)),
    flightTrips: json["FlightTrips"] == null
        ? []
        : List<FlightTrip>.from(
            json["FlightTrips"]!.map((x) => FlightTrip.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "ResultCount": resultCount,
    "PolStatus": polStatus,
    "Currency": currencyValues.reverse[currency],
    "Suppliers": suppliers == null
        ? []
        : List<dynamic>.from(suppliers!.map((x) => x)),
    "FlightTrips": flightTrips == null
        ? []
        : List<dynamic>.from(flightTrips!.map((x) => x.toJson())),
  };
}

enum Currency { KWD }

final currencyValues = EnumValues({"KWD": Currency.KWD});

class FlightTrip {
  dynamic contractIdentifier;
  int? displayOrder;
  String? flightTripKey;
  dynamic galelioPnr;
  dynamic bookingPnr;
  FareDetails? fareDetails;
  List<AdditionalFare>? additionalFares;
  List<FlightJourney>? flightJourneys;
  TripDuration? tripDuration;
  int? tripDirection;
  String? compareKey;
  SupplierInfo? supplierInfo;
  List<AdditionalRequest>? additionalRequests;
  OperatingVendor? operatingVendor;
  Name? operatingVendorName;
  bool? isPreferredDeal;
  bool? isTransitVisaMessageAvailable;
  dynamic transitVisa;
  bool? showHoldBookingButton;
  bool? isFlightPayLaterAvailable;
  bool? isLcc;
  dynamic mandatoryRequests;
  bool? isFlightAvail;
  dynamic statusCode;
  bool? isPlusOrMinusSearchAvailable;
  bool? isPaylaterPaymentSkipped;
  bool? isHighlight;
  bool? isCombinationFlight;

  FlightTrip({
    this.contractIdentifier,
    this.displayOrder,
    this.flightTripKey,
    this.galelioPnr,
    this.bookingPnr,
    this.fareDetails,
    this.additionalFares,
    this.flightJourneys,
    this.tripDuration,
    this.tripDirection,
    this.compareKey,
    this.supplierInfo,
    this.additionalRequests,
    this.operatingVendor,
    this.operatingVendorName,
    this.isPreferredDeal,
    this.isTransitVisaMessageAvailable,
    this.transitVisa,
    this.showHoldBookingButton,
    this.isFlightPayLaterAvailable,
    this.isLcc,
    this.mandatoryRequests,
    this.isFlightAvail,
    this.statusCode,
    this.isPlusOrMinusSearchAvailable,
    this.isPaylaterPaymentSkipped,
    this.isHighlight,
    this.isCombinationFlight,
  });

  factory FlightTrip.fromJson(Map<String, dynamic> json) => FlightTrip(
    contractIdentifier: json["ContractIdentifier"],
    displayOrder: json["DisplayOrder"],
    flightTripKey: json["FlightTripKey"],
    galelioPnr: json["GalelioPNR"],
    bookingPnr: json["BookingPNR"],
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
    tripDuration: json["TripDuration"] == null
        ? null
        : TripDuration.fromJson(json["TripDuration"]),
    tripDirection: json["TripDirection"],
    compareKey: json["CompareKey"],
    supplierInfo: json["SupplierInfo"] == null
        ? null
        : SupplierInfo.fromJson(json["SupplierInfo"]),
    additionalRequests: json["AdditionalRequests"] == null
        ? []
        : List<AdditionalRequest>.from(
            json["AdditionalRequests"]!.map(
              (x) => additionalRequestValues.map[x]!,
            ),
          ),
    operatingVendor: operatingVendorValues.map[json["OperatingVendor"]]!,
    operatingVendorName: json["OperatingVendorName"] == null
        ? null
        : Name.fromJson(json["OperatingVendorName"]),
    isPreferredDeal: json["IsPreferredDeal"],
    isTransitVisaMessageAvailable: json["IsTransitVisaMessageAvailable"],
    transitVisa: json["TransitVisa"],
    showHoldBookingButton: json["ShowHoldBookingButton"],
    isFlightPayLaterAvailable: json["IsFlightPayLaterAvailable"],
    isLcc: json["IsLCC"],
    mandatoryRequests: json["MandatoryRequests"],
    isFlightAvail: json["IsFlightAvail"],
    statusCode: json["StatusCode"],
    isPlusOrMinusSearchAvailable: json["IsPlusOrMinusSearchAvailable"],
    isPaylaterPaymentSkipped: json["IsPaylaterPaymentSkipped"],
    isHighlight: json["IsHighlight"],
    isCombinationFlight: json["IsCombinationFlight"],
  );

  Map<String, dynamic> toJson() => {
    "ContractIdentifier": contractIdentifier,
    "DisplayOrder": displayOrder,
    "FlightTripKey": flightTripKey,
    "GalelioPNR": galelioPnr,
    "BookingPNR": bookingPnr,
    "FareDetails": fareDetails?.toJson(),
    "AdditionalFares": additionalFares == null
        ? []
        : List<dynamic>.from(additionalFares!.map((x) => x.toJson())),
    "FlightJourneys": flightJourneys == null
        ? []
        : List<dynamic>.from(flightJourneys!.map((x) => x.toJson())),
    "TripDuration": tripDuration?.toJson(),
    "TripDirection": tripDirection,
    "CompareKey": compareKey,
    "SupplierInfo": supplierInfo?.toJson(),
    "AdditionalRequests": additionalRequests == null
        ? []
        : List<dynamic>.from(
            additionalRequests!.map((x) => additionalRequestValues.reverse[x]),
          ),
    "OperatingVendor": operatingVendorValues.reverse[operatingVendor],
    "OperatingVendorName": operatingVendorName?.toJson(),
    "IsPreferredDeal": isPreferredDeal,
    "IsTransitVisaMessageAvailable": isTransitVisaMessageAvailable,
    "TransitVisa": transitVisa,
    "ShowHoldBookingButton": showHoldBookingButton,
    "IsFlightPayLaterAvailable": isFlightPayLaterAvailable,
    "IsLCC": isLcc,
    "MandatoryRequests": mandatoryRequests,
    "IsFlightAvail": isFlightAvail,
    "StatusCode": statusCode,
    "IsPlusOrMinusSearchAvailable": isPlusOrMinusSearchAvailable,
    "IsPaylaterPaymentSkipped": isPaylaterPaymentSkipped,
    "IsHighlight": isHighlight,
    "IsCombinationFlight": isCombinationFlight,
  };
}

class AdditionalFare {
  FareKey? fareKey;
  int? fareType;
  bool? isRefundable;
  RefundInfo? refundInfo;
  FareDetails? fareDetails;
  List<BrandProperty>? brandProperties;
  List<PenaltiesInfo>? penaltiesInfo;
  dynamic mandatoryRequests;
  List<dynamic>? mandatorySelection;
  int? fareTypeId;
  int? fareTypeReturnId;
  FareTypeName? fareTypeName;
  FareTypeName? fareTypeNameReturn;

  AdditionalFare({
    this.fareKey,
    this.fareType,
    this.isRefundable,
    this.refundInfo,
    this.fareDetails,
    this.brandProperties,
    this.penaltiesInfo,
    this.mandatoryRequests,
    this.mandatorySelection,
    this.fareTypeId,
    this.fareTypeReturnId,
    this.fareTypeName,
    this.fareTypeNameReturn,
  });

  factory AdditionalFare.fromJson(Map<String, dynamic> json) => AdditionalFare(
    fareKey: fareKeyValues.map[json["FareKey"]]!,
    fareType: json["FareType"],
    isRefundable: json["IsRefundable"],
    refundInfo: json["RefundInfo"] == null
        ? null
        : RefundInfo.fromJson(json["RefundInfo"]),
    fareDetails: json["FareDetails"] == null
        ? null
        : FareDetails.fromJson(json["FareDetails"]),
    brandProperties: json["BrandProperties"] == null
        ? []
        : List<BrandProperty>.from(
            json["BrandProperties"]!.map((x) => BrandProperty.fromJson(x)),
          ),
    penaltiesInfo: json["PenaltiesInfo"] == null
        ? []
        : List<PenaltiesInfo>.from(
            json["PenaltiesInfo"]!.map((x) => PenaltiesInfo.fromJson(x)),
          ),
    mandatoryRequests: json["MandatoryRequests"],
    mandatorySelection: json["MandatorySelection"] == null
        ? []
        : List<dynamic>.from(json["MandatorySelection"]!.map((x) => x)),
    fareTypeId: json["FareTypeId"],
    fareTypeReturnId: json["FareTypeReturnId"],
    fareTypeName: fareTypeNameValues.map[json["FareTypeName"]]!,
    fareTypeNameReturn: fareTypeNameValues.map[json["FareTypeNameReturn"]]!,
  );

  Map<String, dynamic> toJson() => {
    "FareKey": fareKeyValues.reverse[fareKey],
    "FareType": fareType,
    "IsRefundable": isRefundable,
    "RefundInfo": refundInfo?.toJson(),
    "FareDetails": fareDetails?.toJson(),
    "BrandProperties": brandProperties == null
        ? []
        : List<dynamic>.from(brandProperties!.map((x) => x.toJson())),
    "PenaltiesInfo": penaltiesInfo == null
        ? []
        : List<dynamic>.from(penaltiesInfo!.map((x) => x.toJson())),
    "MandatoryRequests": mandatoryRequests,
    "MandatorySelection": mandatorySelection == null
        ? []
        : List<dynamic>.from(mandatorySelection!.map((x) => x)),
    "FareTypeId": fareTypeId,
    "FareTypeReturnId": fareTypeReturnId,
    "FareTypeName": fareTypeNameValues.reverse[fareTypeName],
    "FareTypeNameReturn": fareTypeNameValues.reverse[fareTypeNameReturn],
  };
}

class BrandProperty {
  FareTypeName? brandName;
  FareTypeName? brandNameReturn;
  JourneyIdentifier? journeyIdentifier;
  bool? isRefundable;
  RefundInfo? refundInfo;
  List<BrandedFeature>? brandedFeatures;
  List<FlightInfoElement>? flightInfo;
  List<BgF>? bgF;
  List<MlF>? mlF;
  bool? isBrandDescriptionText;
  dynamic brandDescriptionText;
  bool? isExtendedBaggage;
  int? categoryId;
  bool? ischangeable;
  bool? penalityApplies;
  bool? isMultiBaggageSelectionAvailable;
  int? priorityType;

  BrandProperty({
    this.brandName,
    this.brandNameReturn,
    this.journeyIdentifier,
    this.isRefundable,
    this.refundInfo,
    this.brandedFeatures,
    this.flightInfo,
    this.bgF,
    this.mlF,
    this.isBrandDescriptionText,
    this.brandDescriptionText,
    this.isExtendedBaggage,
    this.categoryId,
    this.ischangeable,
    this.penalityApplies,
    this.isMultiBaggageSelectionAvailable,
    this.priorityType,
  });

  factory BrandProperty.fromJson(Map<String, dynamic> json) => BrandProperty(
    brandName: fareTypeNameValues.map[json["BrandName"]]!,
    brandNameReturn: fareTypeNameValues.map[json["BrandNameReturn"]]!,
    journeyIdentifier: journeyIdentifierValues.map[json["journeyIdentifier"]]!,
    isRefundable: json["IsRefundable"],
    refundInfo: json["RefundInfo"] == null
        ? null
        : RefundInfo.fromJson(json["RefundInfo"]),
    brandedFeatures: json["BrandedFeatures"] == null
        ? []
        : List<BrandedFeature>.from(
            json["BrandedFeatures"]!.map((x) => brandedFeatureValues.map[x]!),
          ),
    flightInfo: json["FlightInfo"] == null
        ? []
        : List<FlightInfoElement>.from(
            json["FlightInfo"]!.map((x) => FlightInfoElement.fromJson(x)),
          ),
    bgF: json["BG-F"] == null
        ? []
        : List<BgF>.from(json["BG-F"]!.map((x) => BgF.fromJson(x))),
    mlF: json["ML-F"] == null
        ? []
        : List<MlF>.from(json["ML-F"]!.map((x) => MlF.fromJson(x))),
    isBrandDescriptionText: json["IsBrandDescriptionText"],
    brandDescriptionText: json["BrandDescriptionText"],
    isExtendedBaggage: json["IsExtendedBaggage"],
    categoryId: json["CategoryId"],
    ischangeable: json["Ischangeable"],
    penalityApplies: json["PenalityApplies"],
    isMultiBaggageSelectionAvailable: json["IsMultiBaggageSelectionAvailable"],
    priorityType: json["PriorityType"],
  );

  Map<String, dynamic> toJson() => {
    "BrandName": fareTypeNameValues.reverse[brandName],
    "BrandNameReturn": fareTypeNameValues.reverse[brandNameReturn],
    "journeyIdentifier": journeyIdentifierValues.reverse[journeyIdentifier],
    "IsRefundable": isRefundable,
    "RefundInfo": refundInfo?.toJson(),
    "BrandedFeatures": brandedFeatures == null
        ? []
        : List<dynamic>.from(
            brandedFeatures!.map((x) => brandedFeatureValues.reverse[x]),
          ),
    "FlightInfo": flightInfo == null
        ? []
        : List<dynamic>.from(flightInfo!.map((x) => x.toJson())),
    "BG-F": bgF == null ? [] : List<dynamic>.from(bgF!.map((x) => x.toJson())),
    "ML-F": mlF == null ? [] : List<dynamic>.from(mlF!.map((x) => x.toJson())),
    "IsBrandDescriptionText": isBrandDescriptionText,
    "BrandDescriptionText": brandDescriptionText,
    "IsExtendedBaggage": isExtendedBaggage,
    "CategoryId": categoryId,
    "Ischangeable": ischangeable,
    "PenalityApplies": penalityApplies,
    "IsMultiBaggageSelectionAvailable": isMultiBaggageSelectionAvailable,
    "PriorityType": priorityType,
  };
}

class BgF {
  BgFType? type;
  BgFUnit? unit;
  String? weight;
  String? pieces;
  dynamic handBaggageDescription1;
  DisplayText? displayText;
  SegmentIdentifier? segmentIdentifier;
  List<String>? applicableTo;
  List<dynamic>? paxIdentifier;

  BgF({
    this.type,
    this.unit,
    this.weight,
    this.pieces,
    this.handBaggageDescription1,
    this.displayText,
    this.segmentIdentifier,
    this.applicableTo,
    this.paxIdentifier,
  });

  factory BgF.fromJson(Map<String, dynamic> json) => BgF(
    type: bgFTypeValues.map[json["type"]]!,
    unit: bgFUnitValues.map[json["unit"]]!,
    weight: json["weight"],
    pieces: json["pieces"],
    handBaggageDescription1: json["HandBaggageDescription1"],
    displayText: displayTextValues.map[json["displayText"]]!,
    segmentIdentifier: segmentIdentifierValues.map[json["segmentIdentifier"]]!,
    applicableTo: json["applicableTo"] == null
        ? []
        : List<String>.from(json["applicableTo"]!.map((x) => x)),
    paxIdentifier: json["paxIdentifier"] == null
        ? []
        : List<dynamic>.from(json["paxIdentifier"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": bgFTypeValues.reverse[type],
    "unit": bgFUnitValues.reverse[unit],
    "weight": weight,
    "pieces": pieces,
    "HandBaggageDescription1": handBaggageDescription1,
    "displayText": displayTextValues.reverse[displayText],
    "segmentIdentifier": segmentIdentifierValues.reverse[segmentIdentifier],
    "applicableTo": applicableTo == null
        ? []
        : List<dynamic>.from(applicableTo!.map((x) => x)),
    "paxIdentifier": paxIdentifier == null
        ? []
        : List<dynamic>.from(paxIdentifier!.map((x) => x)),
  };
}

enum DisplayText { THE_1_P, THE_2_P, THE_30_KG }

final displayTextValues = EnumValues({
  "1P": DisplayText.THE_1_P,
  "2P": DisplayText.THE_2_P,
  "30Kg": DisplayText.THE_30_KG,
});

enum SegmentIdentifier { SG_001001, SG_001002, SG_002001, SG_002002 }

final segmentIdentifierValues = EnumValues({
  "SG-001-001": SegmentIdentifier.SG_001001,
  "SG-001-002": SegmentIdentifier.SG_001002,
  "SG-002-001": SegmentIdentifier.SG_002001,
  "SG-002-002": SegmentIdentifier.SG_002002,
});

enum BgFType { CABIN, CHECKED }

final bgFTypeValues = EnumValues({
  "cabin": BgFType.CABIN,
  "checked": BgFType.CHECKED,
});

enum BgFUnit { KG, PC }

final bgFUnitValues = EnumValues({"KG": BgFUnit.KG, "PC": BgFUnit.PC});

enum FareTypeName {
  BASIC_FARE,
  COMFORTFLEX,
  ECONOMY_BEST_BUY,
  ECONOMY_BEST_OFFER,
  ECONOMY_COMFORT,
  ECONOMY_FLEX,
  ECONOMY_FULLY_FLEX,
  ECONOMY_GOOD_DEAL,
  ECONOMY_VALUE,
  FLEXIBLE,
  RESTRICTED,
}

final fareTypeNameValues = EnumValues({
  "BASIC FARE": FareTypeName.BASIC_FARE,
  "Comfortflex": FareTypeName.COMFORTFLEX,
  "Economy Best Buy": FareTypeName.ECONOMY_BEST_BUY,
  "Economy Best Offer": FareTypeName.ECONOMY_BEST_OFFER,
  "Economy Comfort": FareTypeName.ECONOMY_COMFORT,
  "Economy Flex": FareTypeName.ECONOMY_FLEX,
  "Economy Fully Flex": FareTypeName.ECONOMY_FULLY_FLEX,
  "Economy Good Deal": FareTypeName.ECONOMY_GOOD_DEAL,
  "Economy Value": FareTypeName.ECONOMY_VALUE,
  "Flexible": FareTypeName.FLEXIBLE,
  "Restricted": FareTypeName.RESTRICTED,
});

enum BrandedFeature {
  MILEAGE_ACCRUAL,
  PRIORITY_BOARDING,
  PRIORITY_CHECK_IN,
  REBOOKING,
  REBOOKING_CHARGEABLE,
  REFUND,
  REFUND_CHARGEABLE,
  SEAT_ASSIGNMENT,
  SEAT_ASSIGNMENT_CHARGEABLE,
  WI_FI,
}

final brandedFeatureValues = EnumValues({
  "Mileage Accrual": BrandedFeature.MILEAGE_ACCRUAL,
  "Priority Boarding": BrandedFeature.PRIORITY_BOARDING,
  "Priority CheckIn": BrandedFeature.PRIORITY_CHECK_IN,
  "Rebooking": BrandedFeature.REBOOKING,
  "Rebooking(Chargeable)": BrandedFeature.REBOOKING_CHARGEABLE,
  "Refund": BrandedFeature.REFUND,
  "Refund(Chargeable)": BrandedFeature.REFUND_CHARGEABLE,
  "SeatAssignment": BrandedFeature.SEAT_ASSIGNMENT,
  "SeatAssignment(Chargeable)": BrandedFeature.SEAT_ASSIGNMENT_CHARGEABLE,
  "WiFi": BrandedFeature.WI_FI,
});

class FlightInfoElement {
  SegmentIdentifier? segmentIdentifier;
  Cabin? cabin;
  BookingCode? classOfService;

  FlightInfoElement({this.segmentIdentifier, this.cabin, this.classOfService});

  factory FlightInfoElement.fromJson(Map<String, dynamic> json) =>
      FlightInfoElement(
        segmentIdentifier:
            segmentIdentifierValues.map[json["segmentIdentifier"]]!,
        cabin: cabinValues.map[json["cabin"]]!,
        classOfService: bookingCodeValues.map[json["classOfService"]]!,
      );

  Map<String, dynamic> toJson() => {
    "segmentIdentifier": segmentIdentifierValues.reverse[segmentIdentifier],
    "cabin": cabinValues.reverse[cabin],
    "classOfService": bookingCodeValues.reverse[classOfService],
  };
}

enum Cabin { Y }

final cabinValues = EnumValues({"Y": Cabin.Y});

enum BookingCode { A, B, E, H, K, L, M, Q, S, T, U, W }

final bookingCodeValues = EnumValues({
  "A": BookingCode.A,
  "B": BookingCode.B,
  "E": BookingCode.E,
  "H": BookingCode.H,
  "K": BookingCode.K,
  "L": BookingCode.L,
  "M": BookingCode.M,
  "Q": BookingCode.Q,
  "S": BookingCode.S,
  "T": BookingCode.T,
  "U": BookingCode.U,
  "W": BookingCode.W,
});

enum JourneyIdentifier { JN_001, JN_002 }

final journeyIdentifierValues = EnumValues({
  "JN-001": JourneyIdentifier.JN_001,
  "JN-002": JourneyIdentifier.JN_002,
});

class MlF {
  String? displayText;
  MlFType? type;
  MlFUnit? unit;
  String? quantity;
  SegmentIdentifier? segmentIdentifier;
  List<String>? applicableTo;
  List<dynamic>? paxIdentifier;
  int? journeyGroupNo;
  int? segmentNo;

  MlF({
    this.displayText,
    this.type,
    this.unit,
    this.quantity,
    this.segmentIdentifier,
    this.applicableTo,
    this.paxIdentifier,
    this.journeyGroupNo,
    this.segmentNo,
  });

  factory MlF.fromJson(Map<String, dynamic> json) => MlF(
    displayText: json["displayText"],
    type: mlFTypeValues.map[json["type"]]!,
    unit: mlFUnitValues.map[json["unit"]]!,
    quantity: json["quantity"],
    segmentIdentifier: segmentIdentifierValues.map[json["segmentIdentifier"]]!,
    applicableTo: json["applicableTo"] == null
        ? []
        : List<String>.from(json["applicableTo"]!.map((x) => x)),
    paxIdentifier: json["paxIdentifier"] == null
        ? []
        : List<dynamic>.from(json["paxIdentifier"]!.map((x) => x)),
    journeyGroupNo: json["JourneyGroupNo"],
    segmentNo: json["SegmentNo"],
  );

  Map<String, dynamic> toJson() => {
    "displayText": displayText,
    "type": mlFTypeValues.reverse[type],
    "unit": mlFUnitValues.reverse[unit],
    "quantity": quantity,
    "segmentIdentifier": segmentIdentifierValues.reverse[segmentIdentifier],
    "applicableTo": applicableTo == null
        ? []
        : List<dynamic>.from(applicableTo!.map((x) => x)),
    "paxIdentifier": paxIdentifier == null
        ? []
        : List<dynamic>.from(paxIdentifier!.map((x) => x)),
    "JourneyGroupNo": journeyGroupNo,
    "SegmentNo": segmentNo,
  };
}

enum MlFType { MEAL }

final mlFTypeValues = EnumValues({"meal": MlFType.MEAL});

enum MlFUnit { NOS }

final mlFUnitValues = EnumValues({"Nos": MlFUnit.NOS});

class RefundInfo {
  int? value;
  RefundInfoName? name;
  dynamic notes;

  RefundInfo({this.value, this.name, this.notes});

  factory RefundInfo.fromJson(Map<String, dynamic> json) => RefundInfo(
    value: json["Value"],
    name: refundInfoNameValues.map[json["Name"]]!,
    notes: json["Notes"],
  );

  Map<String, dynamic> toJson() => {
    "Value": value,
    "Name": refundInfoNameValues.reverse[name],
    "Notes": notes,
  };
}

enum RefundInfoName { NON_REFUNDABLE, REFUNDABLE, REFUNDABLE_WITH_CHARGES }

final refundInfoNameValues = EnumValues({
  "Non Refundable": RefundInfoName.NON_REFUNDABLE,
  "Refundable": RefundInfoName.REFUNDABLE,
  "Refundable with Charges": RefundInfoName.REFUNDABLE_WITH_CHARGES,
});

class FareDetails {
  Currency? currency;
  List<PaxFareSplitup>? paxFareSplitup;
  String? baseFare;
  String? service;
  String? discount;
  PromotionText? promotionText;
  String? tax;
  String? couponDiscount;
  String? loayaltyDiscount;
  String? referralDiscount;
  String? milesDiscount;
  String? paymentGatewayCharge;
  String? smsCharge;
  String? payLaterAmount;
  String? mealCharge;
  String? seatCharge;
  String? instantMarkup;
  String? instantDiscount;
  String? strikeOutAmount;
  String? grossAmount;
  int? decimalPoint;
  int? conversionRate;
  String? total;
  String? totalAddExtrasAmount;
  dynamic loyaltyRedeemPoint;

  FareDetails({
    this.currency,
    this.paxFareSplitup,
    this.baseFare,
    this.service,
    this.discount,
    this.promotionText,
    this.tax,
    this.couponDiscount,
    this.loayaltyDiscount,
    this.referralDiscount,
    this.milesDiscount,
    this.paymentGatewayCharge,
    this.smsCharge,
    this.payLaterAmount,
    this.mealCharge,
    this.seatCharge,
    this.instantMarkup,
    this.instantDiscount,
    this.strikeOutAmount,
    this.grossAmount,
    this.decimalPoint,
    this.conversionRate,
    this.total,
    this.totalAddExtrasAmount,
    this.loyaltyRedeemPoint,
  });

  factory FareDetails.fromJson(Map<String, dynamic> json) => FareDetails(
    currency: currencyValues.map[json["Currency"]]!,
    paxFareSplitup: json["PaxFareSplitup"] == null
        ? []
        : List<PaxFareSplitup>.from(
            json["PaxFareSplitup"]!.map((x) => PaxFareSplitup.fromJson(x)),
          ),
    baseFare: json["BaseFare"],
    service: json["Service"],
    discount: json["Discount"],
    promotionText: json["PromotionText"] == null
        ? null
        : PromotionText.fromJson(json["PromotionText"]),
    tax: json["Tax"],
    couponDiscount: json["CouponDiscount"],
    loayaltyDiscount: json["LoayaltyDiscount"],
    referralDiscount: json["ReferralDiscount"],
    milesDiscount: json["MilesDiscount"],
    paymentGatewayCharge: json["PaymentGatewayCharge"],
    smsCharge: json["SMSCharge"],
    payLaterAmount: json["PayLaterAmount"],
    mealCharge: json["MealCharge"],
    seatCharge: json["SeatCharge"],
    instantMarkup: json["InstantMarkup"],
    instantDiscount: json["InstantDiscount"],
    strikeOutAmount: json["StrikeOutAmount"],
    grossAmount: json["GrossAmount"],
    decimalPoint: json["DecimalPoint"],
    conversionRate: json["ConversionRate"],
    total: json["Total"],
    totalAddExtrasAmount: json["TotalAddExtrasAmount"],
    loyaltyRedeemPoint: json["LoyaltyRedeemPoint"],
  );

  Map<String, dynamic> toJson() => {
    "Currency": currencyValues.reverse[currency],
    "PaxFareSplitup": paxFareSplitup == null
        ? []
        : List<dynamic>.from(paxFareSplitup!.map((x) => x.toJson())),
    "BaseFare": baseFare,
    "Service": service,
    "Discount": discount,
    "PromotionText": promotionText?.toJson(),
    "Tax": tax,
    "CouponDiscount": couponDiscount,
    "LoayaltyDiscount": loayaltyDiscount,
    "ReferralDiscount": referralDiscount,
    "MilesDiscount": milesDiscount,
    "PaymentGatewayCharge": paymentGatewayCharge,
    "SMSCharge": smsCharge,
    "PayLaterAmount": payLaterAmount,
    "MealCharge": mealCharge,
    "SeatCharge": seatCharge,
    "InstantMarkup": instantMarkup,
    "InstantDiscount": instantDiscount,
    "StrikeOutAmount": strikeOutAmount,
    "GrossAmount": grossAmount,
    "DecimalPoint": decimalPoint,
    "ConversionRate": conversionRate,
    "Total": total,
    "TotalAddExtrasAmount": totalAddExtrasAmount,
    "LoyaltyRedeemPoint": loyaltyRedeemPoint,
  };
}

class PaxFareSplitup {
  String? baseFare;
  String? tax;
  String? service;
  String? discount;
  int? decimalPoint;
  int? conversionRate;
  List<AirlineTax>? airlineTaxes;
  int? paxType;
  int? count;
  String? total;

  PaxFareSplitup({
    this.baseFare,
    this.tax,
    this.service,
    this.discount,
    this.decimalPoint,
    this.conversionRate,
    this.airlineTaxes,
    this.paxType,
    this.count,
    this.total,
  });

  factory PaxFareSplitup.fromJson(Map<String, dynamic> json) => PaxFareSplitup(
    baseFare: json["BaseFare"],
    tax: json["Tax"],
    service: json["Service"],
    discount: json["Discount"],
    decimalPoint: json["DecimalPoint"],
    conversionRate: json["ConversionRate"],
    airlineTaxes: json["AirlineTaxes"] == null
        ? []
        : List<AirlineTax>.from(
            json["AirlineTaxes"]!.map((x) => AirlineTax.fromJson(x)),
          ),
    paxType: json["PaxType"],
    count: json["Count"],
    total: json["Total"],
  );

  Map<String, dynamic> toJson() => {
    "BaseFare": baseFare,
    "Tax": tax,
    "Service": service,
    "Discount": discount,
    "DecimalPoint": decimalPoint,
    "ConversionRate": conversionRate,
    "AirlineTaxes": airlineTaxes == null
        ? []
        : List<dynamic>.from(airlineTaxes!.map((x) => x.toJson())),
    "PaxType": paxType,
    "Count": count,
    "Total": total,
  };
}

class AirlineTax {
  dynamic taxCode;
  double? taxAmount;
  int? taxId;

  AirlineTax({this.taxCode, this.taxAmount, this.taxId});

  factory AirlineTax.fromJson(Map<String, dynamic> json) => AirlineTax(
    taxCode: json["TaxCode"],
    taxAmount: json["TaxAmount"]?.toDouble(),
    taxId: json["TaxId"],
  );

  Map<String, dynamic> toJson() => {
    "TaxCode": taxCode,
    "TaxAmount": taxAmount,
    "TaxId": taxId,
  };
}

class PromotionText {
  PromotionText();

  factory PromotionText.fromJson(Map<String, dynamic> json) => PromotionText();

  Map<String, dynamic> toJson() => {};
}

enum FareKey { BF_002001, BF_002002, BF_002003, BF_002004, GF_002000 }

final fareKeyValues = EnumValues({
  "BF-002-001": FareKey.BF_002001,
  "BF-002-002": FareKey.BF_002002,
  "BF-002-003": FareKey.BF_002003,
  "BF-002-004": FareKey.BF_002004,
  "GF-002-000": FareKey.GF_002000,
});

class PenaltiesInfo {
  PenaltyType? penaltyType;
  Applicability? applicability;
  double? amount;
  Currency? currencyCode;
  bool? isPercentage;
  PassengerType? passengerType;
  int? toTime;
  int? fromTime;
  dynamic refundable;
  dynamic refundableNotes;
  dynamic exchangeNotes;
  bool? penalityApplies;

  PenaltiesInfo({
    this.penaltyType,
    this.applicability,
    this.amount,
    this.currencyCode,
    this.isPercentage,
    this.passengerType,
    this.toTime,
    this.fromTime,
    this.refundable,
    this.refundableNotes,
    this.exchangeNotes,
    this.penalityApplies,
  });

  factory PenaltiesInfo.fromJson(Map<String, dynamic> json) => PenaltiesInfo(
    penaltyType: penaltyTypeValues.map[json["PenaltyType"]]!,
    applicability: applicabilityValues.map[json["Applicability"]]!,
    amount: json["Amount"]?.toDouble(),
    currencyCode: currencyValues.map[json["CurrencyCode"]]!,
    isPercentage: json["IsPercentage"],
    passengerType: passengerTypeValues.map[json["PassengerType"]]!,
    toTime: json["ToTime"],
    fromTime: json["FromTime"],
    refundable: json["Refundable"],
    refundableNotes: json["RefundableNotes"],
    exchangeNotes: json["ExchangeNotes"],
    penalityApplies: json["PenalityApplies"],
  );

  Map<String, dynamic> toJson() => {
    "PenaltyType": penaltyTypeValues.reverse[penaltyType],
    "Applicability": applicabilityValues.reverse[applicability],
    "Amount": amount,
    "CurrencyCode": currencyValues.reverse[currencyCode],
    "IsPercentage": isPercentage,
    "PassengerType": passengerTypeValues.reverse[passengerType],
    "ToTime": toTime,
    "FromTime": fromTime,
    "Refundable": refundable,
    "RefundableNotes": refundableNotes,
    "ExchangeNotes": exchangeNotes,
    "PenalityApplies": penalityApplies,
  };
}

enum Applicability { AFTER_DEPARTURE, ANYTIME, BEFORE_DEPARTURE }

final applicabilityValues = EnumValues({
  "AfterDeparture": Applicability.AFTER_DEPARTURE,
  "Anytime": Applicability.ANYTIME,
  "BeforeDeparture": Applicability.BEFORE_DEPARTURE,
});

enum PassengerType { ADULT }

final passengerTypeValues = EnumValues({"Adult": PassengerType.ADULT});

enum PenaltyType { EXCHANGE, REFUND }

final penaltyTypeValues = EnumValues({
  "Exchange": PenaltyType.EXCHANGE,
  "Refund": PenaltyType.REFUND,
});

enum AdditionalRequest { BF, BGF, BGP, FR, MLF, MLP, STP }

final additionalRequestValues = EnumValues({
  "BF": AdditionalRequest.BF,
  "BGF": AdditionalRequest.BGF,
  "BGP": AdditionalRequest.BGP,
  "FR": AdditionalRequest.FR,
  "MLF": AdditionalRequest.MLF,
  "MLP": AdditionalRequest.MLP,
  "STP": AdditionalRequest.STP,
});

class FlightJourney {
  JourneyId? journeyId;
  JourneyIdentifier? journeyIdentifier;
  int? travelDirection;
  TripDuration? journeyTime;
  int? totalStops;
  List<FlightItem>? flightItems;
  bool? dayChange;
  bool? isConnection;
  bool? isAirportChange;

  FlightJourney({
    this.journeyId,
    this.journeyIdentifier,
    this.travelDirection,
    this.journeyTime,
    this.totalStops,
    this.flightItems,
    this.dayChange,
    this.isConnection,
    this.isAirportChange,
  });

  factory FlightJourney.fromJson(Map<String, dynamic> json) => FlightJourney(
    journeyId: journeyIdValues.map[json["JourneyID"]]!,
    journeyIdentifier: journeyIdentifierValues.map[json["JourneyIdentifier"]]!,
    travelDirection: json["TravelDirection"],
    journeyTime: json["JourneyTime"] == null
        ? null
        : TripDuration.fromJson(json["JourneyTime"]),
    totalStops: json["TotalStops"],
    flightItems: json["FlightItems"] == null
        ? []
        : List<FlightItem>.from(
            json["FlightItems"]!.map((x) => FlightItem.fromJson(x)),
          ),
    dayChange: json["DayChange"],
    isConnection: json["IsConnection"],
    isAirportChange: json["IsAirportChange"],
  );

  Map<String, dynamic> toJson() => {
    "JourneyID": journeyIdValues.reverse[journeyId],
    "JourneyIdentifier": journeyIdentifierValues.reverse[journeyIdentifier],
    "TravelDirection": travelDirection,
    "JourneyTime": journeyTime?.toJson(),
    "TotalStops": totalStops,
    "FlightItems": flightItems == null
        ? []
        : List<dynamic>.from(flightItems!.map((x) => x.toJson())),
    "DayChange": dayChange,
    "IsConnection": isConnection,
    "IsAirportChange": isAirportChange,
  };
}

class FlightItem {
  LegId? legId;
  SegmentIdentifier? segmentIdentifier;
  Arrival? departure;
  Arrival? arrival;
  dynamic stopOver;
  FlightItemFlightInfo? flightInfo;
  dynamic codeShareInfoAirline;
  TripDuration? durationPerLeg;
  TripDuration? transitTime;
  int? numberOfStops;
  dynamic soAirports;
  dynamic layOverCity;
  dynamic layOutTime;
  dynamic baggageDetails;

  FlightItem({
    this.legId,
    this.segmentIdentifier,
    this.departure,
    this.arrival,
    this.stopOver,
    this.flightInfo,
    this.codeShareInfoAirline,
    this.durationPerLeg,
    this.transitTime,
    this.numberOfStops,
    this.soAirports,
    this.layOverCity,
    this.layOutTime,
    this.baggageDetails,
  });

  factory FlightItem.fromJson(Map<String, dynamic> json) => FlightItem(
    legId: legIdValues.map[json["LegID"]]!,
    segmentIdentifier: segmentIdentifierValues.map[json["SegmentIdentifier"]]!,
    departure: json["Departure"] == null
        ? null
        : Arrival.fromJson(json["Departure"]),
    arrival: json["Arrival"] == null ? null : Arrival.fromJson(json["Arrival"]),
    stopOver: json["StopOver"],
    flightInfo: json["FlightInfo"] == null
        ? null
        : FlightItemFlightInfo.fromJson(json["FlightInfo"]),
    codeShareInfoAirline: json["CodeShareInfoAirline"],
    durationPerLeg: json["DurationPerLeg"] == null
        ? null
        : TripDuration.fromJson(json["DurationPerLeg"]),
    transitTime: json["TransitTime"] == null
        ? null
        : TripDuration.fromJson(json["TransitTime"]),
    numberOfStops: json["NumberOfStops"],
    soAirports: json["SOAirports"],
    layOverCity: json["LayOverCity"],
    layOutTime: json["LayOutTime"],
    baggageDetails: json["BaggageDetails"],
  );

  Map<String, dynamic> toJson() => {
    "LegID": legIdValues.reverse[legId],
    "SegmentIdentifier": segmentIdentifierValues.reverse[segmentIdentifier],
    "Departure": departure?.toJson(),
    "Arrival": arrival?.toJson(),
    "StopOver": stopOver,
    "FlightInfo": flightInfo?.toJson(),
    "CodeShareInfoAirline": codeShareInfoAirline,
    "DurationPerLeg": durationPerLeg?.toJson(),
    "TransitTime": transitTime?.toJson(),
    "NumberOfStops": numberOfStops,
    "SOAirports": soAirports,
    "LayOverCity": layOverCity,
    "LayOutTime": layOutTime,
    "BaggageDetails": baggageDetails,
  };
}

class Arrival {
  AirportCode? airportCode;
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
    airportCode: airportCodeValues.map[json["AirportCode"]]!,
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
    "AirportCode": airportCodeValues.reverse[airportCode],
    "CountryName": countryName?.toJson(),
    "CityName": cityName?.toJson(),
    "AirportName": airportName?.toJson(),
    "DateTime": dateTime?.toIso8601String(),
    "Terminal": terminal,
  };
}

enum AirportCode { AMM, ATH, CAI, DMM, DXB, IST, KWI, MCT, RUH }

final airportCodeValues = EnumValues({
  "AMM": AirportCode.AMM,
  "ATH": AirportCode.ATH,
  "CAI": AirportCode.CAI,
  "DMM": AirportCode.DMM,
  "DXB": AirportCode.DXB,
  "IST": AirportCode.IST,
  "KWI": AirportCode.KWI,
  "MCT": AirportCode.MCT,
  "RUH": AirportCode.RUH,
});

class Name {
  En? en;
  Ar? ar;

  Name({this.en, this.ar});

  factory Name.fromJson(Map<String, dynamic> json) =>
      Name(en: enValues.map[json["en"]]!, ar: arValues.map[json["ar"]]!);

  Map<String, dynamic> toJson() => {
    "en": enValues.reverse[en],
    "ar": arValues.reverse[ar],
  };
}

enum Ar {
  AMBITIOUS,
  AR,
  BRAGGADOCIOUS,
  CUNNING,
  EMPTY,
  FLUFFY,
  FRISKY,
  HILARIOUS,
  INDECENT,
  INDIGO,
  MAGENTA,
  MISCHIEVOUS,
  PURPLE,
  STICKY,
  TENTACLED,
  THE_1,
  THE_10,
  THE_11,
  THE_12,
  THE_13,
  THE_14,
  THE_15,
  THE_16,
  THE_17,
  THE_2,
  THE_3,
  THE_4,
  THE_5,
  THE_6,
  THE_7,
  THE_8,
  THE_9,
}

final arValues = EnumValues({
  "عمان": Ar.AMBITIOUS,
  "قاهره مطار دولي": Ar.AR,
  "الرياض": Ar.BRAGGADOCIOUS,
  "القاهرة": Ar.CUNNING,
  "الملكة علياء مطار دولي": Ar.EMPTY,
  "السيب مطار دولي": Ar.FLUFFY,
  "مسقط": Ar.FRISKY,
  "الفيثيريوس فينزيلوس مطار دولي": Ar.HILARIOUS,
  "اسطنبول مطار": Ar.INDECENT,
  "دمام الملك فهد مطار الدولي": Ar.INDIGO,
  "دبي": Ar.MAGENTA,
  "الكويت": Ar.MISCHIEVOUS,
  "دبي مطار دولي": Ar.PURPLE,
  "رياض الملك خالد مطار دولي": Ar.STICKY,
  "كويت مطار دولي": Ar.TENTACLED,
  "الدمام": Ar.THE_1,
  "الملكية الأردنية": Ar.THE_10,
  "مصر للطيران": Ar.THE_11,
  "الطيران العماني": Ar.THE_12,
  "الخطوط الجوية الكويتية": Ar.THE_13,
  "طيران ناس": Ar.THE_14,
  "الخطوط الجوية التركية": Ar.THE_15,
  "ايقين للطيران": Ar.THE_16,
  "هان اير": Ar.THE_17,
  "اسطنبول": Ar.THE_2,
  "اثينا": Ar.THE_3,
  "الاردن": Ar.THE_4,
  "مصر": Ar.THE_5,
  "الامارات": Ar.THE_6,
  "السعودية": Ar.THE_7,
  "تركيا": Ar.THE_8,
  "اليونان": Ar.THE_9,
});

enum En {
  AEGEAN_AIR,
  AMMAN,
  ATHENS,
  CAIRO,
  CAIRO_INTL_AIRPORT,
  DAMMAM,
  DUBAI,
  DUBAI_INTL_AIRPORT,
  EGYPT,
  EGYPTAIR,
  ELEFTHERIOS_VENIZELOS_INTL_AIRPORT,
  EN_KUWAIT,
  FLYNAS,
  GREECE,
  HAHN_AIR_BUSINESSLINE,
  ISTANBUL,
  ISTANBUL_AIRPORT,
  JORDAN,
  KING_FAHAD_AIRPORT,
  KING_KHALED_INTL,
  KUWAIT,
  KUWAIT_AIRWAYS,
  KUWAIT_INTL,
  MUSCAT,
  OMAN,
  OMAN_AVIATION,
  QUEEN_ALIA_INTL_AIRPORT,
  RIYADH,
  ROYAL_JORDANIAN,
  SAUDI_ARABIA,
  SEEB_INTL,
  TURKEY,
  TURKISH_AIRLINES,
  UNITED_ARAB_EMIRATES,
}

final enValues = EnumValues({
  "Aegean Air": En.AEGEAN_AIR,
  "Amman": En.AMMAN,
  "Athens": En.ATHENS,
  "Cairo": En.CAIRO,
  "Cairo Intl Airport": En.CAIRO_INTL_AIRPORT,
  "Dammam": En.DAMMAM,
  "Dubai": En.DUBAI,
  "Dubai Intl Airport": En.DUBAI_INTL_AIRPORT,
  "EGYPT": En.EGYPT,
  "Egyptair": En.EGYPTAIR,
  "Eleftherios Venizelos Intl Airport": En.ELEFTHERIOS_VENIZELOS_INTL_AIRPORT,
  "KUWAIT": En.EN_KUWAIT,
  "Flynas": En.FLYNAS,
  "GREECE": En.GREECE,
  "Hahn Air Businessline": En.HAHN_AIR_BUSINESSLINE,
  "Istanbul": En.ISTANBUL,
  "Istanbul Airport": En.ISTANBUL_AIRPORT,
  "JORDAN": En.JORDAN,
  "King Fahad Airport": En.KING_FAHAD_AIRPORT,
  "King Khaled Intl": En.KING_KHALED_INTL,
  "Kuwait": En.KUWAIT,
  "Kuwait Airways": En.KUWAIT_AIRWAYS,
  "Kuwait Intl": En.KUWAIT_INTL,
  "Muscat": En.MUSCAT,
  "OMAN": En.OMAN,
  "Oman Aviation": En.OMAN_AVIATION,
  "Queen Alia Intl Airport": En.QUEEN_ALIA_INTL_AIRPORT,
  "Riyadh": En.RIYADH,
  "Royal Jordanian": En.ROYAL_JORDANIAN,
  "SAUDI ARABIA": En.SAUDI_ARABIA,
  "Seeb Intl": En.SEEB_INTL,
  "TURKEY": En.TURKEY,
  "Turkish Airlines": En.TURKISH_AIRLINES,
  "UNITED ARAB EMIRATES": En.UNITED_ARAB_EMIRATES,
});

class TripDuration {
  int? days;
  int? hours;
  int? minutes;

  TripDuration({this.days, this.hours, this.minutes});

  factory TripDuration.fromJson(Map<String, dynamic> json) => TripDuration(
    days: json["Days"],
    hours: json["Hours"],
    minutes: json["Minutes"],
  );

  Map<String, dynamic> toJson() => {
    "Days": days,
    "Hours": hours,
    "Minutes": minutes,
  };
}

class FlightItemFlightInfo {
  Name? name;
  OperatingVendor? code;
  String? number;
  Cabin? cabinClass;
  String? brandName;
  BookingCode? bookingCode;
  String? aircraftName;
  EquipmentNumber? equipmentNumber;
  bool? isRedEye;

  FlightItemFlightInfo({
    this.name,
    this.code,
    this.number,
    this.cabinClass,
    this.brandName,
    this.bookingCode,
    this.aircraftName,
    this.equipmentNumber,
    this.isRedEye,
  });

  factory FlightItemFlightInfo.fromJson(Map<String, dynamic> json) =>
      FlightItemFlightInfo(
        name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
        code: operatingVendorValues.map[json["Code"]]!,
        number: json["Number"],
        cabinClass: cabinValues.map[json["CabinClass"]]!,
        brandName: json["BrandName"],
        bookingCode: bookingCodeValues.map[json["BookingCode"]]!,
        aircraftName: json["AircraftName"],
        equipmentNumber: equipmentNumberValues.map[json["EquipmentNumber"]]!,
        isRedEye: json["IsRedEye"],
      );

  Map<String, dynamic> toJson() => {
    "Name": name?.toJson(),
    "Code": operatingVendorValues.reverse[code],
    "Number": number,
    "CabinClass": cabinValues.reverse[cabinClass],
    "BrandName": brandName,
    "BookingCode": bookingCodeValues.reverse[bookingCode],
    "AircraftName": aircraftName,
    "EquipmentNumber": equipmentNumberValues.reverse[equipmentNumber],
    "IsRedEye": isRedEye,
  };
}

enum OperatingVendor { A3, HR, KU, MS, RJ, TK, WY, XY }

final operatingVendorValues = EnumValues({
  "A3": OperatingVendor.A3,
  "HR": OperatingVendor.HR,
  "KU": OperatingVendor.KU,
  "MS": OperatingVendor.MS,
  "RJ": OperatingVendor.RJ,
  "TK": OperatingVendor.TK,
  "WY": OperatingVendor.WY,
  "XY": OperatingVendor.XY,
});

enum EquipmentNumber {
  AIRBUS_A320,
  AIRBUS_A320_212,
  AIRBUS_A321_NEO,
  AIRBUS_A330_200,
  AIRBUS_A330_300,
  AIRBUS_A350_900,
  BOEING_737800,
  BOEING_737_MAX,
  BOEING_7878,
  BOEING_7879,
  EMBRAER190_E2,
  EMBRAER195_E2,
}

final equipmentNumberValues = EnumValues({
  "Airbus A320": EquipmentNumber.AIRBUS_A320,
  "Airbus A320-212": EquipmentNumber.AIRBUS_A320_212,
  "Airbus A321 NEO": EquipmentNumber.AIRBUS_A321_NEO,
  "Airbus A330-200": EquipmentNumber.AIRBUS_A330_200,
  "Airbus A330-300": EquipmentNumber.AIRBUS_A330_300,
  "Airbus A350-900": EquipmentNumber.AIRBUS_A350_900,
  "Boeing 737-800": EquipmentNumber.BOEING_737800,
  "Boeing 737Max": EquipmentNumber.BOEING_737_MAX,
  "Boeing 787-8": EquipmentNumber.BOEING_7878,
  "Boeing 787-9": EquipmentNumber.BOEING_7879,
  "Embraer190 E2": EquipmentNumber.EMBRAER190_E2,
  "Embraer195 E2": EquipmentNumber.EMBRAER195_E2,
});

enum LegId { L_0130, L_1130 }

final legIdValues = EnumValues({
  "L-0-130": LegId.L_0130,
  "L-1-130": LegId.L_1130,
});

enum JourneyId { J_0130, J_1130 }

final journeyIdValues = EnumValues({
  "J-0-130": JourneyId.J_0130,
  "J-1-130": JourneyId.J_1130,
});

class SupplierInfo {
  int? id;
  SupplierInfoName? name;
  dynamic code;

  SupplierInfo({this.id, this.name, this.code});

  factory SupplierInfo.fromJson(Map<String, dynamic> json) => SupplierInfo(
    id: json["Id"],
    name: supplierInfoNameValues.map[json["Name"]]!,
    code: json["Code"],
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Name": supplierInfoNameValues.reverse[name],
    "Code": code,
  };
}

enum SupplierInfoName { GALIELO_UAPI_REST }

final supplierInfoNameValues = EnumValues({
  "GalieloUAPIRest": SupplierInfoName.GALIELO_UAPI_REST,
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
