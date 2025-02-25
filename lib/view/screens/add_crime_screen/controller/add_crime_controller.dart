import 'package:crime_bee_admin/view/models/crime_category_model.dart';
import 'package:crime_bee_admin/view/models/crime_model.dart';
import 'package:crime_bee_admin/view/models/get_location_model.dart';
import 'package:crime_bee_admin/web_services/crime_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';


class AddCrimeController extends GetxController {
  final TextEditingController typeofCrimeController = TextEditingController();
  final TextEditingController severityLevelController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController dateIncidentController = TextEditingController();
  final TextEditingController dateIncidentEditController = TextEditingController();
  final TextEditingController timeIncidentController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final CrimeService _crimeService = CrimeService();
  GetLocationModel getLocationModel = GetLocationModel.empty();
  Rx<CrimeCategoryModel> selectedCrimeType = Rx(CrimeCategoryModel.init());
  RxString selectSeverityType = "".obs,selectedTime = "time".obs;
  Rx<DateTime> selectedDate = Rx<DateTime>(DateTime.now());
  Rx<bool> isAm = true.obs,
      enabledDiscard = false.obs,
      enableAddCrime = false.obs,
      isNotificationVisible = false.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;

  void validateDiscard() {
    validateAddCrimeButton();
    if(selectedCrimeType.value.name.isNotEmpty) {
      enabledDiscard.value = true;
    } else if(selectSeverityType.isNotEmpty) {
      enabledDiscard.value = true;
    } else if(getLocationModel.location.isNotEmpty) {
      enabledDiscard.value = true;
    } else if(dateIncidentController.text.isNotEmpty) {
      enabledDiscard.value = true;
    } else if(timeIncidentController.text.isNotEmpty) {
      enabledDiscard.value = true;
    } else if(descriptionController.text.isNotEmpty) {
      enabledDiscard.value = true;
    } else {
      enabledDiscard.value = false;
    }
  }

  void validateAddCrimeButton() {
    if(selectedCrimeType.value.name.isNotEmpty && selectSeverityType.isNotEmpty && locationController.text.isNotEmpty && dateIncidentController.text.isNotEmpty && timeIncidentController.text.isNotEmpty && descriptionController.text.isNotEmpty) {
      enableAddCrime.value = true;
    } else {
      enableAddCrime.value = false;
    }
  }

  void onDiscardButtonTap() {
    if(enabledDiscard.isFalse) return;
    selectedCrimeType.value = CrimeCategoryModel.init();
    selectSeverityType.value = "";
    getLocationModel = GetLocationModel.empty();
    dateIncidentController.clear();
    timeIncidentController.clear();
    descriptionController.clear();
    enabledDiscard.value = false;
  }

  void openCalendarDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => Dialog(
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
              focusedDay: selectedDate.value,
              selectedDayPredicate: (day) => isSameDay(selectedDate.value, day),
              onDaySelected: (newSelectedDay, newFocusedDay) {
                selectedDate.value = newSelectedDay;
                dateIncidentController.text =
                "${selectedDate.value.day}-${selectedDate.value.month}-${selectedDate.value.year}";
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
      ),
    );
  }


  @override
  void onInit() {
    super.onInit();
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

  void addCrime() async {
    if(enableAddCrime.isFalse) return;
    Get.dialog(
      const Center(child: CircularProgressIndicator(),),
      barrierDismissible: false
    );
    CrimeModel crimeModel = CrimeModel.empty();
    crimeModel.location = getLocationModel.location;
    crimeModel.locationModel = LocationModel.empty()
      ..lat = getLocationModel.lat
      ..lng = getLocationModel.lng
      ..type = "Point";
    crimeModel.severity = selectSeverityType.value.toLowerCase();
    crimeModel.crimeType = selectedCrimeType.value.crimeType;
    crimeModel.description = descriptionController.text;
    crimeModel.dateTime = selectedDate.value.toUtc().toIso8601String();
    var result = await _crimeService.addCrimeReport(crimeModel);
    Get.back();
    if(result is CrimeModel) {
      // added New Crime
    } else {
      Get.snackbar(
        "Error",
        result.toString(),
        colorText: kWhiteColor,
        backgroundColor: kPrimaryColor,
      );
    }
  }



}