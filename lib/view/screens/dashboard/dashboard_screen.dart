import 'package:crime_bee_admin/view/screens/dashboard/controller/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:crime_bee_admin/view/widgets/dashboard-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/controller/menu_controller.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/notifiction_panel.dart';

class DashboardScreen extends GetView<DashboardController> {
  DashboardScreen({super.key});

  final menuController = Get.put(MenuControllers());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonCode.unFocus(context);
      },
      child: Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SideMenu(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: AppStyles().paddingAll21,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Statistics',
                            style: AppStyles.workSansTextStyle().copyWith(
                                fontSize: 20.sp, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kUserScreenRoute);
                                    menuController.onItemTapped(1);
                                  },
                                  child: Obx(
                                    () => DashboardContainer(
                                      width: 202,
                                      height: 112,
                                      color: kPrimaryColor,
                                      title: kActiveVigi,
                                      totalNumber:
                                          controller.activeVigilants.value,
                                    ),
                                  )),
                              Obx(
                                () => DashboardContainer(
                                  width: 202,
                                  height: 112,
                                  color: kBlueColor,
                                  title: kRevenue,
                                  totalNumber: controller.totalRevenue.value,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  kRevenueText,
                                  style: AppStyles.workSansTextStyle().copyWith(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Obx(() => Text(
                                          controller.selectedValue.value,
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                        )),
                                    PopupMenuButton<String>(
                                      color: kWhiteColor,
                                      position: PopupMenuPosition.under,
                                      shape: OutlineInputBorder(
                                          borderRadius: AppStyles.customBorder8,
                                          borderSide: BorderSide.none),
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down_outlined,
                                          size: 16),
                                      onSelected: (value) {
                                        controller.updateValue(value);

                                        value == 'Annually'
                                            ? controller
                                                .fetchRevenueData('yearly')
                                            : value == 'Monthly'
                                                ? controller
                                                    .fetchRevenueData('monthly')
                                                : controller
                                                    .fetchRevenueData('weekly');
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'Weekly',
                                          child: Text('Weekly'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Monthly',
                                          child: Text('Monthly'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Annually',
                                          child: Text('Annually'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]),
                          const SizedBox(
                            height: 36,
                          ),
                          SizedBox(
                            height: 273,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 9, right: 9, top: 9),
                              child: Obx(() {
                                if (controller.barChartData.isEmpty ||
                                    controller.barChartIds.isEmpty) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                return fl.BarChart(
                                  fl.BarChartData(
                                    alignment:
                                        fl.BarChartAlignment.spaceBetween,
                                    maxY: 160,
                                    barGroups: controller.barChartData,
                                    barTouchData: fl.BarTouchData(
                                      enabled: true,
                                      touchTooltipData: fl.BarTouchTooltipData(
                                        getTooltipItem:
                                            (group, groupIndex, rod, rodIndex) {
                                          final revenueValue =
                                              rod.rodStackItems.isNotEmpty
                                                  ? rod.rodStackItems[0].toY
                                                  : rod.toY;

                                          return fl.BarTooltipItem(
                                            revenueValue.toStringAsFixed(2),
                                            const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    gridData: const fl.FlGridData(
                                      show: true,
                                      horizontalInterval: 40,
                                      drawHorizontalLine: false,
                                      drawVerticalLine: false,
                                    ),
                                    titlesData: fl.FlTitlesData(
                                      bottomTitles: fl.AxisTitles(
                                        sideTitles: fl.SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, meta) {
                                            final index = value.toInt();
                                            if (index >=
                                                controller.barChartIds.length) {
                                              return const Text('');
                                            }

                                            final id =
                                                controller.barChartIds[index];
                                            final style =
                                                AppStyles.interTextStyle()
                                                    .copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11.sp,
                                              color: kBarChartTextColor,
                                            );

                                            String formattedLabel;
                                            if (RegExp(r'^\d{4}-\d{2}-\d{2}$')
                                                .hasMatch(id)) {
                                              final date = DateTime.parse(id);
                                              formattedLabel =
                                                  DateFormat("MMM d")
                                                      .format(date);
                                            } else {
                                              formattedLabel = id;
                                            }

                                            return Text(formattedLabel,
                                                style: style);
                                          },
                                        ),
                                      ),
                                      leftTitles: fl.AxisTitles(
                                        sideTitles: fl.SideTitles(
                                          showTitles: true,
                                          reservedSize: 32,
                                          interval: 40,
                                          getTitlesWidget: (value, meta) =>
                                              Text('${value.toInt()}'),
                                        ),
                                      ),
                                      rightTitles: const fl.AxisTitles(
                                        sideTitles:
                                            fl.SideTitles(showTitles: false),
                                      ),
                                      topTitles: const fl.AxisTitles(
                                        sideTitles:
                                            fl.SideTitles(showTitles: false),
                                      ),
                                    ),
                                    borderData: fl.FlBorderData(show: false),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: Center(
                                          child: Text(
                                            kCrimeType,
                                            style: AppStyles.interTextStyle()
                                                .copyWith(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                        )),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 37,
                                    ),
                                    Center(
                                      child: Obx(
                                        () {
                                          if (controller.dataMap.isEmpty) {
                                            return const CircularProgressIndicator();
                                          }
                                          return PieChart(
                                            dataMap: controller.dataMap,
                                            chartRadius: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5.9,
                                            chartType: ChartType.disc,
                                            ringStrokeWidth: 32,
                                            centerText: "",
                                            animationDuration:
                                                const Duration(seconds: 2),
                                            colorList: controller.colorList,
                                            chartValuesOptions:
                                                ChartValuesOptions(
                                              showChartValuesInPercentage: true,
                                              showChartValuesOutside: false,
                                              decimalPlaces: 0,
                                              showChartValueBackground: false,
                                              chartValueStyle:
                                                  AppStyles.interTextStyle()
                                                      .copyWith(
                                                color: kWhiteColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            legendOptions: const LegendOptions(
                                              showLegends: false,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Obx(() {
                                      if (controller.dataMap.isEmpty) {
                                        return const SizedBox();
                                      }
                                      return Center(
                                        child: Wrap(
                                          runSpacing: 24,
                                          spacing: 24,
                                          children: List.generate(
                                            controller.dataMap.length,
                                            (index) {
                                              final label = controller
                                                  .dataMap.keys
                                                  .toList()[index];
                                              final color =
                                                  controller.colorList[index];
                                              return SizedBox(
                                                width: 219,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width: 8,
                                                      height: 6,
                                                      decoration: BoxDecoration(
                                                        color: color,
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 7),
                                                    Text(
                                                      label,
                                                      style: AppStyles
                                                              .interTextStyle()
                                                          .copyWith(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: kBlackColor1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    }),
                                  ]),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                              child: Obx(
                                            () => Text(
                                              "${controller.selectedValue1.value} Reported Crimes",
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                          )),
                                          Row(
                                            children: [
                                              Obx(() => Text(
                                                    controller
                                                        .selectedValue1.value,
                                                    style: AppStyles
                                                            .interTextStyle()
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                  )),
                                              PopupMenuButton<String>(
                                                color: kWhiteColor,
                                                position:
                                                    PopupMenuPosition.under,
                                                shape: OutlineInputBorder(
                                                    borderRadius:
                                                        AppStyles.customBorder8,
                                                    borderSide:
                                                        BorderSide.none),
                                                icon: const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_outlined,
                                                    size: 16),
                                                onSelected: (value) {
                                                  controller
                                                      .updateValue2(value);
                                                  controller.fetchAndSetStats();
                                                },
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  const PopupMenuItem(
                                                    value: 'Monthly',
                                                    child: Text('Monthly'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'Annually',
                                                    child: Text('Annually'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 100,
                                      ),
                                      SizedBox(
                                        height: 273,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 9, right: 9, top: 9),
                                          child: Obx(() {
                                            if (controller
                                                    .monthlyRecords.isEmpty ||
                                                controller.monthsData.isEmpty) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }

                                            return fl.BarChart(
                                              fl.BarChartData(
                                                alignment: fl.BarChartAlignment
                                                    .spaceBetween,
                                                maxY: controller.maxY.value,
                                                gridData: const fl.FlGridData(
                                                    show: true,
                                                    horizontalInterval: 40,
                                                    drawHorizontalLine: false,
                                                    drawVerticalLine: false),
                                                titlesData: fl.FlTitlesData(
                                                  leftTitles: fl.AxisTitles(
                                                    sideTitles: fl.SideTitles(
                                                      showTitles: true,
                                                      reservedSize: 59,
                                                      interval: 40000,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        if (value % 40 == 0) {
                                                          return Text(
                                                            value
                                                                .toInt()
                                                                .toString(),
                                                            style: TextStyle(
                                                              color:
                                                                  kBarChartTextColor,
                                                              fontSize: 12.sp,
                                                            ),
                                                          );
                                                        }
                                                        return Container();
                                                      },
                                                    ),
                                                  ),
                                                  bottomTitles: fl.AxisTitles(
                                                    sideTitles: fl.SideTitles(
                                                      showTitles: true,
                                                      getTitlesWidget:
                                                          (value, meta) {
                                                        final index =
                                                            value.toInt();
                                                        if (index <
                                                            controller
                                                                .monthsData
                                                                .length) {
                                                          final data = controller
                                                                  .monthsData[
                                                              index];

                                                          if (controller
                                                                  .selectedValue1
                                                                  .value ==
                                                              "Monthly") {
                                                            final monthNumber =
                                                                data[
                                                                    'monthNumber']!;
                                                            final year =
                                                                data['year']!;
                                                            final monthName = controller
                                                                .getMonthAbbreviation(
                                                                    monthNumber);
                                                            return Text(
                                                              '$monthName $year',
                                                              style: AppStyles
                                                                      .interTextStyle()
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 11.sp,
                                                                color:
                                                                    kBarChartTextColor,
                                                              ),
                                                            );
                                                          } else {
                                                            final year =
                                                                data['year']!;
                                                            return Text(
                                                              '$year',
                                                              style: AppStyles
                                                                      .interTextStyle()
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 11.sp,
                                                                color:
                                                                    kBarChartTextColor,
                                                              ),
                                                            );
                                                          }
                                                        }
                                                        return const Text('');
                                                      },
                                                    ),
                                                  ),
                                                  rightTitles:
                                                      const fl.AxisTitles(
                                                          sideTitles:
                                                              fl.SideTitles(
                                                                  showTitles:
                                                                      false)),
                                                  topTitles:
                                                      const fl.AxisTitles(
                                                          sideTitles:
                                                              fl.SideTitles(
                                                                  showTitles:
                                                                      false)),
                                                ),
                                                borderData: fl.FlBorderData(
                                                  show: false,
                                                ),
                                                barGroups:
                                                    controller.monthlyRecords,
                                              ),
                                            );
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isNotificationVisible.value,
                child: NotificationAndActivitySection(
                  notifications: controller.notifications,
                  activities: controller.activities,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
