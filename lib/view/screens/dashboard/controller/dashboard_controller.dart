import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';


class DashboardController extends GetxController {
  RxList<BarChartGroupData> barChartData = <BarChartGroupData>[].obs;
  RxList notifications = [].obs;
  RxList activities = [].obs;
  var selectedValue = 'Last 7 Days'.obs;
  var selectedValue1 = 'Last 7 Days'.obs;
  var selectedTodayValue = 'Today'.obs;

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
  onInit(){
    super.onInit();
    generateBarChartData();
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

  // void generateBarChartData() {
  //   List<BarChartGroupData> rawData = [
  //     BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 60, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 40, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 20, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 120, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 160, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 100, color: kPrimaryColor, width: 30)]),
  //     BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 60, color: kPrimaryColor, width: 30)]),
  //   ];
  //
  //   barChartData.value = rawData.map((data) {
  //     double maxBarHeight = 160.0;
  //     return BarChartGroupData(
  //       x: data.x,
  //       barsSpace: 4,
  //       barRods: [
  //         // Unfilled bar
  //         BarChartRodData(
  //           toY: maxBarHeight,
  //           color: kFieldBorderColor,
  //           width: data.barRods.first.width,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         // Filled bar
  //         BarChartRodData(
  //           toY: data.barRods.first.toY,
  //           color: kPrimaryColor,
  //           width: data.barRods.first.width,
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //       ],
  //     );
  //   }).toList();
  //
  // }

  void generateBarChartData() {
    List<double> rawData = [60, 40, 20, 120, 160, 100, 60];
    double maxBarHeight = 160.0;

    barChartData.value = rawData.asMap().entries.map((entry) {
      int index = entry.key;
      double value = entry.value;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: maxBarHeight,
            color: kWhiteColor,
            borderSide: const BorderSide(color: kTableBorderColor),
            width: 10,
            borderRadius: BorderRadius.circular(8),
            rodStackItems: [
              BarChartRodStackItem(
                  0,
                  value,
                  kPrimaryColor,

              ),
            ],
          ),
        ],
      );
    }).toList();
  }


  RxMap<String, double> dataMap = {
    '1-25': 10.0,
    '25-50': 45.0,
    '50-75': 45.0,
  }.obs;

  List<Color> get colorList {
    return [
      kPrimaryColor,
      kBrownColor,
      kBlueColor,
    ];
  }

  void updateData(String key, double value) {
    dataMap[key] = value;
  }
}