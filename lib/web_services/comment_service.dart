import 'dart:developer';


import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/comment_model.dart';
import '../view/models/response_model.dart';
import 'http_request_client.dart';

class CommentService {
  CommentService._();

  static final CommentService _instance = CommentService._();

  factory CommentService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getComments({required int pageNo,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kAddCommentLikeUrl}?flagged=false&page=$pageNo",
      isBearerHeaderRequired: true,
    );
    log("getComments==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final List<CommentModel> replies = <CommentModel>[];
      if(responseModel.data["data"]["comments"] is List) {
        for (var result in responseModel.data["data"]["comments"]) {
          replies.add(CommentModel.fromJson(result)
            ..totalPage = responseModel.data["data"]["totalPages"]
            ..currentPage = responseModel.data["data"]["currentPage"]);
        }
      }
      return replies;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> deleteComment({required String commentId,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kAddCommentLikeUrl}/$commentId",
      isBearerHeaderRequired: true,
    );
    log("deleteUser==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

}
