import 'package:crime_bee_admin/view/models/user_model.dart';
import 'package:crime_bee_admin/web_services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class UserController extends GetxController {
  final UserService _userService = UserService();
  RxString selectedUserStatus = ''.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  RxList<UserModel> users = RxList<UserModel>();
  RxInt currentPage = 1.obs,totalPages=1.obs;
  Set<String> selectedFilters = <String>{};
  RxBool isNotificationVisible = false.obs,
      isUserLoading = false.obs,
      isSetUpdate = false.obs,
      isTableUpdate = false.obs;

  void getUserList() async {
    if(isUserLoading.value) return;
    isUserLoading.value = true;
    var result = await _userService.getUsers(pageNo: currentPage.value,);
    if(result is List<UserModel>) {
      if(result.isEmpty) {
        totalPages.value =result.first.totalPage;
        currentPage.value =result.first.currentPage;
      }
      users.clear();
      users.addAll(result);
    } else {
      Get.snackbar('Error', result.toString(),);
    }
    isUserLoading.value = false;
  }

  Future<void> deleteUser({required String userId}) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    var result = await _userService.deleteUser(userId: userId,);
    Get.back();
    if(result is bool) {
      // user delete
      users.removeWhere((test)=>test.userId==userId,);
      isTableUpdate.toggle();
    } else {
      Get.snackbar('Error', result.toString(),);
    }
    isUserLoading.value = false;
  }

  Future<void> changeStatus({required String userId}) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    var result = await _userService.changeStatus(userId: userId,status: selectedUserStatus.toLowerCase(),);
    Get.back();
    if(result is bool) {
      // user status changed
      int index = users.indexWhere((test)=>test.userId==userId,);
      if(index>=0) {
        final user = users[index];
        users[index] = user..status = selectedUserStatus.toLowerCase();
      }
      isTableUpdate.toggle();
    } else {
      Get.snackbar('Error', result.toString(),);
    }
    isUserLoading.value = false;
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter.toLowerCase())) {
      selectedFilters.remove(filter.toLowerCase());
    } else {
      selectedFilters.add(filter.toLowerCase());
    }
    isSetUpdate.toggle();
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
  void onInit(){
    super.onInit();
    getUserList();
    fetchNotifications();
    fetchActivities();
  }

  void changePage(int pageNumber) {
    if(isUserLoading.value)return;
    if (pageNumber > 0 && pageNumber <= totalPages.value) {
      currentPage.value = pageNumber;
      getUserList();
    }
  }

  void goToPreviousPage() {
    if(isUserLoading.value)return;
    if(currentPage.value<=3)return;
    currentPage.value -= 1;
    getUserList();

  }

  void goToNextPage() {
    if(isUserLoading.value)return;
    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
      getUserList();
    }
  }

}