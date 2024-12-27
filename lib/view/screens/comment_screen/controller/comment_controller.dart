import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../models/comment_model.dart';


class CommentController extends GetxController {
  TextEditingController commentController = TextEditingController(text: 'Suspicious activity reported near the station at 9 PM.');
  TextEditingController threadController = TextEditingController(text: '#12345');
  TextEditingController usernameController = TextEditingController(text: 'Night Claw');
  TextEditingController joinedController = TextEditingController(text: '10/05/2024');
  TextEditingController contributionsController = TextEditingController(text: '34 posts, 56 comments');
  TextEditingController flaggedCommentController = TextEditingController(text: '2');
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedFilters = <String>{}.obs;
  var isNotificationVisible = false.obs;
  late GoogleMapController mapController;

  var comments = <CommentModel>[].obs;

  List<Map<String, dynamic>> demoCommentsJson = [
    {
      "username": "John Doe",
      "content": "This is a demo comment!",
      "likes": 10,
      "isLiked": false,
      "image": kUserLogo,
    },
    {
      "username": "Jane Smith",
      "content": "I totally agree with this.",
      "likes": 25,
      "isLiked": true,
      "image": kUserLogo,
    },
    {
      "username": "Alex Johnson",
      "content": "I totally agree with this.",
      "likes": 15,
      "isLiked": false,
      "image": kUserLogo,
    },
  ];

  void loadDemoComments() {
    comments.addAll(
      demoCommentsJson.map((json) => CommentModel.fromJson(json)).toList(),
    );
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
    loadDemoComments();
  }

  final List<Map<String, dynamic>> allUsers = [
    {"User": "JohnD", "Comment": "Suspicious activity near...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM"},
    {"User": "JaneSmith", "Comment": "This is untrue; please clarify...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JohnD", "Comment": "Suspicious activity near...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JaneSmith", "Comment": "This is untrue; please clarify...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JohnD", "Comment": "Suspicious activity near...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JaneSmith", "Comment": "This is untrue; please clarify...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JaneSmith", "Comment": "This is untrue; please clarify...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
    {"User": "JohnD", "Comment": "Suspicious activity near...", "PostId": '12345', "Date & Time": "07/12/2024 09:30 AM",},
  ];

  final int itemsPerPage = 4;

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