import 'package:easy_localization/easy_localization.dart';
import 'package:feelmeweb/data/models/response/local_date.dart';
import 'package:feelmeweb/data/models/response/local_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'checklist_info_response.g.dart';

@JsonSerializable()
class CheckListInfoResponse {
  final String? id;
  final DateTime? createdAt;

  final String? pdfUrl;
  final Customer? customer;
  final Address? address; // New address field

  CheckListInfoResponse({
    this.id,
    this.createdAt,
    this.pdfUrl,
    this.customer,
    this.address, // Address in constructor
  });

  factory CheckListInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckListInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CheckListInfoResponseToJson(this);
}

@JsonSerializable()
class Address {
  final String id;
  final String customerId;
  final String address;
  final double lat;
  final double lng;

  Address({
    required this.id,
    required this.customerId,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class LocalDateTime {
  final LocalDate date;
  final LocalTime? time;

  LocalDateTime({required this.date, this.time});

  factory LocalDateTime.fromJson(Map<String, dynamic> json) =>
      _$LocalDateTimeFromJson(json);

  String? toDateTime() {
    return DateFormat('dd.MM.yyyy')
        .format(DateTime(date.year, date.month, date.day));
  }

  Map<String, dynamic> toJson() => _$LocalDateTimeToJson(this);
}

@JsonSerializable()
class Customer {
  final String? id;
  final String? name;
  final String? phone;
  final String? ownerName;
  final List<String>? devices;
  final List<String>? addresses;

  Customer({
    this.id,
    this.name,
    this.phone,
    this.ownerName,
    this.devices,
    this.addresses,
  });

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
  Map<String, dynamic> toJson() => _$CustomerToJson(this);
}
