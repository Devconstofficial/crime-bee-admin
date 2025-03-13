import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/response_model.dart';
import '../view/models/user_model.dart';
import 'http_request_client.dart';


class UserService {
  UserService._();

  static final UserService _instance = UserService._();

  factory UserService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getUsers({int pageNo=1}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetUsersUrl}?page=$pageNo",
      isBearerHeaderRequired: true,
    );
    log("getUsers==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final List<UserModel> users = <UserModel>[];
      if(responseModel.data["data"]["users"] is List) {
        for(var result in responseModel.data["data"]["users"]) {
          users.add(
            UserModel.fromJson(result)
              ..totalPage = responseModel.data["data"]["totalPages"]
              ..currentPage = responseModel.data["data"]["currentPage"],
          );
        }
      }
      return users;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> deleteUser({required String userId,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kGetUsersUrl}/$userId",
      isBearerHeaderRequired: true,
    );
    log("deleteUser==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> changeStatus({required String userId,required String status}) async {
    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: "${WebUrls.kGetUsersUrl}/$userId/$status",
      isBearerHeaderRequired: true,
      requestBody: status=="suspend" ? {
        "time" : DateTime.now().toUtc().toIso8601String()
      } : null,
    );
    log("changeStatus==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}