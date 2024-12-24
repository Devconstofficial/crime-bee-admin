import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class UserController extends GetxController {
  var selectedCrimeType = ''.obs;

  final List<Map<String, dynamic>> allUsers = [
    {"id": "00001", "name": "Christine Brooks", "reports": 35, "status": "Suspended","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"id": "00002", "name": "Rosie Pearson", "reports": 33, "status": "Active","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"id": "00003", "name": "Darrell Caldwell", "reports": 31, "status": "Ban","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"id": "00004", "name": "Gilbert Johnston", "reports": 29, "status": "Ban","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"id": "00005", "name": "Alan Cain", "reports": 28, "status": "Active","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"id": "00006", "name": "Alfred Murray", "reports": 21, "status": "Suspended","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"id": "00007", "name": "Bryan Ross", "reports": 24, "status": "Active","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"id": "00008", "name": "Jessica Cook", "reports": 30, "status": "Suspended","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"id": "00009", "name": "Linda Diaz", "reports": 26, "status": "Ban","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"id": "00010", "name": "Matthew Fisher", "reports": 25, "status": "Active","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"id": "00011", "name": "Theresa Phillips", "reports": 27, "status": "Suspended","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"id": "00012", "name": "Charles Moore", "reports": 20, "status": "Ban","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"id": "00013", "name": "Jennifer White", "reports": 29, "status": "Active","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
  ];

  final int itemsPerPage = 7;

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