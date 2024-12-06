
class AddDeviceBody {
  final String deviceId;
  final String customerId;
  final String modelId;
  final String powerId;
  final String addressId;

  AddDeviceBody({
    required this.deviceId,
    required this.customerId,
    required this.modelId,
    required this.powerId,
    required this.addressId,
  });

  Map<String, dynamic> toJson() => {
    'deviceId': deviceId,
    'customerId': customerId,
    'modelId': modelId,
    'powerId': powerId,
    'addressId': addressId
  };
}