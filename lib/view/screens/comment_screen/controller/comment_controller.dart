import 'package:crime_bee_admin/web_services/comment_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import '../../../models/comment_model.dart';


class CommentController extends GetxController {
  final CommentService _commentService = CommentService();
  final TextEditingController commentController = TextEditingController();
  final TextEditingController threadController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController joinedController = TextEditingController();
  final TextEditingController contributionsController = TextEditingController();
  final TextEditingController flaggedCommentController = TextEditingController();
  RxList notifications = [].obs;
  RxList activities = [].obs;
  RxInt currentPage = 1.obs,totalPages = 1.obs;
  Set<String> selectedFilters = <String>{};
  RxBool isNotificationVisible = false.obs,
      isDataLoading = false.obs,
      isFiltersUpdated = false.obs,
      isTableUpdate = false.obs;
  RxList<CommentModel> comments = RxList<CommentModel>();
  CommentModel selectedComment = CommentModel.empty();
  List<CommentModel> filteredComments() {
    if(selectedFilters.contains('Last 30 days'.toLowerCase())) {
      final previousDate = DateTime.now().subtract(const Duration(days: 30));
      return comments.where((test) {
        return DateTime.parse(test.createdAt).isAfter(previousDate);
      }).toList();
    } else if(selectedFilters.contains('Last 7 days'.toLowerCase())) {
      final previousDate = DateTime.now().subtract(const Duration(days: 7));
      return comments.where((test) {
        return DateTime.parse(test.createdAt).isAfter(previousDate);
      }).toList();
    }
    return comments;
  }

  void getComments() async {
    if(isDataLoading.value) return;
    isDataLoading.value = true;
    var result = await _commentService.getComments(pageNo: currentPage.value);
    if(result is List<CommentModel>) {
      comments.clear();
      comments.addAll(result);
      if(comments.isNotEmpty) {
        totalPages.value=comments.first.totalPage;
        currentPage.value=comments.first.currentPage;
      }
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
    isDataLoading.value = false;
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter.toLowerCase())) {
      selectedFilters.remove(filter.toLowerCase());
    } else {
      selectedFilters.add(filter.toLowerCase());
    }
    filteredComments();
    isFiltersUpdated.toggle();
  }

  void seeCommentDetails(CommentModel commentModel) {
    selectedComment = commentModel;
    commentController.text = selectedComment.text;
    threadController.text = selectedComment.postId;
    usernameController.text = selectedComment.commentedBy.name;
    joinedController.text = selectedComment.commentedBy.createdAt.isEmpty? "Unavailable" : DateFormat("dd-MMM-yyyy").format(DateTime.parse(selectedComment.commentedBy.createdAt));
    contributionsController.text = "${selectedComment.commentedBy.vigilantePoints}";
    flaggedCommentController.text = selectedComment.commentId;
  }

  Future<void> deleteComment({required String commentId}) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    var result = await _commentService.deleteComment(commentId: commentId,);
    Get.back();
    if(result is bool) {
      // user delete
      comments.removeWhere((test)=>test.commentId==commentId,);
      isTableUpdate.toggle();
    } else {
      Get.snackbar('Error', result.toString(),);
    }
    isDataLoading.value = false;
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
  void onInit() {
    super.onInit();
    getComments();
    fetchNotifications();
    fetchActivities();
  }


  void changePage(int pageNumber) {
    if(isDataLoading.value)return;
    if (pageNumber > 0 && pageNumber <= totalPages.value) {
      currentPage.value = pageNumber;
      getComments();
    }
  }

  void goToPreviousPage() {
    if(isDataLoading.value)return;
    if(currentPage.value<=3)return;
    currentPage.value -= 1;
    getComments();

  }

  void goToNextPage() {
    if(isDataLoading.value)return;
    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
      getComments();
    }
  }
}