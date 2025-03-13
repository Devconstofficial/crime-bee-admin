import 'dart:developer';

import 'package:crime_bee_admin/utils/app_colors.dart';
import 'package:crime_bee_admin/utils/common_code.dart';
import 'package:crime_bee_admin/utils/extensions.dart';
import 'package:crime_bee_admin/view/models/crime_category_model.dart';
import 'package:crime_bee_admin/view/models/crime_model.dart';
import 'package:crime_bee_admin/view/models/get_location_model.dart';
import 'package:crime_bee_admin/web_services/crime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../side_menu/controller/menu_controller.dart';

class AddCrimeDashboardController extends GetxController {
  final CrimeService _crimeService = CrimeService();
  final TextEditingController timeIncidentEditController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateIncidentEditController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final menuController = Get.put(MenuControllers());
  GetLocationModel getLocationModel= GetLocationModel.empty();
  CrimeModel selectedCrime = CrimeModel.empty();
  Rx<CrimeCategoryModel> selectedCrimeType = Rx(CrimeCategoryModel.init());
  Rx<DateTime> selectedDateEdit = Rx<DateTime>(DateTime.now());
  Set<String> selectedFilters = <String>{};
  RxBool isFiltersUpdated = false.obs,
      isNotificationVisible = false.obs,
      isTableUpdate = false.obs,
      isDataLoading = false.obs,
      isAm = true.obs;
  RxInt currentPage = 1.obs,totalPages=0.obs;
  RxString selectedTime = "time".obs,selectSeverityType = "".obs;
  RxList<CrimeModel> crimes = RxList<CrimeModel>();
  RxList notifications = [].obs;
  RxList activities = [].obs;
  bool get isBackButtonDisabled => currentPage.value == 1;
  bool get isNextButtonDisabled => currentPage.value == totalPages.value;

  @override
  void onInit() {
    super.onInit();
    getCrimesData();
  }

  void getCrimesData() async {
    if(isDataLoading.value) return;
    isDataLoading.value = true;
    var result = await _crimeService.getAllCrimes(pageNo: currentPage.value);
    if(result is List<CrimeModel>) {
      crimes.clear();
      crimes.addAll(result);
      if(crimes.isNotEmpty) {
        totalPages.value=crimes.first.totalPage;
        currentPage.value=crimes.first.currentPage;
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

  void deleteCrimeById(String crimeId) async {
    Get.dialog(const Center(child: CircularProgressIndicator(),),barrierDismissible: false,);
    var result = await _crimeService.deleteCrimeById(crimeId: crimeId);
    Get.back();
    if(result is bool) {
      getCrimesData();
    } else {
      Get.snackbar("Error", result.toString(),colorText: kWhiteColor,backgroundColor: kPrimaryColor,);
    }
  }

  void editCrime() async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );
    selectedCrime.location = getLocationModel.location;
    selectedCrime.locationModel = LocationModel.empty()
      ..lat = getLocationModel.lat
      ..lng = getLocationModel.lng
      ..type = "Point";
    selectedCrime.severity = selectSeverityType.value.toLowerCase();
    selectedCrime.crimeType = selectedCrimeType.value.crimeType;
    selectedCrime.description = descriptionController.text;
    selectedCrime.dateTime = selectedDateEdit.value.toUtc().toIso8601String();
    var result = await _crimeService.editCrimeReport(
      selectedCrime,
    );
    Get.back();
    if(result is CrimeModel) {
      getCrimesData();
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
  }

  void changePage(int pageNumber) {
    if(isDataLoading.value)return;
    if (pageNumber > 0 && pageNumber <= totalPages.value) {
      currentPage.value = pageNumber;
      getCrimesData();
    }
  }

  void goToPreviousPage() {
    if(isDataLoading.value)return;
    if(currentPage.value<=3)return;
    currentPage.value -= 1;
    getCrimesData();

  }

  void goToNextPage() {
    if(isDataLoading.value)return;
    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
      getCrimesData();
    }
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter.toLowerCase())) {
      selectedFilters.remove(filter.toLowerCase());
    } else {
      selectedFilters.add(filter.toLowerCase());
    }
    isFiltersUpdated.toggle();
  }

  void setSelectedTime(String time) {
    selectedTime.value = time;
    timeIncidentEditController.text = selectedTime.value;
  }

  void openCalendarDialog() async {
    await Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      backgroundColor: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 350,
          width: 342,
          child: TableCalendar(
            firstDay: DateTime.utc(2000, 1, 1),
            lastDay: DateTime.now(),
            focusedDay: selectedDateEdit.value,
            selectedDayPredicate: (day) => isSameDay(selectedDateEdit.value, day),
            onDaySelected: (newSelectedDay, newFocusedDay) {
              selectedDateEdit.value = newSelectedDay;
              dateIncidentEditController.text =
              "${selectedDateEdit.value.day}-${selectedDateEdit.value.month}-${selectedDateEdit.value.year}";
              Get.back();
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: kPrimaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
              selectedDecoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(8),
                shape: BoxShape.rectangle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),);
  }

  void filterCrimeData({required CrimeModel crimeModel}) {
    log('==========+>$crimeModel');
    selectedCrime = crimeModel;
    if(CommonCode.crimeCategories.where((test)=>test.crimeType==crimeModel.crimeType).isNotEmpty) {
      selectedCrimeType.value = CommonCode.crimeCategories.where((test)=>test.crimeType==crimeModel.crimeType).first;
    } else {
      selectedCrimeType.value = CrimeCategoryModel.init();
    }
    selectSeverityType.value = crimeModel.severity.convertToCamelCase();
    locationController.text = crimeModel.location;
    getLocationModel = GetLocationModel.empty()
      ..location = crimeModel.location
      ..lat = crimeModel.locationModel.lat
      ..lng = crimeModel.locationModel.lng;
    DateTime dateTime = DateTime.parse(crimeModel.dateTime);
    dateIncidentEditController.text = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
    timeIncidentEditController.text = "${dateTime.hour}:${dateTime.month}";
    descriptionController.text = crimeModel.description;
  }
}