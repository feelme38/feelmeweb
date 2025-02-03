

class AddCustomerAddressBody {
  final String customerId;
  final String regionId;
  final String address;
  final double lat;
  final double lng;

  AddCustomerAddressBody(this.customerId, this.regionId, this.address, this.lat, this.lng);

  Map<String,dynamic> toJson() => {
    'customerId': customerId,
    'regionId': regionId,
    'address': address,
    'lat': lat,
    'lng': lng
  };
}