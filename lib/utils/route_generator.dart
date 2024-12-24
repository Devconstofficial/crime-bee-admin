import 'package:crime_bee_admin/utils/screen_bindings.dart';
import 'package:crime_bee_admin/view/screens/auth_screen/login_screen.dart';
import 'package:crime_bee_admin/view/screens/comment_screen/comment_screen.dart';
import 'package:crime_bee_admin/view/screens/notification_screen/notification_screen.dart';
import 'package:crime_bee_admin/view/screens/subscription_screen/subscription_screen.dart';
import 'package:crime_bee_admin/view/screens/user_screen/user_screen.dart';
import 'package:get/get.dart';

import '../view/screens/add_crime_screen/add_crime_dashboard.dart';
import '../view/screens/add_crime_screen/add_crime_screen.dart';
import '../view/screens/blogs_screen/blog_screen.dart';
import '../view/screens/dashboard/dashboard_screen.dart';
import 'app_strings.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      GetPage(name: kDashboardScreenRoute, page: () => const DashboardScreen(), binding: ScreenBindings()),
      GetPage(name: kUserScreenRoute, page: () => const UserScreen(), binding: ScreenBindings()),
      GetPage(name: kAddCrimeDashboardRoute, page: () => AddCrimeDashboard(), binding: ScreenBindings()),
      GetPage(name: kSubscriptionScreenRoute, page: () => const SubscriptionScreen(), binding: ScreenBindings()),
      GetPage(name: kNotificationScreenRoute, page: () => const NotificationScreen(), binding: ScreenBindings()),
      GetPage(name: kCommentScreenRoute, page: () => const CommentScreen(), binding: ScreenBindings()),
      GetPage(name: kBlogScreenRoute, page: () => const BlogScreen(), binding: ScreenBindings()),
      GetPage(name: kAddCrimeScreenRoute, page: () => const AddCrimeScreen(), binding: ScreenBindings()),
      GetPage(name: kLoginScreenRoute, page: () => const LoginScreen(), binding: ScreenBindings()),
    ];
  }
}
