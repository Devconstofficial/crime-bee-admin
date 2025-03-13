import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/models/comment_model.dart';
import 'package:crime_bee_admin/view/screens/crime_details_screen/crime_details_controller.dart';
import 'package:crime_bee_admin/view/screens/crime_details_screen/crime_details_screen.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/custom_image_widget.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/comment_controller.dart';

class CommentScreen extends GetView<CommentController> {
  const CommentScreen({super.key});

  Widget seeCommentDialog({required CommentModel commentModel}) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
        width: 400,
        child: SingleChildScrollView(
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
                Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        borderRadius: AppStyles.customBorderAll100,
                      ),
                      child: ClipRRect(
                        borderRadius: AppStyles.customBorderAll100,
                        child: CustomImageWidget(
                          imageAddress: controller.selectedComment.commentedBy.profilePic,
                          errorWidget: const Icon(Icons.person),
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        controller.selectedComment.commentedBy.name,
                        style: AppStyles.headingTextStyle().copyWith(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w600,
                          overflow: TextOverflow.ellipsis,
                        ),
                        maxLines: 1,

                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  "Comment",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "Comment",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.commentController,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  "Associated Post/Thread",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "Associated Post/Thread",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.threadController,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      text: "View Full Post",
                      height: 25,
                      width: 123,
                      fontSize: 13.sp,
                      onTap: () {
                        Get.back();
                        final controller = Get.put(CrimeDetailsController());
                        controller.getCrimeDetails(crimeId: commentModel.postId,);
                        Get.dialog(
                          Center(
                            child: SizedBox(
                              width: 500.w,
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: const CrimeDetailsScreen(),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  "User Details",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "UserName",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "username",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.usernameController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Joined",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "joined",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.joinedController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Contributions",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "contributions",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.contributionsController,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Flagged Comments",
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: kBlack2Color,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: MyCustomTextField(
                    hintText: "flagged",
                    fillColor: kWhiteColor,
                    enabled: false,
                    borderColor: kFieldBorderColor,
                    controller: controller.flaggedCommentController,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
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
                    ),
                    CustomButton(
                      text: "Delete Comment",
                      height: 40,
                      onTap: () {
                        Get.back();
                        controller.deleteComment(
                          commentId: commentModel.commentId,
                        );
                      },
                      width: 140,
                      color: kPrimaryColor,
                      fontSize: 14,
                    ),
                  ],
                ),
              ],
            ),
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
                        "Select Date Range",
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: "Last 7 days",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Last 7 days");
                              },
                              borderColor: controller.selectedFilters.contains("Last 7 days".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Last 7 days".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Last 7 days".toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: "Last 30 days",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Last 30 days");
                              },
                              borderColor:
                              controller.selectedFilters.contains("Last 30 days".toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Last 30 days".toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Last 30 days".toLowerCase())
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
    double width = Get.width;
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
                            "Flag Comments",
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
                                            color:
                                                ksuffixColor.withOpacity(0.2),
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
                          Container(
                            height: 70,
                            width: 311,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: kFilterContainerColor,
                                border: Border.all(color: kTableBorderColor)),
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
                                  "Date Range",
                                  style: AppStyles.workSansTextStyle().copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.dialog(filterPopup());
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
                                              "User",
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
                                              "Comment",
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
                                              "Post ID",
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
                                              "Date & Time",
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
                                              "Actions",
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
                                      rows: controller
                                          .filteredComments()
                                          .map((comment) => _buildDataRow(
                                                comment,
                                              ))
                                          .toList(),
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

  DataRow _buildDataRow(CommentModel comment) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            comment.commentedBy.name,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              comment.text,
              textAlign: TextAlign.center,
              style: AppStyles.workSansTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              comment.postId.toString(),
              textAlign: TextAlign.center,
              style: AppStyles.workSansTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              DateFormat("MMM dd, yyyy hh:mm aa").format(DateTime.parse(comment.createdAt),),
              textAlign: TextAlign.center,
              style: AppStyles.workSansTextStyle().copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
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
                borderRadius: BorderRadius.circular(4),
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
                    InkWell(
                      onTap: () {
                        controller.seeCommentDetails(comment);
                        Get.dialog(
                          seeCommentDialog(commentModel: comment,),
                        );
                      },
                      child: Image.asset(
                        kEyeIconPng,
                        height: 25,
                        width: 25,
                      ),
                    ),
                    Container(
                      width: 1,
                      color: kLightGreyColor,
                    ),
                    InkWell(
                      onTap: () {
                        Get.dialog(
                          DeleteDialog(
                            onDelete: () {
                              Get.back();
                              controller.deleteComment(commentId: comment.commentId,);
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
