import 'dart:developer';

import 'package:crime_bee_admin/web_services/dashboard_services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';

class DashboardController extends GetxController {
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedValue = 'Weekly'.obs;
  var selectedValue1 = 'Monthly'.obs;
  var selectedTodayValue = 'Today'.obs;
  var isNotificationVisible = false.obs;
  var activeVigilants = '0'.obs;
  var totalRevenue = '0'.obs;
  final DashboardServices _services = DashboardServices();

  void updateValue(String value) {
    selectedValue.value = value;
  }

  void updateValue2(String value) {
    selectedValue1.value = value;
  }

  void updateValue1(String value) {
    selectedTodayValue.value = value;
  }

  @override
  onInit() {
    super.onInit();
    fetchRevenueData("weekly");
    fetchAndSetStats();
    fetchStats();
    fetchActivities();
    fetchNotifications();
  }

  void fetchNotifications() {
    notifications.addAll([
      {
        'title': 'New Host registered',
        'time': '59 minutes ago',
        "backColor": kPrimaryColor,
      },
      {
        'title': 'New Crime Reported',
        'time': '1 hour ago',
        "backColor": kOrangeColor,
      },
      {
        'title': 'Crime Resolved',
        'time': '2 hours ago',
        "backColor": kLightBlue,
      },
      {
        'title': 'Update on your case',
        'time': '3 hours ago',
        "backColor": kGrey,
      },
    ]);
  }

  void fetchActivities() async {
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


  void fetchStats() async {
    final stats = await _services.getUserStats();
    if (stats is Map<String, dynamic>) {
      print("Active Vigilantes: ${stats['activeVigilantesCount']}");
      print("Total Revenue: ${stats['totalRevenue']}");
      print("Crimes Reported: ${stats['crimesReportedThisMonth']}");
      activeVigilants.value = stats['activeVigilantesCount'].toString();
      totalRevenue.value = stats['totalRevenue'].toString();
    } else {
      print("Error fetching stats: $stats");
    }
  }

  RxList<fl.BarChartGroupData> barChartData = <fl.BarChartGroupData>[].obs;
  RxList<String> barChartIds = <String>[].obs;

  void fetchRevenueData(String type) async {
    final response = await DashboardServices().getRevenue(type: type);

    if (response is List) {
      barChartData.clear();
      barChartIds.clear();

      double maxBarHeight = 160.0;

      for (int i = 0; i < response.length; i++) {
        final item = response[i];
        final dateStr = item['date'];
        final revenue = double.tryParse(item['totalRevenue'].toString()) ?? 0;

        barChartIds.add(dateStr);

        barChartData.add(
          fl.BarChartGroupData(
            x: i,
            barRods: [
              fl.BarChartRodData(
                toY: maxBarHeight,
                color: kWhiteColor,
                width: 14,
                borderSide:
                    const BorderSide(color: kTableBorderColor, width: 1),
                borderRadius: BorderRadius.circular(8),
                rodStackItems: [
                  BarChartRodStackItem(
                    0,
                    revenue,
                    kPrimaryColor,
                  ),
                ],
              ),
            ],
            showingTooltipIndicators: [],
          ),
        );
      }

      log("Revenue data loaded: ${barChartData.length} bars");
    } else {
      log("Revenue fetch failed or response is malformed. Response: $response");
    }
  }

  RxMap<String, double> dataMap = <String, double>{}.obs;

  List<Color> get colorList {
    return [
      kPrimaryColor,
      kBrownColor,
      kBlueColor,
    ];
  }

  RxList<fl.BarChartGroupData> monthlyRecords = <fl.BarChartGroupData>[].obs;
  RxList<Map<String, int?>> monthsData = <Map<String, int?>>[].obs;
  RxDouble maxY = 180.0.obs;
  Future<void> fetchAndSetStats() async {
    monthlyRecords.clear();
    monthsData.clear();
  if (selectedValue1.value == "Monthly") {
    final stats = await _services.getMonthlyStats();
    if (stats != null && stats.top3Crimes != null) {
      final Map<String, dynamic> crimes = stats.top3Crimes!;
      dataMap.value = {
        for (var entry in crimes.entries)
          entry.key: (entry.value as num).toDouble(),
      };

      final records = stats.records;
      final maxCrimeCount = records!
          .map((e) => (e.crimeCount ?? 0).toDouble())
          .fold<double>(0, (prev, curr) => curr > prev ? curr : prev);
      final adjustedMaxY = maxCrimeCount + 20;
      maxY.value = adjustedMaxY;

      monthlyRecords.value = List.generate(records.length, (index) {
        final record = records[index];
        final double crimeCount = (record.crimeCount ?? 0).toDouble();

        return fl.BarChartGroupData(
          x: index,
          barRods: [
            fl.BarChartRodData(
              toY: crimeCount,
              color: kWhiteColor,
              width: 14,
              borderSide: const BorderSide(color: kTableBorderColor, width: 1),
              borderRadius: BorderRadius.circular(8),
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  crimeCount,
                  kPrimaryColor,
                ),
              ],
            ),
          ],
        );
      });

      monthsData.value = records
          .map((record) => {
                'monthNumber': record.monthNumber,
                'year': record.year,
              })
          .toList();
    }
  } else {
    final stats = await _services.getYearlyStats();
    if (stats != null && stats.top3Crimes != null) {
      final Map<String, dynamic> crimes = stats.top3Crimes!;
      dataMap.value = {
        for (var entry in crimes.entries)
          entry.key: (entry.value as num).toDouble(),
      };

      final records = stats.records;
      final maxCrimeCount = records!
          .map((e) => (e.crimeCount ?? 0).toDouble())
          .fold<double>(0, (prev, curr) => curr > prev ? curr : prev);
      final adjustedMaxY = maxCrimeCount + 20;
      maxY.value = adjustedMaxY;

      monthlyRecords.value = List.generate(records.length, (index) {
        final record = records[index];
        final double crimeCount = (record.crimeCount ?? 0).toDouble();

        return fl.BarChartGroupData(
          x: index,
          barRods: [
            fl.BarChartRodData(
              toY: crimeCount,
              color: kWhiteColor,
              width: 14,
              borderSide: const BorderSide(color: kTableBorderColor, width: 1),
              borderRadius: BorderRadius.circular(8),
              rodStackItems: [
                BarChartRodStackItem(
                  0,
                  crimeCount,
                  kPrimaryColor,
                ),
              ],
            ),
          ],
        );
      });

      monthsData.value = records
          .map((record) => {
                'year': record.year,
              })
          .toList();
    }
  }
}


  String getMonthAbbreviation(int monthNumber) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[monthNumber - 1];
  }

  void updateData(String key, double value) {
    dataMap[key] = value;
  }
}
