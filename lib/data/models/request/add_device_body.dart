class AddDeviceBody {
  final String? deviceId;
  final String? customerId;
  final String? modelId;
  final String? powerId;
  final String? addressId;

  AddDeviceBody({
    this.deviceId,
    this.customerId,
    this.modelId,
    this.powerId,
    this.addressId,
  });

  AddDeviceBody copyWith({
    String? deviceId,
    String? customerId,
    String? modelId,
    String? powerId,
    String? addressId,
  }) {
    return AddDeviceBody(
      deviceId: deviceId ?? this.deviceId,
      customerId: customerId ?? this.customerId,
      modelId: modelId ?? this.modelId,
      powerId: powerId ?? this.powerId,
      addressId: addressId ?? this.addressId,
    );
  }

  Map<String, dynamic> toJson() => {
        'deviceId': deviceId,
        'customerId': customerId,
        'modelId': modelId,
        'powerId': powerId,
        'addressId': addressId
      };
}
