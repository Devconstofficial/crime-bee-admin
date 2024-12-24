import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class BlogController extends GetxController {
  var selectedBlogType = ''.obs;
  var selectedBlogStatus = ''.obs;

  final List<Map<String, dynamic>> allBlogs = [
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "ABC", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
  ];

  final List<Map<String, dynamic>> allUserBlogs = [
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Approved","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Pending","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Approved","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Pending","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},

  ];

  final int itemsPerPage = 3;
  final int userBlogsPerPage = 3;

  final RxInt currentPage = 1.obs;
  final RxInt userBlogsCurrentPage = 1.obs;

  List<Map<String, dynamic>> get currentPageUsers {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return allBlogs.sublist(
      startIndex,
      endIndex > allBlogs.length ? allBlogs.length : endIndex,
    );
  }

  List<Map<String, dynamic>> get userBlogsCurrentPageUsers {
    final startIndex = (userBlogsCurrentPage.value - 1) * userBlogsPerPage;
    final endIndex = startIndex + userBlogsPerPage;
    return allUserBlogs.sublist(
      startIndex,
      endIndex > allUserBlogs.length ? allUserBlogs.length : endIndex,
    );
  }

  int get totalPages => (allBlogs.length / itemsPerPage).ceil();
  int get userBlogTotalPages => (allUserBlogs.length / userBlogsPerPage).ceil();

  void changePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= totalPages) {
      currentPage.value = pageNumber;
    }
  }

  void userBlogChangePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= userBlogTotalPages) {
      userBlogsCurrentPage.value = pageNumber;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value -= 1;
    }
  }

  void goToPreviousPage1() {
    if (userBlogsCurrentPage.value > 1) {
      userBlogsCurrentPage.value -= 1;
    }
  }

  // Next button functionality
  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value += 1;
    }
  }

  void goToNextPage1() {
    if (userBlogsCurrentPage.value < userBlogTotalPages) {
      userBlogsCurrentPage.value += 1;
    }
  }

  // Check if back button should be disabled
  bool get isBackButtonDisabled => currentPage.value == 1;

  bool get isBackButtonDisabled1 => userBlogsCurrentPage.value == 1;

  // Check if next button should be disabled
  bool get isNextButtonDisabled => currentPage.value == totalPages;
  bool get isNextButtonDisabled1 => userBlogsCurrentPage.value == userBlogTotalPages;
}