import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/response_model.dart';
import '../view/models/terms_model.dart';
import 'http_request_client.dart';

class TermsService {
  TermsService._();

  static final TermsService _instance = TermsService._();

  factory TermsService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getPrivacyPolices() async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kPrivacyPolicyUrl,
      isBearerHeaderRequired: true,
    );
    log("getPrivacyPolices==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getTermAndService() async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kTermsOfServiceUrl,
      isBearerHeaderRequired: true,
    );
    log("getTermAndService==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getCookieService() async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kCookiesPolicesUrl,
      isBearerHeaderRequired: true,
    );
    log("getCookieService==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> setPrivacyPolices({required String text,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: WebUrls.kPrivacyPolicyUrl,
      requestBody: {
        "text" : text,
      },
      isBearerHeaderRequired: true,
    );
    log("setPrivacyPolices==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> setTermAndService({required String text,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: WebUrls.kTermsOfServiceUrl,
      requestBody: {
        "text" : text,
      },
      isBearerHeaderRequired: true,
    );
    log("setTermAndService==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> setCookieService({required String text}) async {
    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: WebUrls.kCookiesPolicesUrl,
      requestBody: {
        "text" : text,
      },
      isBearerHeaderRequired: true,
    );
    log("setCookieService==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return TermsModel.fromJson(responseModel.data["data"]["policy"] ?? {});
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}