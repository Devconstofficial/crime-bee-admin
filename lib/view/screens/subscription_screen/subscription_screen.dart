import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/screens/subscription_screen/controller/subcription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';

class SubscriptionScreen extends GetView<SubscriptionController> {
  const SubscriptionScreen({super.key});

  Widget filterPopup(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
        width: 400,
        child: SingleChildScrollView(
          child: Padding(
            padding: AppStyles().vertical24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: AppStyles().horizontal24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select Subscription Type",
                        style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(
                            () {
                              return FilterButton(
                                text: "Monthly",
                                height: 34,
                                onTap: () {
                                  controller.toggleFilter("Monthly");
                                },
                                width: 87,
                                borderColor: controller.selectedFilters
                                        .contains("Monthly")
                                    ? kWhiteColor
                                    : kActionsButtonColor,
                                color: controller.selectedFilters
                                        .contains("Monthly")
                                    ? kPrimaryColor
                                    : kWhiteColor,
                                fontSize: 14,
                                textColor: controller.selectedFilters
                                        .contains("Monthly")
                                    ? kWhiteColor
                                    : kBlackColor,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(
                            () {
                              return FilterButton(
                                text: "Annually",
                                height: 34,
                                onTap: () {
                                  controller.toggleFilter("Annually");
                                },
                                width: 121,
                                borderColor: controller.selectedFilters
                                        .contains("Annually")
                                    ? kWhiteColor
                                    : kActionsButtonColor,
                                color: controller.selectedFilters
                                        .contains("Annually")
                                    ? kPrimaryColor
                                    : kWhiteColor,
                                fontSize: 14,
                                textColor: controller.selectedFilters
                                        .contains("Annually")
                                    ? kWhiteColor
                                    : kBlackColor,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
                const Divider(),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: AppStyles().horizontal24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "*You can choose multiple type",
                        style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: kBlackColor1.withOpacity(0.7)),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(
                            text: "Cancel",
                            height: 40,
                            onTap: () {
                              Get.back();
                              controller.selectedFilters.clear();
                            },
                            width: 75,
                            textColor: kBlackColor,
                            color: kWhiteColor,
                            borderColor: kFieldBorderColor,
                            fontSize: 14,
                          ),
                          CustomButton(
                            text: "ApplyFilter",
                            height: 40,
                            onTap: () {
                              Get.back();
                              controller.currentPage.value = 1;
                              controller.applySearchAndPaginate();
                            },
                            width: 110,
                            color: kPrimaryColor,
                            fontSize: 14,
                          ),
                          
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(onTap: () {
      CommonCode.unFocus(context);
    }, child: Obx(
      () {
        return Scaffold(
          body: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SideMenu(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding: AppStyles().horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              kSubscriptionManagement,
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 32.sp, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Container(
                              height: 41,
                              width: width / 4.5,
                              decoration: BoxDecoration(
                                  color: kWhiteColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: kFieldBorderColor)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 3),
                                      child: SizedBox(
                                        width: width / 5.5,
                                        child: TextField(
                                          onChanged: (value) {
                                            controller.updateSearchQuery(value);
                                          },
                                          style: AppStyles.workSansTextStyle()
                                              .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400),
                                          decoration: InputDecoration(
                                              hintText: 'Search',
                                              fillColor: kWhiteColor,
                                              hintStyle:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ksuffixColor
                                                              .withOpacity(
                                                                  0.2)),
                                              prefixIcon: Icon(
                                                Icons.search_sharp,
                                                size: 16,
                                                color: ksuffixColor
                                                    .withOpacity(0.2),
                                              ),
                                              focusColor: kWhiteColor,
                                              hoverColor: kWhiteColor,
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none),
                                              border:
                                                  const UnderlineInputBorder(
                                                      borderSide:
                                                          BorderSide.none)),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '⌘/',
                                      style: AppStyles.interTextStyle()
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: ksuffixColor
                                                  .withOpacity(0.2)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  controller.toggleNotificationVisibility();
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
                      ),
                      Padding(
                        padding: AppStyles().paddingAll21,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 70,
                              width: 358,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kFilterContainerColor,
                                  border: Border.all(color: kTableBorderColor)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    kFilterIcon,
                                    height: 23,
                                    width: 20,
                                  ),
                                  Container(
                                    width: 1,
                                    color: kLightGreyColor,
                                  ),
                                  Text(
                                    kFilterBy,
                                    style: AppStyles.workSansTextStyle()
                                        .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  Container(
                                    width: 1,
                                    color: kLightGreyColor,
                                  ),
                                  Text(
                                    "Subscription Type",
                                    style: AppStyles.workSansTextStyle()
                                        .copyWith(
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return filterPopup(context);
                                          },
                                        );
                                      },
                                      child: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 24,
                                        color: kPrimaryColor,
                                      )),
                                      Container(
                                  width: 1,
                                  color: kLightGreyColor,
                                ),
                                const Icon(
                                  Icons.refresh,
                                  color: kPrimaryColor,
                                  size: 18,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.clearFilters();
                                  },
                                  child: Text(
                                    "Reset Filter",
                                    style: AppStyles.workSansTextStyle()
                                        .copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: kPrimaryColor,),
                                  ),
                                ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Container(
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(14),
                                  topRight: Radius.circular(14),
                                ),
                                border: Border.all(
                                    color: kTableBorderColor, width: 1),
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 49,
                                    decoration: const BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(14),
                                        topRight: Radius.circular(14),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width,
                                    child: DataTable(
                                      headingRowHeight: 49,
                                      columns: [
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              "User ID",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Flexible(
                                            child: Text(
                                              "Name",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Flexible(
                                            child: Text(
                                              "Type",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Flexible(
                                            child: Text(
                                              "Status",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          headingRowAlignment:
                                              MainAxisAlignment.center,
                                          label: Flexible(
                                            child: Text(
                                              "Revenue",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: controller.subscriptionsList
                                          .map((user) => _buildDataRow(
                                                user['user']['_id'],
                                                user['user']['name'] ?? '',
                                                user['amount'],
                                                user['status'] ?? '',
                                                _formatSubscriptionType(
                                                    user['type']),
                                                (user['status'] == 'expired' ||
                                                        user['status'] ==
                                                            'inactive')
                                                    ? kPrimaryColor
                                                    : user['status'] ==
                                                            'cancelled'
                                                        ? kBrownColor
                                                        : kLightBlue,
                                                (user['status'] == 'expired' ||
                                                        user['status'] ==
                                                            'inactive')
                                                    ? kPrimaryColor
                                                        .withOpacity(0.2)
                                                    : user['status'] ==
                                                            'cancelled'
                                                        ? kBrownColor
                                                            .withOpacity(0.2)
                                                        : kLightBlue
                                                            .withOpacity(0.2),
                                                context,
                                              ))
                                          .toList(),
                                      dataRowMaxHeight: 65,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 51,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: controller.isBackButtonDisabled
                                      ? null
                                      : controller.goToPreviousPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isBackButtonDisabled
                                          ? kTableBorderColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back_ios_new_outlined,
                                            size: 12,
                                            color:
                                                controller.isBackButtonDisabled
                                                    ? kBlackColor
                                                    : kWhiteColor),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Back',
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color:
                                                controller.isNextButtonDisabled
                                                    ? kWhiteColor
                                                    : kBlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                ...List.generate(
                                  controller.totalPages.value,
                                  (index) {
                                    bool isSelected = index + 1 ==
                                        controller.currentPage.value;
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.changePage(index + 1),
                                      child: Padding(
                                        padding:
                                            AppStyles().paginationBtnPadding,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? kPrimaryColor
                                                : kBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (index + 1).toString(),
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                fontSize: 12,
                                                color: isSelected
                                                    ? kWhiteColor
                                                    : kBlackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: controller.isNextButtonDisabled
                                      ? null
                                      : controller.goToNextPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isNextButtonDisabled
                                          ? kBackGroundColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Next',
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color:
                                                controller.isNextButtonDisabled
                                                    ? kBlackColor
                                                    : kWhiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,
                                            size: 12,
                                            color:
                                                controller.isNextButtonDisabled
                                                    ? kBlackColor
                                                    : kWhiteColor),
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
        );
      },
    ));
  }

  DataRow _buildDataRow(
      String id,
      String name,
      double revenue,
      String payStatus,
      String status,
      Color statusColor,
      Color statusBackColor,
      context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(
          id,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        )),
        DataCell(Center(
            child: Text(
          name,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ))),
        DataCell(
          Center(
            child: Container(
              width: width * 0.08,
              height: 27,
              decoration: BoxDecoration(
                color: statusBackColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: Text(
                    status,
                    style: AppStyles.workSansTextStyle().copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: statusColor),
                  ),
                ),
              ),
            ),
          ),
        ),
        DataCell(Center(
            child: Text(
          payStatus,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ))),
        DataCell(Center(
            child: Text(
          "\$${revenue.toString()}",
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ))),
      ],
    );
  }

  String _formatSubscriptionType(dynamic type) {
    final typeStr = type?.toString().toLowerCase() ?? '';

    if (typeStr.contains('monthly')) return 'Monthly';
    if (typeStr.contains('annual')) return 'Annually';
    return type?.toString() ?? '';
  }
}
