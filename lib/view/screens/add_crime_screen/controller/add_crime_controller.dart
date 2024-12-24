import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';


class AddCrimeController extends GetxController {
  TextEditingController typeofCrimeController = TextEditingController();
  TextEditingController severityLevelController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateTimeIncidentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var selectedCrimeType = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  Rx<String> selectedTime = Rx<String>("0:00");
  Rx<bool> isAm = true.obs;

  void setSelectedTime(String time) {
    selectedTime.value = time;
  }

  var isFormValid = false.obs;

  @override
  void onInit() {
    super.onInit();
    _addListeners();
  }

  void _addListeners() {
    typeofCrimeController.addListener(_validateForm);
    severityLevelController.addListener(_validateForm);
    locationController.addListener(_validateForm);
    dateTimeIncidentController.addListener(_validateForm);
  }

  void _validateForm() {
    isFormValid.value = typeofCrimeController.text.isNotEmpty &&
        severityLevelController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        dateTimeIncidentController.text.isNotEmpty;
  }

  void clearFields() {
    typeofCrimeController.clear();
    severityLevelController.clear();
    locationController.clear();
    dateTimeIncidentController.clear();
    descriptionController.clear();
  }

  void addCrime() {
    clearFields();
  }

  final List<Map<String, dynamic>> allUsers = [
    {"Crime Type": "Theft", "Location": "Baker Street", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Assault", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Theft", "Location": "Tower Bridge", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Vandalism", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Assault", "Location": "Tower Bridge", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Assault", "Location": "Baker Street", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Theft", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Vandalism", "Location": "Tower Bridge", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Vandalism", "Location": "Baker Street", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Theft", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Vandalism", "Location": "Tower Bridge", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Theft", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
    {"Crime Type": "Assault", "Location": "Oxford Circus", "Date & Time": "Dec 6, 2024, 10:45 AM"},
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