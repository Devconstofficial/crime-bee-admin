import 'package:crime_bee_admin/view/models/notification_model.dart';
import 'package:crime_bee_admin/web_services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService = NotificationService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController specificUserId = TextEditingController();
  RxString selectedNotificationType = ''.obs, allUserType = ''.obs;
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  RxList activities = [].obs;
  RxList rawNotifications = [].obs;
  RxBool isNotificationVisible = false.obs,
      isDataLoading = false.obs,
      isFiltersUpdated = false.obs,
      showSpecificUserField = false.obs,
      isTableUpdate = false.obs;
  Set<String> selectedFilters = <String>{};
  RxInt currentPage = 1.obs, totalPages = 1.obs;

  void getNotifications() async {
    if (isDataLoading.value) return;
    isDataLoading.value = true;
    var result = await _notificationService.getNotifications(
      pageNo: currentPage.value,
    );
    isDataLoading.value = false;
    if (result is List<NotificationModel>) {
      notifications.clear();
      notifications.addAll(result);
      if (notifications.isNotEmpty) {
        totalPages.value = notifications.first.totalPage;
        currentPage.value = notifications.first.currentPage;
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
    isFiltersUpdated.toggle();
  }

  void fetchActivities() {
    activities.addAll([
      {
        'title': 'Ahmad just cancelled his...',
        'time': 'Just now',
        "backColor": kPrimaryColor,
      },
      {
        'title': 'John updated the crime report...',
        'time': '5 minutes ago',
        "backColor": kOrangeColor,
      },
      {
        'title': 'Jane resolved a case',
        'time': '10 minutes ago',
        "backColor": kLightBlue,
      },
      {
        'title': 'System generated report',
        'time': '1 hour ago',
        "backColor": kGrey,
      },
    ]);
  }

  void addNewNotification() async {
    if (selectedNotificationType.isEmpty) {
      Get.snackbar(
        "Error",
        "Please select notification type",
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
      return;
    }
    if (titleController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please add title first",
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
      return;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please add description first",
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
      return;
    }
    if (descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Please add description first",
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
      return;
    }
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    NotificationModel notificationModel = NotificationModel.empty();
    notificationModel.title = titleController.text;
    notificationModel.body = descriptionController.text;
    notificationModel.recipientId = specificUserId.text;
    notificationModel.createdAt = DateTime.now().toUtc().toIso8601String();
    notificationModel.data = {
      "type": selectedNotificationType.toLowerCase(),
    };
    var result = await _notificationService.addNewNotification(
      notification: notificationModel,
    );
    Get.back();
    if(result is NotificationModel) {
      Get.back();
      notifications.insert(0, result);
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        backgroundColor: kPrimaryColor,
        colorText: kWhiteColor,
      );
    }
    isTableUpdate.toggle();
  }

  void deleteNotificationById(String notificationId) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    var result = await _notificationService.deleteNotification(
      notificationId: notificationId,
    );
    Get.back();
    if (result is bool) {
      getNotifications();
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
  }

  @override
  onInit() {
    super.onInit();
    getNotifications();
  }

  void changePage(int pageNumber) {
    if (isDataLoading.value) return;
    if (pageNumber > 0 && pageNumber <= totalPages.value) {
      currentPage.value = pageNumber;
    }
  }

  void goToPreviousPage() {
    if (isDataLoading.value) return;
    if (currentPage.value <= 3) return;
    currentPage.value -= 1;
  }

  void goToNextPage() {
    if (isDataLoading.value) return;
    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
    }
  }
}
