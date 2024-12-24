import 'package:crime_bee_admin/view/screens/dashboard/controller/dashboard_controller.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:crime_bee_admin/view/widgets/dashboard-container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_strings.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

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
                    Container(
                      height: 61,
                      decoration: const BoxDecoration(
                          border: Border(bottom: BorderSide(color: kBackGroundColor,width: 2))),
                      child: Padding(
                        padding: AppStyles().appBarPadding,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Dashboard',style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,color: kLightBlack1),),
                            const Spacer(),
                            Container(
                              height: 28,
                              width: 160,
                              decoration: BoxDecoration(
                                color: kBackGroundColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 130,
                                      child: MyCustomTextField(
                                        hintText: 'Search',
                                        contentPadding: EdgeInsets.all(0),
                                        prefixIcon: Icon(Icons.search_sharp,size: 13,color: kLightBlackColor,),
                                      ),
                                    ),
                                    Text(
                                      '⌘/',
                                      style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400,color: kLightBlackColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            SvgPicture.asset(
                              kNotificationIcon,
                              height: 20,
                              width: 20,
                              colorFilter: const ColorFilter.mode(
                                kLightBlackColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: AppStyles().paddingAll21,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(kToday,style: AppStyles.workSansTextStyle().copyWith(fontSize: 20.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(width: 8,),
                              const Icon(Icons.keyboard_arrow_down_outlined,size: 16,)
                            ],
                          ),
                          const SizedBox(height: 28,),
                          Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            children: [
                              DashboardContainer(width: 202,height: 112,color: kPrimaryColor,percent: '+11.01',title: kActiveVigi,totalNumber: '2200',),
                              DashboardContainer(width: 202,height: 112,color: kBlueColor,percent: '-0.03',title: kRevenue,totalNumber: '120',),
                              DashboardContainer(width: 202,height: 112,color: kBrownColor,percent: '+11.01',title: kTotalCrime,totalNumber: '1200',),
                            ],
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(kRevenueText,style: AppStyles.workSansTextStyle().copyWith(fontSize: 20.sp,fontWeight: FontWeight.w600),),
                              Row(
                                children: [
                                  Text('Last 7 Days',style: AppStyles.interTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                                  const SizedBox(width: 8,),
                                  const Icon(Icons.keyboard_arrow_down_outlined,size: 16,)
                                ],
                              ),

                            ],
                          ),
                          const SizedBox(height: 36,),
                          SizedBox(
                            height: 273,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 9,right: 9,top: 9),
                              child: fl.BarChart(
                                fl.BarChartData(
                                  alignment: fl.BarChartAlignment.spaceBetween,
                                  maxY: 160,
                                  gridData: const fl.FlGridData(
                                      show: true,
                                      horizontalInterval: 40,
                                      drawHorizontalLine: false,
                                      drawVerticalLine: false
                                  ),
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
                                          TextStyle style = AppStyles.interTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 11.sp,color: kBarChartTextColor);
                                          switch (value.toInt()) {
                                            case 0:
                                              return Text('Sep 10', style: style);
                                            case 1:
                                              return Text('Sep 11', style: style);
                                            case 2:
                                              return Text('Sep 12', style: style);
                                            case 3:
                                              return Text('Sep 13', style: style);
                                            case 4:
                                              return Text('Sep 14', style: style);
                                            case 5:
                                              return Text('Sep 15', style: style);
                                            case 6:
                                              return Text('Sep 16', style: style);
                                            default:
                                              return const Text('');
                                          }
                                        },
                                      ),
                                    ),
                                    rightTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
                                    topTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
                                  ),
                                  borderData: fl.FlBorderData(
                                    show: false,
                                  ),
                                  barGroups: controller.barChartData,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30,),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(32),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(child: Text(kCrimeType,style: AppStyles.interTextStyle().copyWith(fontSize: 20,fontWeight: FontWeight.w600),)),
                                        ],
                                      ),
                                      const SizedBox(height: 37,),
                                      Obx(
                                            () => PieChart(
                                          dataMap: controller.dataMap.value,
                                          chartRadius: MediaQuery.of(context).size.width / 5.9,
                                          chartType: ChartType.disc,
                                          ringStrokeWidth: 32,
                                          centerText: "",
                                          animationDuration: const Duration(seconds: 2),
                                          colorList: controller.colorList,
                                          chartValuesOptions: ChartValuesOptions(
                                            showChartValuesInPercentage: true,
                                            showChartValuesOutside: false,
                                            decimalPlaces: 0,
                                            showChartValueBackground: false,
                                            chartValueStyle: AppStyles.interTextStyle().copyWith( color: kWhiteColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,),
                                          ),
                                          legendOptions: const LegendOptions(
                                            showLegends: false,
                                          ),
                                        ),
                                      ),

        Wrap(
          runSpacing: 24,
          spacing: 24,
          children: List.generate(controller.dataMap.length, (index) {
            final label = controller.dataMap.keys.toList()[index];
            final color = controller.colorList[index];
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
                  Text(
                      label,
                      style: AppStyles.interTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400,color: kBlackColor1))
                ],
              ),
            );

          },
          ),
        ),
        ]
                                  ),
                                ),
                                // flex: 1,
                              ),
                              Expanded(
                                // flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(child: Text(kCrimeType,style: AppStyles.interTextStyle().copyWith(fontSize: 18.sp,fontWeight: FontWeight.w600),)),
                                          Row(
                                            children: [
                                              Text('Last 7 Days',style: AppStyles.interTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w400),),
                                              const SizedBox(width: 8,),
                                              const Icon(Icons.keyboard_arrow_down_outlined,size: 16,)
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 37,),
                                      SizedBox(
                                        height: 273,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 9,right: 9,top: 9),
                                          child: fl.BarChart(
                                            fl.BarChartData(
                                              alignment: fl.BarChartAlignment.spaceBetween,
                                              maxY: 160,
                                              gridData: const fl.FlGridData(
                                                  show: true,
                                                  horizontalInterval: 40,
                                                  drawHorizontalLine: false,
                                                  drawVerticalLine: false
                                              ),
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
                                                      TextStyle style = AppStyles.interTextStyle().copyWith(fontWeight: FontWeight.w400,fontSize: 11.sp,color: kBarChartTextColor);
                                                      switch (value.toInt()) {
                                                        case 0:
                                                          return Text('Mon', style: style);
                                                        case 1:
                                                          return Text('Tue', style: style);
                                                        case 2:
                                                          return Text('Wed', style: style);
                                                        case 3:
                                                          return Text('Thu', style: style);
                                                        case 4:
                                                          return Text('Fri', style: style);
                                                        case 5:
                                                          return Text('Sat', style: style);
                                                        case 6:
                                                          return Text('Sun', style: style);
                                                        default:
                                                          return const Text('');
                                                      }
                                                    },
                                                  ),
                                                ),
                                                rightTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
                                                topTitles: const fl.AxisTitles(sideTitles: fl.SideTitles(showTitles: false)),
                                              ),
                                              borderData: fl.FlBorderData(
                                                show: false,
                                              ),
                                              barGroups: controller.barChartData,
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
            Container(
              width: 200,
              decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: kBackGroundColor,width: 2))
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Notification",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16,),
                      Obx(() {
                        return SizedBox(
                          height: 252,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: controller.notifications.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final notification = controller.notifications[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          color: notification['backColor'],
                                          borderRadius: AppStyles.customBorder8,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            kUserIcon,
                                            height: 12,
                                            width: 12,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(notification['title']!,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                          Text(notification['time']!,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: kBlackColor.withOpacity(0.6))),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 24,),
                      Text("Activities",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16,),
                      Obx(() {
                        return SizedBox(
                          height: 300,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                              itemCount: controller.activities.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                final activity = controller.activities[index];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 24,
                                        width: 24,
                                        decoration: BoxDecoration(
                                          borderRadius: AppStyles.customBorderAll100,
                                          color: activity['backColor']
                                        ),
                                        child: ClipRRect(
                                          borderRadius: AppStyles.customBorderAll100,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              kUserIcon,
                                              height: 12,
                                              width: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(activity['title']!,
                                                style: AppStyles.workSansTextStyle()
                                                    .copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400),maxLines: 1,overflow: TextOverflow.ellipsis,),
                                            Text(activity['time']!,
                                                style: AppStyles.workSansTextStyle()
                                                    .copyWith(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    color: kBlackColor.withOpacity(0.6))),
                                          ],
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
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
