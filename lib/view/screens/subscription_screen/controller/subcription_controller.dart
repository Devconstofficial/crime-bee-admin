import 'dart:convert';
import 'dart:developer';

import 'package:crime_bee_admin/web_services/subscription_service.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class SubscriptionController extends GetxController {
  final SubscriptionService _subscriptionService = SubscriptionService();

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
      {
        'title': 'New Host registered',
        'time': '59 minutes ago',
        "backColor": kPrimaryColor
      },
      {
        'title': 'New Crime Reported',
        'time': '1 hour ago',
        "backColor": kOrangeColor
      },
      {
        'title': 'Crime Resolved',
        'time': '2 hours ago',
        "backColor": kLightBlue
      },
      {
        'title': 'Update on your case',
        'time': '3 hours ago',
        "backColor": kGrey
      },
    ]);
  }

  void fetchActivities() {
    activities.addAll([
      {
        'title': 'Ahmad just cancelled his...',
        'time': 'Just now',
        "backColor": kPrimaryColor
      },
      {
        'title': 'John updated the crime report...',
        'time': '5 minutes ago',
        "backColor": kOrangeColor
      },
      {
        'title': 'Jane resolved a case',
        'time': '10 minutes ago',
        "backColor": kLightBlue
      },
      {
        'title': 'System generated report',
        'time': '1 hour ago',
        "backColor": kGrey
      },
    ]);
  }
  

  RxList<dynamic> subscriptionsList = [].obs;
  RxList<dynamic> allSubscriptionsList = [].obs;
  final int itemsPerPage = 7;
  final RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;
  Future<void> fetchSubscriptions({int page = 1, int limit = 7}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response =
          await _subscriptionService.getSubscriptions(page: page, limit: limit);

      log("Raw Response: ${jsonEncode(response)}");

      if (response.containsKey('subscriptions')) {
        final fullList = response['subscriptions'];
        allSubscriptionsList.value = fullList;

        currentPage.value = page;

        applySearchAndPaginate();
      } else {
        subscriptionsList.clear();
        errorMessage.value = response['error'] ?? 'Unknown error occurred';
        log("Error: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch subscriptions: $e';
      log(errorMessage.value);
      subscriptionsList.clear();
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
    currentPage.value = 1; 
    applySearchAndPaginate();
  }

  void applySearchAndPaginate() {
  final query = searchQuery.value.trim().toLowerCase();
  final filters = selectedFilters;

  List<dynamic> filteredList = allSubscriptionsList.where((sub) {
    final name = (sub['user']?['name'] ?? '').toString().toLowerCase();
    final matchesQuery = query.isEmpty || name.contains(query);

    final subType = _formatSubscriptionType(sub['user']?['type']);
    final matchesFilter =
        filters.isEmpty || filters.contains(subType); 

    return matchesQuery && matchesFilter;
  }).toList();

  totalPages.value = (filteredList.length / itemsPerPage)
      .ceil()
      .clamp(1, double.infinity)
      .toInt();

  final start = (currentPage.value - 1) * itemsPerPage;
  final end = (start + itemsPerPage > filteredList.length)
      ? filteredList.length
      : start + itemsPerPage;

  subscriptionsList.value = filteredList.sublist(start, end);
}


  void changePage(int pageNumber) {
    if (pageNumber > 0 && pageNumber <= totalPages.value) {
      currentPage.value = pageNumber;
      applySearchAndPaginate();
    }
  }

  void goToPreviousPage() {
    if (currentPage.value > 1) {
      currentPage.value -= 1;
      applySearchAndPaginate();
    }
  }

  void goToNextPage() {
    if (currentPage.value < totalPages.value) {
      currentPage.value += 1;
      applySearchAndPaginate();
    }
  }

  void clearFilters() {
  selectedFilters.clear();
  currentPage.value = 1;
  applySearchAndPaginate();
}


  String _formatSubscriptionType(dynamic type) {
    final typeStr = type?.toString().toLowerCase() ?? '';

    if (typeStr.contains('monthly')) return 'Monthly';
    if (typeStr.contains('annual')) return 'Annually';
    return type?.toString() ?? '';
  }

  bool get isBackButtonDisabled => currentPage.value == 1;
  bool get isNextButtonDisabled => currentPage.value == totalPages.value;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
    fetchActivities();
    fetchSubscriptions();
  }
}
