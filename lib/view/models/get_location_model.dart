class GetLocationModel {
  double lat=0.0;
  double lng=0.0;
  String location="";

  GetLocationModel.empty();


  @override
  String toString() {
    return 'GetLocationModel{lat: $lat, lng: $lng, location: $location}';
  }
}