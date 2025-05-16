import 'dart:typed_data';

import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class BlogController extends GetxController {
  var selectedBlogType = ''.obs;
  var selectedBlogStatus = ''.obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedFilters = <String>{}.obs;

  Rx<Uint8List?> selectedImage = Rx<Uint8List?>(null);

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = await image.readAsBytes();
    }
  }

  void toggleFilter(String filter) {
    if (selectedFilters.contains(filter)) {
      selectedFilters.remove(filter);
    } else {
      selectedFilters.add(filter);
    }
  }

  var isNotificationVisible = false.obs;

  void toggleNotificationVisibility() {
    isNotificationVisible.value = !isNotificationVisible.value;
  }

  @override
  onInit(){
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

  final List<Map<String, dynamic>> allBlogs = [
    {"Title": "Crime Safety Tips", "Category": "Tech", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "Crime", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "Ai", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "Tech", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "Ai", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
    {"Title": "Crime Safety Tips", "Category": "Crime", "Views": '150 Views', "date": "Dec 6, 2024, 10:45 AM"},
  ];

  final List<Map<String, dynamic>> allUserBlogs = [
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "ABC", "Status": "Approved","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "John Doe", "Status": "Pending","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "John Doe", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Approved","statusBackColor" : kLightBlue.withOpacity(0.2), "StatusColor" : kLightBlue},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Pending","statusBackColor" : kPrimaryColor.withOpacity(0.2), "StatusColor" : kPrimaryColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "John Doe", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "Jane Smith", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},
    {"title": "Crime Safety Tips", "submissionDate": "07/12/2024", "submitBy": "John Doe", "Status": "Rejected","statusBackColor" : kBrownColor.withOpacity(0.2), "StatusColor" : kBrownColor},

  ];

  final int itemsPerPage = 3;
  final int userBlogsPerPage = 3;

  final RxInt currentPage = 1.obs;
  final RxInt userBlogsCurrentPage = 1.obs;

  List<Map<String, dynamic>> get currentPageUsers {
    final startIndex = (currentPage.value - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    return allBlogs.sublist(
      startIndex,
      endIndex > allBlogs.length ? allBlogs.length : endIndex,
    );
  }

  List<Map<String, dynamic>> get userBlogsCurrentPageUsers {
    final startIndex = (userBlogsCurrentPage.value - 1) * userBlogsPerPage;
    final endIndex = startIndex + userBlogsPerPage;
    return allUserBlogs.sublist(
      startIndex,
      endIndex > allUserBlogs.length ? allUserBlogs.length : endIndex,
    );
  }

  int get totalPages => (allBlogs.length / itemsPerPage).ceil();
  int get userBlogTotalPages => (allUserBlogs.length / userBlogsPerPage).ceil();

  void changePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= totalPages) {
      currentPage.value = pageNumber;
    }
  }

  void userBlogChangePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= userBlogTotalPages) {
      userBlogsCurrentPage.value = pageNumber;
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value -= 1;
    }
  }

  void goToPreviousPage1() {
    if (userBlogsCurrentPage.value > 1) {
      userBlogsCurrentPage.value -= 1;
    }
  }

  // Next button functionality
  void goToNextPage() {
    if (currentPage.value < totalPages) {
      currentPage.value += 1;
    }
  }

  void goToNextPage1() {
    if (userBlogsCurrentPage.value < userBlogTotalPages) {
      userBlogsCurrentPage.value += 1;
    }
  }

  bool get isBackButtonDisabled => currentPage.value == 1;

  bool get isBackButtonDisabled1 => userBlogsCurrentPage.value == 1;

  bool get isNextButtonDisabled => currentPage.value == totalPages;
  bool get isNextButtonDisabled1 => userBlogsCurrentPage.value == userBlogTotalPages;
}