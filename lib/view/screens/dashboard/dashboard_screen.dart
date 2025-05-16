import 'package:crime_bee_admin/view/screens/dashboard/controller/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:crime_bee_admin/view/widgets/dashboard-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
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
                          Row(
                            children: [
                              Obx(
                                () {
                                  return Text(
                                    controller.selectedTodayValue.value,
                                    style: AppStyles.workSansTextStyle()
                                        .copyWith(
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600),
                                  );
                                },
                              ),
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
                                  controller.updateValue1(value);
                                },
                                itemBuilder: (BuildContext context) => [
                                  const PopupMenuItem(
                                    value: 'Today',
                                    child: Text('Today'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Last 7 Days',
                                    child: Text('Last 7 Days'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Last 2 Weeks',
                                    child: Text('Last 2 Weeks'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'Last 1 Month',
                                    child: Text('Last 1 Month'),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.isNotificationVisible.toggle();
                                  },
                                  child: Image.asset(
                                    kNotification1Icon,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                            ],
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
                                  child: DashboardContainer(
                                    width: 202,
                                    height: 112,
                                    color: kPrimaryColor,
                                    percent: '+11.01',
                                    title: kActiveVigi,
                                    totalNumber: '2200',
                                  )),
                              DashboardContainer(
                                width: 202,
                                height: 112,
                                color: kBlueColor,
                                percent: '-0.03',
                                title: kRevenue,
                                totalNumber: '120',
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Get.toNamed(kUserScreenRoute);
                                    menuController.onItemTapped(1);
                                  },
                                  child: DashboardContainer(
                                    width: 202,
                                    height: 112,
                                    color: kBrownColor,
                                    percent: '+11.01',
                                    title: kTotalCrime,
                                    totalNumber: '1200',
                                  )),
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
                                      },
                                      itemBuilder: (BuildContext context) => [
                                        const PopupMenuItem(
                                          value: 'Last 7 Days',
                                          child: Text('Last 7 Days'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Last 2 Weeks',
                                          child: Text('Last 2 Weeks'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Last 1 Month',
                                          child: Text('Last 1 Month'),
                                        ),
                                        const PopupMenuItem(
                                          value: 'Last 3 Months',
                                          child: Text('Last 3 Months'),
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
                              child: fl.BarChart(
                                fl.BarChartData(
                                  alignment: fl.BarChartAlignment.spaceBetween,
                                  maxY: 160,
                                  gridData: const fl.FlGridData(
                                      show: true,
                                      horizontalInterval: 40,
                                      drawHorizontalLine: false,
                                      drawVerticalLine: false),
                                  titlesData: fl.FlTitlesData(
                                    leftTitles: fl.AxisTitles(
                                      sideTitles: fl.SideTitles(
                                        showTitles: true,
                                        reservedSize: 32,
                                        interval: 40,
                                        getTitlesWidget: (value, meta) {
                                          if (value % 40 == 0) {
                                            return Text(
                                              value.toInt().toString(),
                                              style: TextStyle(
                                                color: kBarChartTextColor,
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
                                        getTitlesWidget: (value, meta) {
                                          TextStyle style =
                                              AppStyles.interTextStyle()
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11.sp,
                                                      color:
                                                          kBarChartTextColor);
                                          switch (value.toInt()) {
                                            case 0:
                                              return Text('Sep 10',
                                                  style: style);
                                            case 1:
                                              return Text('Sep 11',
                                                  style: style);
                                            case 2:
                                              return Text('Sep 12',
                                                  style: style);
                                            case 3:
                                              return Text('Sep 13',
                                                  style: style);
                                            case 4:
                                              return Text('Sep 14',
                                                  style: style);
                                            case 5:
                                              return Text('Sep 15',
                                                  style: style);
                                            case 6:
                                              return Text('Sep 16',
                                                  style: style);
                                            default:
                                              return const Text('');
                                          }
                                        },
                                      ),
                                    ),
                                    rightTitles: const fl.AxisTitles(
                                        sideTitles:
                                            fl.SideTitles(showTitles: false)),
                                    topTitles: const fl.AxisTitles(
                                        sideTitles:
                                            fl.SideTitles(showTitles: false)),
                                  ),
                                  borderData: fl.FlBorderData(
                                    show: false,
                                  ),
                                  barGroups: controller.barChartData,
                                ),
                              ),
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
                                  child: Column(
                                      children: [
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
                                        Obx(
                                          () => Center(
                                            child: PieChart(
                                              dataMap: controller.dataMap.value,
                                              chartRadius:
                                                  MediaQuery.of(context)
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
                                                showChartValuesInPercentage:
                                                    true,
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
                                              legendOptions:
                                                  const LegendOptions(
                                                showLegends: false,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
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
                                                  width: 79,
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
                                                      Text(label,
                                                          style: AppStyles
                                                                  .interTextStyle()
                                                              .copyWith(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color:
                                                                      kBlackColor1))
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ]),
                                ),
                                // flex: 1,
                              ),
                              Expanded(
                                // flex: 2,
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
                                              child: Text(
                                            "Weekly Reported Crimes",
                                            style: AppStyles.interTextStyle()
                                                .copyWith(
                                                    fontSize: 18.sp,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                },
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                  const PopupMenuItem(
                                                    value: 'Last 7 Days',
                                                    child: Text('Last 7 Days'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'Last 2 Weeks',
                                                    child: Text('Last 2 Weeks'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'Last 1 Month',
                                                    child: Text('Last 1 Month'),
                                                  ),
                                                  const PopupMenuItem(
                                                    value: 'Last 3 Months',
                                                    child:
                                                        Text('Last 3 Months'),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 37,
                                      ),
                                      SizedBox(
                                        height: 273,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 9, right: 9, top: 9),
                                          child: fl.BarChart(
                                            fl.BarChartData(
                                              alignment: fl.BarChartAlignment
                                                  .spaceBetween,
                                              maxY: 160,
                                              gridData: const fl.FlGridData(
                                                  show: true,
                                                  horizontalInterval: 40,
                                                  drawHorizontalLine: false,
                                                  drawVerticalLine: false),
                                              titlesData: fl.FlTitlesData(
                                                leftTitles: fl.AxisTitles(
                                                  sideTitles: fl.SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 32,
                                                    interval: 40,
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
                                                      TextStyle style = AppStyles
                                                              .interTextStyle()
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 11.sp,
                                                              color:
                                                                  kBarChartTextColor);
                                                      switch (value.toInt()) {
                                                        case 0:
                                                          return Text('Mon',
                                                              style: style);
                                                        case 1:
                                                          return Text('Tue',
                                                              style: style);
                                                        case 2:
                                                          return Text('Wed',
                                                              style: style);
                                                        case 3:
                                                          return Text('Thu',
                                                              style: style);
                                                        case 4:
                                                          return Text('Fri',
                                                              style: style);
                                                        case 5:
                                                          return Text('Sat',
                                                              style: style);
                                                        case 6:
                                                          return Text('Sun',
                                                              style: style);
                                                        default:
                                                          return const Text('');
                                                      }
                                                    },
                                                  ),
                                                ),
                                                rightTitles:
                                                    const fl.AxisTitles(
                                                        sideTitles:
                                                            fl.SideTitles(
                                                                showTitles:
                                                                    false)),
                                                topTitles: const fl.AxisTitles(
                                                    sideTitles: fl.SideTitles(
                                                        showTitles: false)),
                                              ),
                                              borderData: fl.FlBorderData(
                                                show: false,
                                              ),
                                              barGroups:
                                                  controller.barChartData,
                                            ),
                                          ),
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
