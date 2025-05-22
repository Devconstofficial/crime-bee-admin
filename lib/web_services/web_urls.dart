class WebUrls extends _BaseUrl {
  WebUrls._();

  //Auth Module
  static const String kSignInUrl = "${_BaseUrl._kBaseUrl}/auth/signin";

  // Crime Module
  static const String kAddCrimeReportUrl = "${_BaseUrl._kBaseUrl}/admin/crimes";

  // Notification Module
  static const String kGetUpcomingNotificationsUrl = "${_BaseUrl._kBaseUrl}/admin/notifications/upcoming";

  // comment Module
  static const String kAddCommentLikeUrl = "${_BaseUrl._kBaseUrl}/admin/comments";

  // terms service
  static const String kPrivacyPolicyUrl = "${_BaseUrl._kBaseUrl}/admin/policies/privacy-policy";
  static const String kTermsOfServiceUrl = "${_BaseUrl._kBaseUrl}/admin/policies/terms-of-services";
  static const String kCookiesPolicesUrl = "${_BaseUrl._kBaseUrl}/admin/policies/cookies-policies";

  // Blog Service
  static const String kGetBlogsUrl = "${_BaseUrl._kBaseUrl}/user/blogs";
  static const String kGetUserBlogsUrl = "${_BaseUrl._kBaseUrl}/admin/blogs/user";
  static const String kGetAdminBlogsUrl = "${_BaseUrl._kBaseUrl}/admin/blogs/admin";
  static const String kCreateBlogByAdminUrl = '${_BaseUrl._kBaseUrl}/admin/blogs';
  static const String kUpdateBlogByAdminUrl = '${_BaseUrl._kBaseUrl}/admin/blogs';
  static const String kApproveBlogByAdminUrl = '${_BaseUrl._kBaseUrl}/admin/blogs';
  static const String kDeleteBlogByAdminUrl = "${_BaseUrl._kBaseUrl}/admin/blogs";



  //user service
  static const String kGetUsersUrl = "${_BaseUrl._kBaseUrl}/admin/users";
  static const String kGetUserStatsUrl = "${_BaseUrl._kBaseUrl}/admin/stats/user";

  //charts
  static const String kGetRevenueUrl = '${_BaseUrl._kBaseUrl}/admin/subscriptions/revenue';
  static const String kGetMonthlyStatsUrl = '${_BaseUrl._kBaseUrl}/admin/stats/monthly';
  static const String kGetYearlyStatsUrl = '${_BaseUrl._kBaseUrl}/admin/stats/yearly';

  //subscriptions
  static const String kGetSubscriptionsUrl = '${_BaseUrl._kBaseUrl}/admin/subscriptions';

  static String kGeoPlaceApiUrl({required double lat,required double lng,}) {
    return "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=${_BaseUrl._kMapAPiKey}";
  }

  static String kSearchPlaceApiUrl({required String placeAddress,}) {
    String encodedAddress = Uri.encodeComponent(placeAddress);
    return "https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=${_BaseUrl._kMapAPiKey}";
  }

}

abstract class _BaseUrl {
  static const String _kBaseUrl = 'https://backend.nativeinitiative.org';
  static const String _kMapAPiKey = 'AIzaSyCXNn8upsCmExEMsdvskyRaQZhdzye9QsA';
  // static const String _kSocketUrl = 'https://8zpp5sr3-3000.inc1.devtunnels.ms';
  // static const String _kBaseUrl = 'https://8zpp5sr3-8000.inc1.devtunnels.ms';
}