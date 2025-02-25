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

  Widget statusUpdateDialogue(BuildContext context,{required String userId}) {
    double width = MediaQuery.of(context).size.width;
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
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
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500,),
              ),
              Container(
                width: width,
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: AppStyles.customBorder8,
                    border: Border.all(color: kBorderColor,),
                ),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    dropdownColor: kWhiteColor,
                    focusColor:    kWhiteColor,
                    value: controller.selectedUserStatus.value.isNotEmpty
                        ? controller.selectedUserStatus.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,),
                      child: Text(
                        kStatus,
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 14.sp, color: kHintColor,),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.arrow_drop_down_outlined,
                          size: 25, color: kBlackColor.withOpacity(0.4),),
                    ),
                    underline: const SizedBox.shrink(),
                    items: ['Active', 'Suspend', 'Ban']
                        .map((String crime) => DropdownMenuItem<String>(
                              value: crime,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12,),
                                child: Text(
                                  crime,
                                  style: AppStyles.workSansTextStyle()
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      controller.selectedUserStatus.value = newValue!;
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
                    onTap: () {
                      Get.back();
                      controller.changeStatus(userId: userId,);
                    },
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
                            controller.isSetUpdate.value;
                            return FilterButton(
                              text: "Active",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Active");
                              },
                              width: 93,
                              borderColor: controller.selectedFilters.contains("Active".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Active".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Active".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            controller.isSetUpdate.value;
                            return FilterButton(
                              text: "Suspended",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Suspended");
                              },
                              width: 127,
                              borderColor:
                              controller.selectedFilters.contains("Suspended".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Suspended".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Suspended".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,);
                          },),

                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            controller.isSetUpdate.value;
                            return FilterButton(
                              text: "Ban",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Ban");
                              },
                              width: 76,
                              borderColor: controller.selectedFilters.contains("Ban".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Ban".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Ban".toLowerCase())
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
                              controller.isTableUpdate.toggle();
                            },
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
                    const SizedBox(
                      height: 20,
                    ),
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
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,),
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
                                              0.2,),),
                                          // contentPadding: const EdgeInsets.only(top: 9),
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
                                            BorderSide.none,),
                                          enabledBorder:
                                          const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide.none,),
                                          border:
                                          const UnderlineInputBorder(
                                            borderSide:
                                            BorderSide.none,),),
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
                                          .withOpacity(0.2),),
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
                              border: Border.all(color: kTableBorderColor,),),
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
                                    fontWeight: FontWeight.w600,),
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
                                    fontWeight: FontWeight.w600,),
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
                                    controller.selectedFilters.clear();
                                    controller.isTableUpdate.toggle();
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
                                color: kTableBorderColor, width: 1,),
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
                                  child: Obx(() {
                                    if (controller.isUserLoading.value) {
                                      return SizedBox(
                                        height: 500.h,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    controller.isTableUpdate.value;
                                    return DataTable(
                                      headingRowHeight: 49,
                                      columns: [
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              "User ID",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles
                                                  .workSansTextStyle()
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
                                              style: AppStyles
                                                  .workSansTextStyle()
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
                                              style: AppStyles
                                                  .workSansTextStyle()
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
                                              style: AppStyles
                                                  .workSansTextStyle()
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
                                              style: AppStyles
                                                  .workSansTextStyle()
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: controller.users.where((test) {
                                        if (controller
                                            .selectedFilters.isEmpty) {
                                          return true;
                                        } else if (controller.selectedFilters
                                            .contains(
                                            test.status.toLowerCase())) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      }).map((user) {
                                        return _buildDataRow(
                                          user.userId,
                                          user.name,
                                          user.vigilantePoints,
                                          user.status,
                                          context,
                                        );
                                      }).toList(),
                                      dataRowMaxHeight: 65,
                                    );
                                  }),
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
                                onTap: controller.goToPreviousPage,
                                child: Obx(() {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.currentPage.value<=3
                                          ? kBackGroundColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: 12,
                                          color: controller.currentPage.value<=3
                                              ? kBlackColor
                                              : kWhiteColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Back',
                                          style:
                                          AppStyles.interTextStyle().copyWith(
                                            fontSize: 12,
                                            color: controller.currentPage.value<=3
                                                ? kBlackColor
                                                : kWhiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Obx(() {
                                return Row(
                                  children: [
                                    if(controller.currentPage.value>3)...[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: GestureDetector(
                                          onTap: () => controller.changePage(1),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: controller.currentPage.value == 1
                                                  ? kPrimaryColor
                                                  : kBackGroundColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                (1).toString(),
                                                style: AppStyles.interTextStyle()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: controller.currentPage.value == 1
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: controller.currentPage.value == 1
                                                ? kPrimaryColor
                                                : kBackGroundColor,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "...",
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                fontSize: 12,
                                                color: controller.currentPage.value == 1
                                                    ? kWhiteColor
                                                    : kBlackColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.changePage(controller.currentPage.value-1);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kBackGroundColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${controller.currentPage.value-1}",
                                                style: AppStyles.interTextStyle()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8,
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (controller.currentPage.value).toString(),
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                fontSize: 12,
                                                color:  kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if(controller.currentPage.value<controller.totalPages.value)...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          child: GestureDetector(
                                            onTap: (){
                                              controller.changePage(controller.currentPage.value+1);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: kBackGroundColor,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${controller.currentPage.value+1}",
                                                  style: AppStyles.interTextStyle()
                                                      .copyWith(
                                                    fontSize: 12,
                                                    color: kBlackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: controller.currentPage.value == 1
                                                  ? kPrimaryColor
                                                  : kBackGroundColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "...",
                                                style: AppStyles.interTextStyle()
                                                    .copyWith(
                                                  fontSize: 12,
                                                  color: controller.currentPage.value == 1
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.changePage(controller.totalPages.value);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller.currentPage.value == controller.totalPages.value
                                                    ? kPrimaryColor
                                                    : kBackGroundColor,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${controller.totalPages.value}",
                                                  style: AppStyles.interTextStyle()
                                                      .copyWith(
                                                    fontSize: 12,
                                                    color: controller.currentPage.value == controller.totalPages.value
                                                        ? kWhiteColor
                                                        : kBlackColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ],
                                    if(controller.currentPage.value<=3)...[
                                      ...List.generate(
                                        controller.totalPages.value>3 ? 3 : controller.totalPages.value,
                                            (index) {
                                          bool isSelected =
                                              index + 1 == controller.currentPage.value;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: GestureDetector(
                                              onTap: () =>
                                                  controller.changePage(index + 1),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 12,
                                                ),
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
                                    ],
                                  ],
                                );
                              }),
                              const SizedBox(
                                width: 12,
                              ),
                              GestureDetector(
                                onTap: controller.goToNextPage,
                                child: Obx(() {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.currentPage.value==controller.totalPages.value
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
                                          style:
                                          AppStyles.interTextStyle().copyWith(
                                            fontSize: 12,
                                            color: controller.currentPage.value==controller.totalPages.value
                                                ? kBlackColor
                                                : kWhiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,
                                          size: 12,
                                          color: controller.currentPage.value==controller.totalPages.value
                                              ? kBlackColor
                                              : kWhiteColor,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
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

  DataRow _buildDataRow(String id, String name, int reports, String status,
      BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (status == "suspend") {
      status = "suspended";
    }
    return DataRow(
      cells: [
        DataCell(
          SelectableText(
            id,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: AppStyles.workSansTextStyle().copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              reports.toString(),
              textAlign: TextAlign.center,
              style: AppStyles.workSansTextStyle().copyWith(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: width * 0.08,
                  // height: 27,
                  decoration: BoxDecoration(
                    color: status.toLowerCase() == "suspended"
                        ? kLightBlue.withOpacity(0.2)
                        : status.toLowerCase() == "active"
                            ? kBrownColor.withOpacity(0.2)
                            : kPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Center(
                      child: Text(
                        GetUtils.camelCase(status) ?? status,
                        style: AppStyles.workSansTextStyle().copyWith(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: status.toLowerCase() == "suspended"
                              ? kLightBlue
                              : status.toLowerCase() == "active"
                                  ? kBrownColor
                                  : kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                border: Border.all(
                  color: kTableBorderColor,
                  width: 0,
                ),
              ),
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
                              return statusUpdateDialogue(
                                context,
                                userId: id,
                              );
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
                                onDelete: () {
                                  Get.back();
                                  controller.deleteUser(
                                    userId: id,
                                  );
                                },
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
