import 'package:feelmeweb/data/models/response/address_dto.dart';
import 'package:feelmeweb/data/models/response/aroma_response.dart';
import 'package:feelmeweb/data/models/response/device_response.dart';

class ChecklistResponse {
  final String id;
  final AddressDTO? address;
  final DeviceResponse device;
  final AromaResponse? checklistAroma;
  final DateTime? createdAt;

  const ChecklistResponse({
    required this.id,
    this.address,
    required this.device,
    this.checklistAroma,
    this.createdAt,
  });
}
