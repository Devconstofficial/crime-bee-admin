class PositionModel {
  double lat = 0.0;
  double lng = 0.0;
  String address = "";

  PositionModel.empty();

  @override
  String toString() {
    return 'PositionModel{lat: $lat, lng: $lng, address: $address}';
  }
}