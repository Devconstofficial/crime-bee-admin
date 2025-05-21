import 'dart:developer';

import 'package:crime_bee_admin/view/models/monthly_crime_chart_model.dart';
import 'package:crime_bee_admin/web_services/web_urls.dart';
import '../view/models/response_model.dart';
import 'http_request_client.dart';

class DashboardServices {
  DashboardServices._();

  static final DashboardServices _instance = DashboardServices._();

  factory DashboardServices() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getUserStats() async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: WebUrls.kGetUserStatsUrl,
      isBearerHeaderRequired: true,
    );

    log("getUserStats==================> $responseModel");

    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final statsData = responseModel.data["data"]["stats"];
      return statsData;
    }

    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> getRevenue({String type = "weekly"}) async {
    try {
      ResponseModel responseModel = await _client.customRequest(
        'GET',
        url: "${WebUrls.kGetRevenueUrl}?type=$type",
        isBearerHeaderRequired: true,
      );

      log("getRevenue $type ==================> $responseModel");

      if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
        final List<Map<String, dynamic>> revenues = [];

        if (responseModel.data["data"]["revenue"] is List) {
          for (var item in responseModel.data["data"]["revenue"]) {
            revenues.add(
                {"date": item["_id"], "totalRevenue": item["totalRevenue"]});
          }
        }

        return revenues;
      }

      return responseModel.data["message"] ?? responseModel.statusDescription;
    } catch (e) {
      log("getRevenue error: $e");
      return "An error occurred while fetching revenue";
    }
  }

  Future<MonthlyStatsModel?> getMonthlyStats() async {
    try {
      ResponseModel responseModel = await _client.customRequest(
        'GET',
        url: WebUrls.kGetMonthlyStatsUrl,
        isBearerHeaderRequired: true,
      );

      log("getMonthlyStats ==================> $responseModel");

      if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
        final statsData = responseModel.data["data"]["stats"];
        return MonthlyStatsModel.fromJson(statsData);
      }

      return null;
    } catch (e) {
      log("getMonthlyStats error: $e");
      return null;
    }
  }

  Future<MonthlyStatsModel?> getYearlyStats() async {
    try {
      ResponseModel responseModel = await _client.customRequest(
        'GET',
        url: WebUrls.kGetYearlyStatsUrl,
        isBearerHeaderRequired: true,
      );

      log("getYearlyStats ==================> $responseModel");

      if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
        final statsData = responseModel.data["data"]["stats"];
        return MonthlyStatsModel.fromJson(statsData);
      }

      return null;
    } catch (e) {
      log("getYearlyStats error: $e");
      return null;
    }
  }
}
