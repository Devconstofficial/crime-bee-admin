import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class SubscriptionController extends GetxController {
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
  }

  final List<Map<String, dynamic>> allUsers = [
    {"userId": "00001", "name": "Christine Brooks", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00002", "name": "Rosie Pearson", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00003", "name": "Darrell Caldwell", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00004", "name": "Gilbert Johnston", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00005", "name": "Alan Cain", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00006", "name": "Alfred Murray", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00007", "name": "Bryan Ross", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00008", "name": "Jessica Cook", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00009", "name": "Linda Diaz", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00010", "name": "Matthew Fisher", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
    {"userId": "00011", "name": "Theresa Phillips", "Status": "Paid", "type": "3 Months","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue,"Revenue": 9.99},
    {"userId": "00012", "name": "Charles Moore", "Status": "Paid", "type": "Monthly","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor,"Revenue": 9.99},
    {"userId": "00013", "name": "Jennifer White", "Status": "Paid", "type": "Yearly","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor,"Revenue": 9.99},
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