
import 'package:crime_bee_admin/view/models/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../utils/crime_category_enums.dart';
import 'comment_model.dart';

class CrimeModel {
  String crimeId = "";
  CrimeCategoryEnums crimeType = CrimeCategoryEnums.kTHEFT;
  String location = "";
  double lat = 0.0;
  double lng = 0.0;
  String dateTime = DateTime.now().toIso8601String();
  String description = "";
  String severity = "high";
  UserModel reportedBy = UserModel.empty();
  String reportedByID = "";
  LocationModel locationModel = LocationModel.empty();
  List<String> likes = <String>[];
  int views = 0;
  List<String> commentsId = <String>[];
  List<CommentModel> comments = <CommentModel>[];
  BitmapDescriptor? pinIcon;
  int totalPage=0;
  int currentPage=0;

  CrimeModel.empty();

  CrimeModel.fromJson(Map<String,dynamic> json) {
    crimeId = json["_id"] ?? json["id"] ?? crimeId;
    if(json["crimeType"] is String) {
      crimeType = json["crimeType"].toString().convertToType();
    }
    location = json["locationName"] ?? location;
    lat = json["lat"] ?? lat;
    lng = json["lng"] ?? lng;
    dateTime = json["time"] ?? dateTime;
    description = json["description"] ?? description;
    severity = json["severity"] ?? severity;
    if(json["location"]!=null) {
      locationModel = LocationModel.fromJson(json["location"] ?? {});
    }
    if(json["reportedBy"]!=null) {
      // if(json["reportedBy"] is Map<String,dynamic>) {
      //   reportedBy = UserModel.fromJson(json["reportedBy"] ?? {});
      // }
      if(json["reportedBy"] is String) {
        reportedByID = json["reportedBy"] ?? reportedByID;
      }
    }
    if(json["likes"] is List) {
      for(var result in json["likes"]) {
        likes.add(result.toString());
      }
    }
    views = json["views"] ?? views;
    if(json["comments"] is List) {
      for(var result in json["comments"]) {
        if(result is Map<String,dynamic>) {
          comments.add(CommentModel.fromJson(result));
        } else if(result is String) {
          commentsId.add(result);
        }
      }
    }
  }

  Map<String,dynamic> toJson() {
    return {
      "crimeType" : crimeType.convertToString(),
      "locationName" : location,
      "location" : locationModel.toJson(),
      "time" : dateTime,
      "description" : description,
      "severity" : severity,
    };
  }

  @override
  String toString() {
    return 'CrimeModel{crimeId: $crimeId, crimeType: $crimeType, location: $location, lat: $lat, lng: $lng, dateTime: $dateTime, description: $description, severity: $severity, reportedByID: $reportedByID, locationModel: $locationModel, likes: $likes, views: $views, commentsId: $commentsId, comments: $comments, pinIcon: $pinIcon, totalPage: $totalPage, currentPage: $currentPage}';
  }
}

class LocationModel {
  String type = "";
  double lat= 0.0;
  double lng= 0.0;

  LocationModel.empty();

  LocationModel.fromJson(Map<String,dynamic> json) {
    type = json["type"] ?? type;
    if(json["coordinates"] is List) {
      for(int index=0;index<json["coordinates"].length;index++) {
        if(index==0) {
          lng = json["coordinates"][0];
        }
        if(index==1) {
          lat = json["coordinates"][1];
        }
      }
    }
  }

  Map<String,dynamic> toJson() {
    return {
      "type" : type,
      "coordinates" : [
        lng,
        lat
      ],
    };
  }

  @override
  String toString() {
    return 'LocationModel{type: $type, lat: $lat, lng: $lng}';
  }
}