import 'package:crime_bee_admin/view/screens/blogs_screen/controller/blog_controller.dart';
import 'package:crime_bee_admin/view/screens/notification_screen/controller/notification_controller.dart';
import 'package:get/get.dart';

import '../view/screens/add_crime_screen/controller/add_crime_controller.dart';
import '../view/screens/auth_screen/controller/auth_controller.dart';
import '../view/screens/comment_screen/controller/comment_controller.dart';
import '../view/screens/dashboard/controller/dashboard_controller.dart';
import '../view/screens/subscription_screen/controller/subcription_controller.dart';
import '../view/screens/terms_policies_screen/controller/terms_screen.dart';
import '../view/screens/user_screen/controller/user_controller.dart';


class ScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => AddCrimeController());
    Get.lazyPut(() => SubscriptionController());
    Get.lazyPut(() => CommentController());
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => BlogController());
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => TermsController());
  }
}
