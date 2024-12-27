import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/screens/dashboard/controller/dashboard_controller.dart';
import 'package:crime_bee_admin/view/widgets/delete_dialog.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:crime_bee_admin/view/widgets/dashboard-container.dart';
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
import 'controller/user_controller.dart';

class UserScreen extends GetView<UserController> {
  const UserScreen({super.key});

  Widget statusUpdateDialogue(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
        height: 252,
        width: 400,
        child: Padding(
          padding: AppStyles().paddingAll24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: SvgPicture.asset(
                      kCrossIcon,
                      height: 16,
                      width: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                "Update Status",
                style: AppStyles.workSansTextStyle()
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: AppStyles.customBorder8,
                    border: Border.all(color: kBorderColor)),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    focusColor: kWhiteColor,
                    value: controller.selectedCrimeType.value.isNotEmpty
                        ? controller.selectedCrimeType.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        kStatus,
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 14.sp, color: kHintColor),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.arrow_drop_down_outlined,
                          size: 25, color: kBlackColor.withOpacity(0.4)),
                    ),
                    underline: const SizedBox.shrink(),
                    items: ['Approved', 'Suspend', 'Ban']
                        .map((String crime) => DropdownMenuItem<String>(
                              value: crime,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  crime,
                                  style: AppStyles.workSansTextStyle()
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      controller.selectedCrimeType.value = newValue!;
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 52,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    text: "Cancel",
                    height: 40,
                    onTap: () {
                      Get.back();
                    },
                    width: 75,
                    textColor: kBlackColor,
                    color: kWhiteColor,
                    borderColor: kFieldBorderColor,
                    fontSize: 14.sp,
                  ),
                  CustomButton(
                    text: "Update Now",
                    height: 40,
                    onTap: () {},
                    width: 110,
                    color: kPrimaryColor,
                    fontSize: 14.sp,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
                        "Select User Status",
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return FilterButton(
                              text: "Active",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Active");
                              },
                              width: 93,
                              borderColor: controller.selectedFilters.contains("Active")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Active")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Active")
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            return FilterButton(
                              text: "Suspended",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Suspended");
                              },
                              width: 127,
                              borderColor:
                              controller.selectedFilters.contains("Suspended")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Suspended")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Suspended")
                                  ? kWhiteColor
                                  : kBlackColor,);
                          },),

                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            return FilterButton(
                              text: "Ban",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Ban");
                              },
                              width: 76,
                              borderColor: controller.selectedFilters.contains("Ban")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Ban")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Ban")
                                  ? kWhiteColor
                                  : kBlackColor,);
                          },),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 44,),
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
                        "*You can choose multiple user status",
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
                            },
                            width: 75,
                            textColor: kBlackColor,
                            color: kWhiteColor,
                            borderColor: kFieldBorderColor,
                            fontSize: 14.sp,
                          ),
                          CustomButton(
                            text: "ApplyFilter",
                            height: 40,
                            onTap: () {
                              Get.back();
                            },
                            width: 110,
                            color: kPrimaryColor,
                            fontSize: 14.sp,
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
    },
        child: Obx(
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
                      SizedBox(height: 20,),
                      Padding(
                        padding: AppStyles().horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              kUserManagement,
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 32.sp, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            Container(
                              height: 28,
                              width: 252,
                              decoration: BoxDecoration(
                                color: kWhiteColor,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: kFieldBorderColor)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox(
                                      width: 220,
                                      child: MyCustomTextField(
                                        hintText: 'Search',
                                        fillColor: kWhiteColor,
                                        contentPadding: EdgeInsets.all(0),
                                        prefixIcon: Icon(
                                          Icons.search_sharp,
                                          size: 13,
                                          color: kLightBlackColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '⌘/',
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: kLightBlackColor),
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
                                child: SvgPicture.asset(
                                  kNotificationIcon,
                                  height: 20,
                                  width: 20,
                                  colorFilter: const ColorFilter.mode(
                                    kLightBlackColor,
                                    BlendMode.srcIn,
                                  ),
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
                              width: width / 3,
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
                                    "User Status",
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
                                    onTap: (){
                                      controller.selectedFilters.clear();
                                    },
                                    child: Text(
                                      "Reset Filter",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: kPrimaryColor),
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
                                                fontSize: 13.sp,
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
                                                fontSize: 13.sp,
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
                                              "Reports Posted",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
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
                                                fontSize: 13.sp,
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
                                              "Actions",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style:
                                                  AppStyles.workSansTextStyle()
                                                      .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: controller.currentPageUsers
                                          .map((user) => _buildDataRow(
                                              user['id']!,
                                              user['name']!,
                                              user['reports']!,
                                              user['status']!,
                                              user['StatusColor'],
                                              user['statusBackColor'],
                                              context))
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
                                          ? kBackGroundColor
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
                                  controller.totalPages,
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
                                // const SizedBox(width: 12,),
                                GestureDetector(
                                  onTap: controller.isNextButtonDisabled
                                      ? null
                                      : controller.goToNextPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isNextButtonDisabled
                                          ? kTableBorderColor
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

  DataRow _buildDataRow(String id, String name, int reports, String status,
      Color statusColor, Color statusBackColor, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(
          id,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600),
        )),
        DataCell(Center(
            child: Text(
          name,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ))),
        DataCell(Center(
            child: Text(
          reports.toString(),
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 13.sp, fontWeight: FontWeight.w600),
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
        DataCell(
          Center(
            child: Container(
              height: 32,
              width: 96,
              decoration: BoxDecoration(
                  borderRadius: AppStyles.customBorder8,
                  color: kActionsBtnColor,
                  border: Border.all(color: kTableBorderColor, width: 0)),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return statusUpdateDialogue(context);
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          kEditIcon,
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: kLightGreyColor,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DeleteDialog(
                                onDelete: () {},
                              );
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          kDeleteIcon,
                          height: 18,
                          width: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
