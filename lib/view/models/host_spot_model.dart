import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/crime_category_enums.dart';
import 'crime_model.dart';

class HotSpotModel {
  String id = "";
  String title = "";
  BitmapDescriptor? pinIcon;
  CrimeCategoryEnums categoryEnums = CrimeCategoryEnums.kTHEFT;
  LocationModel locationModel = LocationModel.empty();

  HotSpotModel.empty();

  HotSpotModel.fromJson(Map<String,dynamic> json) {
    id = json['id'] ?? json['_id'] ?? id;
    title = json['title'] ?? title;
    locationModel = LocationModel.fromJson(json["location"]);
    if(json["crimeType"] is String) {
      categoryEnums = json["crimeType"].toString().convertToType();
    }
  }

  @override
  String toString() {
    return 'HotSpotModel{id: $id, title: $title, pinIcon: $pinIcon, categoryEnums: $categoryEnums, locationModel: $locationModel}';
  }
}