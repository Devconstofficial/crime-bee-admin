import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../view/models/response_model.dart';
import 'http_request_client.dart';

class LocationService {
  LocationService._();

  static final LocationService  _instance = LocationService._();

  factory LocationService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getPlaceUsingLATLNG({required double lat,required double lng,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGeoPlaceApiUrl(lat: lat, lng: lng),
    );
    log("getPlaceUsingLATLNG==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      String address = "";
      final data = responseModel.data;
      if(data["status"] == "OK" && data["results"].isNotEmpty) {
        address = data["results"][0]["formatted_address"];
      }
      return "Success:$address";
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> searchPlaceApi({required String address}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kSearchPlaceApiUrl(placeAddress: address,),
    );
    log("searchPlaceApi==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data;
      double latitude = data["results"][0]["geometry"]["location"]["lat"];
      double longitude = data["results"][0]["geometry"]["location"]["lng"];
      return LatLng(latitude, longitude);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

}