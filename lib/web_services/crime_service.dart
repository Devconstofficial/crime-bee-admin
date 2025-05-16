import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/crime_model.dart';
import '../view/models/response_model.dart';
import 'http_request_client.dart';


class CrimeService {
  CrimeService._();

  static final CrimeService _instance = CrimeService._();

  factory CrimeService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> addCrimeReport(CrimeModel crimeModel) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kAddCrimeReportUrl,
      isBearerHeaderRequired: true,
      requestBody: crimeModel.toJson(),
    );
    log("addCrimeReport==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return CrimeModel.fromJson(responseModel.data["data"]["crime"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> editCrimeReport(CrimeModel crimeModel) async {
    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: "${WebUrls.kAddCrimeReportUrl}/${crimeModel.crimeId}",
      isBearerHeaderRequired: true,
      requestBody: crimeModel.toJson(),
    );
    log("editCrimeReport==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return CrimeModel.fromJson(responseModel.data["data"]["crime"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getAllCrimes({int pageNo=1}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kAddCrimeReportUrl}?page=$pageNo",
      isBearerHeaderRequired: true,
    );
    log("getAllCrimes==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<CrimeModel> crime = <CrimeModel>[];
      if(responseModel.data["data"]["crimes"] is List) {
        for(var result in responseModel.data["data"]["crimes"]) {
          CrimeModel crimeModel = CrimeModel.fromJson(result)
            ..totalPage = responseModel.data["data"]["totalPages"]
            ..currentPage = responseModel.data["data"]["currentPage"];
          // crimeModel.pinIcon = await CommonCode.loadPin(crimeModel.crimeType);
          crime.add(crimeModel);
        }
      }
      log("=======>${crime.length}");
      return crime;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getCrimeById({required String crimeId}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kAddCrimeReportUrl}/$crimeId",
      isBearerHeaderRequired: true,
    );
    log("getCrimeById==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return CrimeModel.fromJson(responseModel.data['data']['crime'] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> deleteCrimeById({required String crimeId}) async {
    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kAddCrimeReportUrl}/$crimeId",
      isBearerHeaderRequired: true,
    );
    log("deleteCrimeById==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

}