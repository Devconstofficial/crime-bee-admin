import 'dart:developer';

import 'package:crime_bee_admin/view/models/notification_model.dart';
import 'package:crime_bee_admin/web_services/web_urls.dart';

import '../view/models/response_model.dart';
import 'http_request_client.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService _instance = NotificationService._();

  factory NotificationService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getNotifications({int pageNo = 1}) async {
    ResponseModel responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetUpcomingNotificationsUrl}?page=$pageNo",
      isBearerHeaderRequired: true,
    );
    log("getNotifications==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      List<NotificationModel> notifications = <NotificationModel>[];
      if(responseModel.data["data"]["upcomingNotifications"] is List) {
        for(var result in responseModel.data["data"]["upcomingNotifications"]) {
          notifications.add(
            NotificationModel.fromJson(result)
              ..currentPage = responseModel.data["data"]["currentPage"]
              ..totalPage = responseModel.data["data"]["totalPages"],
          );
        }
      }
      return notifications;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> addNewNotification({required NotificationModel notification,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'Post',
      url: WebUrls.kGetUpcomingNotificationsUrl,
      isBearerHeaderRequired: true,
      requestBody: notification.toJson(),
    );
    log("addNewNotification==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return NotificationModel.fromJson(responseModel.data["data"]["upcomingNotification"]);
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }

  Future<dynamic> deleteNotification({required String notificationId,}) async {
    ResponseModel responseModel = await _client.customRequest(
      'DELETE',
      url: "${WebUrls.kGetUpcomingNotificationsUrl}/$notificationId",
      isBearerHeaderRequired: true,
    );
    log("deleteNotification==================> $responseModel");
    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      return true;
    }
    return responseModel.data["message"] ?? responseModel.statusDescription;
  }


  // Future<dynamic> setNotificationsToken({
  //   required String notificationId,
  // }) async {
  //   ResponseModel responseModel = await _client.customRequest(
  //     'POST',
  //     url: WebUrls.kAddNotificationTokenUrl,
  //     requestBody: {
  //       "notificationId" : notificationId,
  //     },
  //     isBearerHeaderRequired: true,
  //   );
  //   log("setNotificationsToken==================> $responseModel");
  //   if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
  //     return true;
  //   }
  //   return responseModel.data["message"] ?? responseModel.statusDescription;
  // }


  // Future<String?> getFCMToken() async {
  //   if (Platform.isIOS) {
  //     // Ensure the APNs token is available before getting the FCM token
  //     String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  //     if (apnsToken == null) {
  //       log("APNS token is not yet set. Please ensure push notifications are enabled.");
  //       return null;
  //     }
  //   }
  //
  //   // Fetch the FCM token (for both iOS and Android)
  //   final value = await FirebaseMessaging.instance.getToken();
  //   if (value != null) {
  //     log("Device Notification Token: $value");
  //     return value;
  //   }
  //   return null;
  // }
  //
  // void deleteNotificationToken() async {
  //   await FirebaseMessaging.instance.deleteToken();
  // }
}