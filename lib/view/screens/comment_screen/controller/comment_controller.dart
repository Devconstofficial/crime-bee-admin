import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class CommentController extends GetxController {
  TextEditingController commentController = TextEditingController(text: 'Suspicious activity reported near the station at 9 PM.');
  TextEditingController threadController = TextEditingController(text: '#12345');
  TextEditingController usernameController = TextEditingController(text: 'Night Claw');
  TextEditingController joinedController = TextEditingController(text: '10/05/2024');
  TextEditingController contributionsController = TextEditingController(text: '34 posts, 56 comments');
  TextEditingController flaggedCommentController = TextEditingController(text: '2');
  final List<Map<String, dynamic>> allUsers = [
    {"User": "00001", "Comment": "Christine Brooks", "PostId": '00001', "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00002", "Comment": "Rosie Pearson", "PostId": '00002', "Date & Time": "Dec 6, 2024, 10:45 AM",},
    {"User": "00003", "Comment": "Darrell Caldwell", "PostId": '00003', "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00004", "Comment": "Gilbert Johnston", "PostId": '00004', "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00005", "Comment": "Alan Cain", "PostId": "00005", "Date & Time": "Dec 6, 2024, 10:45 AM",},
    {"User": "00006", "Comment": "Alfred Murray", "PostId": "00006", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00007", "Comment": "Bryan Ross", "PostId": "00007", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00008", "Comment": "Jessica Cook", "PostId": "00008", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00009", "Comment": "Linda Diaz", "PostId": "00009", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00010", "Comment": "Matthew Fisher", "PostId": "000010", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00011", "Comment": "Theresa Phillips", "PostId": "000011", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00012", "Comment": "Charles Moore", "PostId": "000012", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"User": "00013", "Comment": "Jennifer White", "PostId": "000013", "Date & Time": "Dec 6, 2024, 10:45 AM"},
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