import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class NotificationController extends GetxController {
  var selectedNotiType = ''.obs;
  var allUserType = ''.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var isNotificationVisible = false.obs;
  var selectedFilters = <String>{}.obs;


  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
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

  final List<Map<String, dynamic>> allUsers = [
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
    {"userType": "All", "Type": "Crime Alert", "date": "07/12/2024","title" : "New High-Risk"},
  ];

  final int itemsPerPage = 5;

  final RxInt currentPage = 1.obs;

  List<Map<String, dynamic>> get currentPageUsers {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return allUsers.sublist(
      startIndex,
      endIndex > allUsers.length ? allUsers.length : endIndex,
    );
  }

  int get totalPages => (allUsers.length / itemsPerPage).ceil();

  void changePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= totalPages) {
      currentPage.value = pageNumber;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value -= 1;
    }
  }

  // Next button functionality
  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value += 1;
    }
  }

  // Check if back button should be disabled
  bool get isBackButtonDisabled => currentPage.value == 1;

  // Check if next button should be disabled
  bool get isNextButtonDisabled => currentPage.value == totalPages;
}