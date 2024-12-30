import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';


class AddCrimeController extends GetxController {
  TextEditingController typeofCrimeController = TextEditingController();
  TextEditingController severityLevelController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateIncidentController = TextEditingController();
  TextEditingController dateIncidentEditController = TextEditingController();
  TextEditingController timeIncidentController = TextEditingController();
  TextEditingController timeIncidentEditController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  var pickLocation = kLocation.obs;
  var selectedCrimeType = ''.obs;
  var selectedCrimeType1 = ''.obs;
  var selectedSeverityLevel = ''.obs;
  var selectedSeverityLevel1 = ''.obs;
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  Rx<DateTime?> selectedDateEdit = Rx<DateTime?>(null);
  Rx<String> selectedTime = Rx<String>("time");
  Rx<String> selectedTime1 = Rx<String>("time");
  Rx<bool> isAm = true.obs;
  Rx<bool> isAm1 = true.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedFilters = <String>{}.obs;

  var isNotificationVisible = false.obs;

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
  }

  void openCalendarDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => SizedBox(
            height: 350,
            width: 342,
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: selectedDate.value ?? DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(selectedDate.value, day),
              onDaySelected: (newSelectedDay, newFocusedDay) {
                selectedDate.value = newSelectedDay;
                dateIncidentController.text =
                "${selectedDate.value!.day}-${selectedDate.value!.month}-${selectedDate.value!.year}";
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
          )),
        ),
      ),
    );
  }

  void openCalendarDialog1(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => SizedBox(
            height: 350,
            width: 342,
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: selectedDateEdit.value ?? DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(selectedDateEdit.value, day),
              onDaySelected: (newSelectedDay, newFocusedDay) {
                selectedDateEdit.value = newSelectedDay;
                dateIncidentEditController.text =
                "${selectedDateEdit.value!.day}-${selectedDateEdit.value!.month}-${selectedDateEdit.value!.year}";
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
          )),
        ),
      ),
    );
  }


  @override
  void onInit() {
    super.onInit();
    _addListeners();
    fetchNotifications();
    fetchActivities();
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

  void setSelectedTime(String time) {
    selectedTime.value = time;
    timeIncidentController.text = selectedTime.value;
  }

  void setSelectedTime1(String time) {
    selectedTime1.value = time;
    timeIncidentEditController.text = selectedTime1.value;
  }

  var isFormValid = false.obs;


  void _addListeners() {
    typeofCrimeController.addListener(_validateForm);
    severityLevelController.addListener(_validateForm);
    locationController.addListener(_validateForm);
    dateIncidentController.addListener(_validateForm);
  }

  void _validateForm() {
    isFormValid.value = typeofCrimeController.text.isNotEmpty &&
        severityLevelController.text.isNotEmpty &&
        locationController.text.isNotEmpty &&
        dateIncidentController.text.isNotEmpty;
  }

  void clearFields() {
    typeofCrimeController.clear();
    severityLevelController.clear();
    locationController.clear();
    dateIncidentController.clear();
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