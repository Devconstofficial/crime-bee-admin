import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class SubscriptionController extends GetxController {
  final List<Map<String, dynamic>> allUsers = [
    {"userId": "00001", "name": "Christine Brooks", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00002", "name": "Rosie Pearson", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00003", "name": "Darrell Caldwell", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00004", "name": "Gilbert Johnston", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00005", "name": "Alan Cain", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00006", "name": "Alfred Murray", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00007", "name": "Bryan Ross", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00008", "name": "Jessica Cook", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00009", "name": "Linda Diaz", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00010", "name": "Matthew Fisher", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00011", "name": "Theresa Phillips", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00012", "name": "Charles Moore", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00013", "name": "Jennifer White", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
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