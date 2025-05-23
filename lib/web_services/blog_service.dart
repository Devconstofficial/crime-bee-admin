import 'dart:developer';

import 'package:crime_bee_admin/view/models/blog_model2.dart';
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
      if (responseModel.data["data"]["blogs"] is List) {
        for (var result in responseModel.data["data"]["blogs"]) {
          blogs.add(BlogModel.fromJson(result));
        }
      }
      return blogs;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getBlogById({
    required String blogId,
  }) async {
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

  Future<dynamic> getBlogsByUser({
    int page = 1,
    int limit = 3,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetUserBlogsUrl}?page=$page&limit=$limit",
      isBearerHeaderRequired: true,
    );

    log("getBlogsByUser==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data["data"];

      final List<BlogModel> blogs = <BlogModel>[];
      if (data["blogs"] is List) {
        for (var result in data["blogs"]) {
          blogs.add(BlogModel.fromJson(result));
        }
      }

      return {
        "blogs": blogs,
        "totalPages": data["totalPages"],
        "currentPage": data["currentPage"],
      };
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

  Future<dynamic> getBlogsByAdmin({
    int page = 1,
    int limit = 3,
  }) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetAdminBlogsUrl}?page=$page&limit=$limit",
      isBearerHeaderRequired: true,
    );

    log("getBlogsByAdmin==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data["data"];

      final List<BlogModel> blogs = <BlogModel>[];
      if (data["blogs"] is List) {
        for (var result in data["blogs"]) {
          blogs.add(BlogModel.fromJson(result));
        }
      }

      return {
        "blogs": blogs,
        "totalPages": data["totalPages"],
        "currentPage": data["currentPage"],
      };
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

  Future<dynamic> createBlogByAdmin({
    required String title,
    required String category,
    required String description,
    required String coverImage,
  }) async {
    final Map<String, dynamic> body = {
      "title": title,
      "category": category,
      "description": description,
      "coverImage": coverImage,
    };

    ResponseModel responseModel = await _client.customRequest(
      'POST',
      url: WebUrls.kCreateBlogByAdminUrl,
      requestBody: body,
      isBearerHeaderRequired: true,
    );

    log("createBlogByAdmin==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return BlogModel1.fromJson(responseModel.data["data"]["blog"]);
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

  Future<dynamic> updateBlogByAdmin({
    required String blogId,
    required String title,
    required String category,
    required String description,
    required String coverImage,
  }) async {
    final Map<String, dynamic> body = {
      "title": title,
      "category": category,
      "description": description,
      "coverImage": coverImage,
    };

    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: "${WebUrls.kUpdateBlogByAdminUrl}/$blogId",
      requestBody: body,
      isBearerHeaderRequired: true,
    );

    log("updateBlogByAdmin==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return BlogModel1.fromJson(responseModel.data["data"]["blog"]);
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

  Future<dynamic> statusBlogByAdmin({
    required String blogId,
    required String status,
  }) async {
    final Map<String, dynamic> body = {
      "blogStatus": status,
    };

    ResponseModel responseModel = await _client.customRequest(
      'PUT',
      url: "${WebUrls.kUpdateBlogByAdminUrl}/$blogId",
      requestBody: body,
      isBearerHeaderRequired: true,
    );

    log("updateBlogByAdmin==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return BlogModel1.fromJson(responseModel.data["data"]["blog"]);
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

  Future<dynamic> deleteBlogByAdmin(String blogId) async {
  ResponseModel responseModel = await _client.customRequest(
    'DELETE',
    url: "${WebUrls.kDeleteBlogByAdminUrl}/$blogId",
    isBearerHeaderRequired: true,
  );

  log("deleteBlogByAdmin==================> $responseModel");

  if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
    return responseModel.data["message"] ?? "Blog deleted successfully";
  }

  return {
    "error": responseModel.data["message"] ?? responseModel.statusDescription
  };
}

}
