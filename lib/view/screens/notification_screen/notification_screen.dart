import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/models/notification_model.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  Widget addNotificationDialogue() {
    double width = Get.width;
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
              SizedBox(
                height: Get.height * 0.05,
              ),
              Text(
                "Notification type",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 48,
                width: width,
                decoration: BoxDecoration(
                  color: kBackGroundColor,
                  borderRadius: AppStyles.customBorder8,
                  border: Border.all(
                    color: kFieldBorderColor,
                  ),
                ),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    focusColor: kWhiteColor,
                    dropdownColor: kWhiteColor,
                    value: controller.selectedNotificationType.value.isNotEmpty
                        ? controller.selectedNotificationType.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "type",
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 14, color: kHintColor),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.arrow_drop_down_outlined,
                          size: 25, color: kBlackColor.withOpacity(0.4)),
                    ),
                    underline: const SizedBox.shrink(),
                    items: ['Crime Alert', 'General', 'Update']
                        .map((String crime) => DropdownMenuItem<String>(
                              value: crime,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  crime,
                                  style: AppStyles.workSansTextStyle().copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      controller.selectedNotificationType.value = newValue!;
                    },
                  );
                }),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                "Title",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyCustomTextField(
                hintText: "Title",
                fillColor: kBackGroundColor,
                borderColor: kFieldBorderColor,
                controller: controller.titleController,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                "Description",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              MyCustomTextField(
                hintText: "Description",
                fillColor: kBackGroundColor,
                borderColor: kFieldBorderColor,
                controller: controller.descriptionController,
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Text(
                "Specify audience",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                height: 48,
                width: width,
                decoration: BoxDecoration(
                  color: kBackGroundColor,
                  borderRadius: AppStyles.customBorder8,
                  border: Border.all(
                    color: kFieldBorderColor,
                  ),
                ),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    focusColor: kWhiteColor,
                    dropdownColor: kWhiteColor,
                    value: controller.allUserType.value.isNotEmpty
                        ? controller.allUserType.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        "All users",
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 14, color: kHintColor),
                      ),
                    ),
                    icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Icon(Icons.arrow_drop_down_outlined,
                          size: 25, color: kBlackColor.withOpacity(0.4)),
                    ),
                    underline: const SizedBox.shrink(),
                    items: [
                      'All Users',
                      'Specific UserId',
                    ].map((String crime) => DropdownMenuItem<String>(
                              value: crime,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  crime,
                                  style: AppStyles.workSansTextStyle()
                                      .copyWith(fontSize: 14),
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? newValue) {
                      if(newValue==null)return;
                      controller.allUserType.value = newValue;
                      controller.showSpecificUserField.value = newValue=="Specific UserId";
                    },
                  );
                }),
              ),
              Obx(() {
                if(!controller.showSpecificUserField.value) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Text(
                      "User Id",
                      style: AppStyles.workSansTextStyle().copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      height: 48,
                      width: width,
                      decoration: BoxDecoration(
                        color: kBackGroundColor,
                        borderRadius: AppStyles.customBorder8,
                        border: Border.all(
                          color: kFieldBorderColor,
                        ),
                      ),
                      child: MyCustomTextField(
                        hintText: "User id",
                        fillColor: kBackGroundColor,
                        borderColor: kFieldBorderColor,
                        controller: controller.specificUserId,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(
                height: Get.height * 0.08,
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
                    textColor: kBlackColor,
                    color: kWhiteColor,
                    borderColor: kFieldBorderColor,
                    fontSize: 14,
                  ),
                  CustomButton(
                    text: "Create Notification",
                    height: 40,
                    onTap: controller.addNewNotification,
                    color: kPrimaryColor,
                    fontSize: 14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget filterPopup() {
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
                        "Select Push Notifications",
                        style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: "Crime Alert",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Crime Alert");
                              },
                              borderColor: controller.selectedFilters
                                      .contains("Crime Alert".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters
                                      .contains("Crime Alert".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters
                                      .contains("Crime Alert".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          }),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: "Update",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Update");
                              },
                              borderColor: controller.selectedFilters
                                      .contains("Update".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters
                                      .contains("Update".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters
                                      .contains("Update".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          }),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: "General",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("General");
                              },
                              borderColor: controller.selectedFilters
                                      .contains("General".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters
                                      .contains("General".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters
                                      .contains("General".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          }),
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
                          color: kBlackColor1.withOpacity(0.7),
                        ),
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
                              controller.isTableUpdate.toggle();
                              Get.back();
                            },
                            width: 110,
                            color: kPrimaryColor,
                            fontSize: 14,
                          ),
                        ],
                      ),
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
                      height: 21,
                    ),
                    Padding(
                      padding: AppStyles().horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Push Notifications",
                            style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 41,
                            width: width / 4.5,
                            decoration: BoxDecoration(
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: kFieldBorderColor,
                              ),
                            ),
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
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: 'Search',
                                          fillColor: kWhiteColor,
                                          hintStyle:
                                              AppStyles.workSansTextStyle()
                                                  .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: ksuffixColor.withOpacity(
                                              0.2,
                                            ),
                                          ),
                                          // contentPadding: const EdgeInsets.only(top: 9),
                                          prefixIcon: Icon(
                                            Icons.search_sharp,
                                            size: 16,
                                            color:
                                                ksuffixColor.withOpacity(0.2),
                                          ),
                                          focusColor: kWhiteColor,
                                          hoverColor: kWhiteColor,
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                          border: const UnderlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '⌘/',
                                    style: AppStyles.interTextStyle().copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ksuffixColor.withOpacity(0.2),
                                    ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 70,
                                width: 287,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kFilterContainerColor,
                                  border: Border.all(
                                    color: kTableBorderColor,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                      style: AppStyles.workSansTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: kLightGreyColor,
                                    ),
                                    Text(
                                      "Type",
                                      style: AppStyles.workSansTextStyle().copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.dialog(
                                          filterPopup(),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 24,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomButton(
                                text: "Create Notification",
                                height: 56,
                                width: 220,
                                onTap: () {
                                  Get.dialog(
                                    addNotificationDialogue(),
                                  );
                                },
                              ),
                            ],
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
                                color: kTableBorderColor,
                                width: 1,
                              ),
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
                                    if (controller.isDataLoading.value) {
                                      return const SizedBox(
                                        height: 500,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                    controller.isTableUpdate.value;
                                    if (controller.notifications.isEmpty) {
                                      return const SizedBox(
                                        height: 500,
                                        child: Center(
                                          child: Text("No data to show. create new to view here"),
                                        ),
                                      );
                                    }
                                    return DataTable(
                                      headingRowHeight: 49,
                                      columns: [
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              'Title',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              'Type',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              'Date',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Flexible(
                                            child: Text(
                                              'User Type',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles.workSansTextStyle()
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
                                              kActions,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: controller.notifications
                                          .where((test) {
                                        if (controller
                                            .selectedFilters.isEmpty) {
                                          return true;
                                        } else if (controller.selectedFilters
                                            .contains(
                                            (test.data["type"]??"").toLowerCase())) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      }).map((notification) => _buildDataRow(notification)
                                      ).toList(),
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
                                      color: controller.currentPage.value <= 3
                                          ? kBackGroundColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: 12,
                                          color:
                                              controller.currentPage.value <= 3
                                                  ? kBlackColor
                                                  : kWhiteColor,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Back',
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color:
                                                controller.currentPage.value <=
                                                        3
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
                                    if (controller.currentPage.value > 3) ...[
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
                                              color: controller
                                                          .currentPage.value ==
                                                      1
                                                  ? kPrimaryColor
                                                  : kBackGroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                (1).toString(),
                                                style:
                                                    AppStyles.interTextStyle()
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: controller.currentPage
                                                              .value ==
                                                          1
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
                                            color:
                                                controller.currentPage.value ==
                                                        1
                                                    ? kPrimaryColor
                                                    : kBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "...",
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                fontSize: 12,
                                                color: controller.currentPage
                                                            .value ==
                                                        1
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
                                            controller.changePage(
                                                controller.currentPage.value -
                                                    1);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: kBackGroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${controller.currentPage.value - 1}",
                                                style:
                                                    AppStyles.interTextStyle()
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
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (controller.currentPage.value)
                                                  .toString(),
                                              style: AppStyles.interTextStyle()
                                                  .copyWith(
                                                fontSize: 12,
                                                color: kWhiteColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (controller.currentPage.value <
                                          controller.totalPages.value) ...[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 6,
                                          ),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.changePage(
                                                  controller.currentPage.value +
                                                      1);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: kBackGroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${controller.currentPage.value + 1}",
                                                  style:
                                                      AppStyles.interTextStyle()
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
                                              color: controller
                                                          .currentPage.value ==
                                                      1
                                                  ? kPrimaryColor
                                                  : kBackGroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "...",
                                                style:
                                                    AppStyles.interTextStyle()
                                                        .copyWith(
                                                  fontSize: 12,
                                                  color: controller.currentPage
                                                              .value ==
                                                          1
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
                                              controller.changePage(
                                                  controller.totalPages.value);
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: controller.currentPage
                                                            .value ==
                                                        controller
                                                            .totalPages.value
                                                    ? kPrimaryColor
                                                    : kBackGroundColor,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "${controller.totalPages.value}",
                                                  style:
                                                      AppStyles.interTextStyle()
                                                          .copyWith(
                                                    fontSize: 12,
                                                    color: controller
                                                                .currentPage
                                                                .value ==
                                                            controller
                                                                .totalPages
                                                                .value
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
                                    if (controller.currentPage.value <= 3) ...[
                                      ...List.generate(
                                        controller.totalPages.value > 3
                                            ? 3
                                            : controller.totalPages.value,
                                        (index) {
                                          bool isSelected = index + 1 ==
                                              controller.currentPage.value;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 6),
                                            child: GestureDetector(
                                              onTap: () => controller
                                                  .changePage(index + 1),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                    style: AppStyles
                                                            .interTextStyle()
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
                                      color: controller.currentPage.value ==
                                              controller.totalPages.value
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
                                            color: controller
                                                        .currentPage.value ==
                                                    controller.totalPages.value
                                                ? kBlackColor
                                                : kWhiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios_outlined,
                                          size: 12,
                                          color: controller.currentPage.value ==
                                                  controller.totalPages.value
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
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              return Visibility(
                visible: controller.isNotificationVisible.value,
                child: NotificationAndActivitySection(
                  notifications: controller.rawNotifications,
                  activities: controller.activities,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(NotificationModel notification) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            notification.title,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            notification.data["type"] ?? "Crime Alert",
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            DateFormat("dd/MMM/yyyy").format(DateTime.parse(notification.createdAt,),),
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Text(
            notification.recipient.userId.isEmpty ? "All" : notification.recipient.userId,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
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
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // InkWell(
                    //   onTap: (){
                    //     Get.dialog(
                    //       addNotificationDialogue(),
                    //     );
                    //   },
                    //   child: SvgPicture.asset(
                    //     kEditIcon,
                    //     height: 17,
                    //     width: 17,
                    //   ),
                    // ),
                    // Container(
                    //   width: 1,
                    //   color: kLightGreyColor,
                    // ),
                    InkWell(
                      onTap: () {
                        Get.dialog(
                          DeleteDialog(
                            onDelete: () {
                              Get.back();
                              controller.deleteNotificationById(
                                notification.notificationId,
                              );
                            },
                          ),
                        );
                      },
                      child: SvgPicture.asset(
                        kDeleteIcon,
                        height: 15,
                        width: 15,
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
