import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class TermsController extends GetxController{
  var isNotificationVisible = false.obs;
  var selectedIndex = 0.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var isEditing = false.obs;
  var termsText = ''.obs;
  RxBool hasText = false.obs;

  // Method to toggle the editing state
  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }

  void fetchNotifications() {
    notifications.addAll([
      {'title': 'New Host registered', 'time': '59 minutes ago', "backColor" : kPrimaryColor,},
      {'title': 'New Crime Reported', 'time': '1 hour ago',"backColor" : kOrangeColor,},
      {'title': 'Crime Resolved', 'time': '2 hours ago',"backColor" : kLightBlue,},
      {'title': 'Update on your case', 'time': '3 hours ago',"backColor" : kGrey,},
    ]);
  }

  void fetchActivities() {
    activities.addAll([
      {'title': 'Ahmad just cancelled his...', 'time': 'Just now',"backColor" : kPrimaryColor,},
      {'title': 'John updated the crime report...', 'time': '5 minutes ago',"backColor" : kOrangeColor,},
      {'title': 'Jane resolved a case', 'time': '10 minutes ago',"backColor" : kLightBlue,},
      {'title': 'System generated report', 'time': '1 hour ago',"backColor" : kGrey,},
    ]);
  }

  @override
  onInit(){
    super.onInit();
    fetchNotifications();
    fetchActivities();
  }


  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
  }

}