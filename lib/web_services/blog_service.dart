import 'dart:developer';

import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/blog_model.dart';
import '../view/models/response_model.dart';
import 'http_request_client.dart';


class BlogService {
  BlogService._();

  static final BlogService _instance = BlogService._();

  factory BlogService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getBlogs() async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetBlogsUrl,
      isBearerHeaderRequired: true,
    );
    log("getBlogs==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final List<BlogModel> blogs = <BlogModel>[];
      if(responseModel.data["data"]["blogs"] is List) {
        for(var result in responseModel.data["data"]["blogs"]) {
          blogs.add(BlogModel.fromJson(result));
        }
      }
      return blogs;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getBlogById({required String blogId,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetBlogsUrl}/$blogId",
      isBearerHeaderRequired: true,
    );
    log("getBlogById==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return BlogModel.fromJson(responseModel.data["data"]["blog"]);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }
}