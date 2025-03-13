import 'dart:convert';
import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../utils/session_management/session_management.dart';
import '../utils/session_management/session_token_keys.dart';
import '../view/models/response_model.dart';
import '../view/models/user_model.dart';
import 'http_request_client.dart';

class AuthService {
  AuthService._();

  static final AuthService _instance = AuthService._();

  factory AuthService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();
  final SessionManagement _sessionManagement = SessionManagement();

  Future<dynamic> signInUser({required String email,required String password}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kSignInUrl,
      requestBody: {
        "email": email,
        "password": password,
      },
      requestHeader: {
        'Content-Type': 'application/json',
      },
    );
    log("signInUser==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserTokenKey,
        tokenValue: responseModel.data["data"]["authToken"],
      );
      await _sessionManagement.saveSession(
        tokenKey: SessionTokenKeys.kUserModelKey,
        tokenValue: jsonEncode(responseModel.data["data"]["user"]),
      );
      return UserModel.fromJson(responseModel.data["data"]["user"]);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getUserFromSession() async {
    var result = await _sessionManagement.getSessionToken(
      tokenKey: SessionTokenKeys.kUserModelKey,
    );
    if(result.isNotEmpty) {
      return UserModel.fromJson(jsonDecode(result));
    }
  }

}