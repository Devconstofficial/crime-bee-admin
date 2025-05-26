import 'package:crime_bee_admin/web_services/web_urls.dart';
import 'http_request_client.dart';

class SubscriptionService {
  SubscriptionService._();

  static final SubscriptionService _instance = SubscriptionService._();

  factory SubscriptionService() {
    return _instance;
  }

  final HTTPRequestClient _client = HTTPRequestClient();

  Future<dynamic> getSubscriptions({int page = 1, int limit = 7}) async {
    final responseModel = await _client.customRequest(
      'GET',
      url: "${WebUrls.kGetSubscriptionsUrl}?page=$page&limit=$limit",
      isBearerHeaderRequired: true,
    );


    if (responseModel.statusCode >= 200 && responseModel.statusCode <= 230) {
      final data = responseModel.data["data"];
      // log("getSubscriptions==================> ${data["subscriptions"]["subscriptions"]}");

      return {
        "subscriptions": data["subscriptions"]["subscriptions"],
        "totalPages": data["subscriptions"]["totalPages"],
        "currentPage": data["subscriptions"]["currentPage"],
      };
    }

    return {
      "error": responseModel.data["message"] ?? responseModel.statusDescription
    };
  }

}
