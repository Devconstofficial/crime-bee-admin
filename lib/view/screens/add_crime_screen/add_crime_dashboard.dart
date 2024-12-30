import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/controller/menu_controller.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/add_crime_controller.dart';

class AddCrimeDashboard extends GetView<AddCrimeController> {
  AddCrimeDashboard({super.key});

  final menuController = Get.put(MenuControllers());

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
                        "Select Crime Type",
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
                              text: "Theft",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Theft");
                              },
                              width: 87,
                              borderColor: controller.selectedFilters.contains("Theft")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Theft")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Theft")
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            return FilterButton(
                              text: "Assault",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Assault");
                              },
                              width: 101,
                              borderColor:
                              controller.selectedFilters.contains("Assault")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Assault")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Assault")
                                  ? kWhiteColor
                                  : kBlackColor,);
                          },),

                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            return FilterButton(
                              text: "Vandalism",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Vandalism");
                              },
                              width: 121,
                              borderColor: controller.selectedFilters.contains("Vandalism")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Vandalism")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Vandalism")
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
                        "*You can choose multiple Crime type",
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
                            fontSize: 14,
                          ),
                          CustomButton(
                            text: "ApplyFilter",
                            height: 40,
                            onTap: () {
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

  Widget editCrimeDialogue(BuildContext context){
    double width = MediaQuery.of(context).size.width;

    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
        // height: MediaQuery.of(context).size.height / 1.2,
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  kTypeofCrime,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: AppStyles.customBorder8,border: Border.all(color: kBorderColor)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      dropdownColor: kWhiteColor,
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
                          style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 14, color: kHintColor),
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(Icons.arrow_drop_down_outlined,
                            size: 25, color: kBlackColor.withOpacity(0.4)),
                      ),
                      underline: const SizedBox.shrink(),
                      items: ['Pending', 'Approved', 'Blocked']
                          .map((String crime) => DropdownMenuItem<String>(
                        value: crime,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            crime,
                            style: AppStyles.workSansTextStyle()
                                .copyWith(fontSize: 14),
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  kSeverity,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: AppStyles.customBorder8,border: Border.all(color: kBorderColor)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      dropdownColor: kWhiteColor,
                      borderRadius: AppStyles.customBorder8,
                      isExpanded: true,
                      focusColor: kWhiteColor,
                      value: controller.selectedSeverityLevel.value.isNotEmpty
                          ? controller.selectedSeverityLevel.value
                          : null,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          kSeverity,
                          style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 14, color: kHintColor),
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(Icons.arrow_drop_down_outlined,
                            size: 25, color: kBlackColor.withOpacity(0.4)),
                      ),
                      underline: const SizedBox.shrink(),
                      items: ['Low', 'High', 'Extreme']
                          .map((String crime) => DropdownMenuItem<String>(
                        value: crime,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            crime,
                            style: AppStyles.workSansTextStyle()
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        controller.selectedSeverityLevel.value = newValue!;
                      },
                    );
                  }),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  kLocation,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: kLocation,
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  suffixIcon: Icons.location_on_outlined,
                  controller: controller.severityLevelController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                        ),
                        MyCustomTextField(
                          hintText: "Date",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          suffixIcon: Icons.date_range_rounded,
                          controller: controller.severityLevelController,
                        ),
                      ],
                    )),
                    const SizedBox(width: 18,),
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                        ),
                        MyCustomTextField(
                          hintText: "Time",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          controller: controller.severityLevelController,
                          suffixIcon: Icons.access_time_outlined,
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  "Description",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "Description",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.severityLevelController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(text: "Cancel", height: 40, onTap: (){
                      Get.back();
                    },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,fontSize: 14,),
                    CustomButton(text: "Update Now", height: 40, onTap: (){
                      Get.back();
                    },width: 110,color: kPrimaryColor,fontSize: 14,),
                  ],
                )
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
        child: Obx(() {
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
                        SizedBox(height: 21,),
                        Padding(
                          padding: AppStyles().horizontal,
                          child: Row(
                            children: [
                              Text(kAddCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const Spacer(),
                              Container(
                                height: 41,
                                width: width / 4.5,
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
                                      Padding(
                                        padding: const EdgeInsets.only(left: 3),
                                        child: SizedBox(
                                          width: width / 5.5,
                                          child: TextField(
                                            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w400),
                                            decoration: InputDecoration(
                                                hintText: 'Search',
                                                fillColor: kWhiteColor,
                                                hintStyle: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: ksuffixColor.withOpacity(0.2)),
                                                // contentPadding: const EdgeInsets.only(top: 9),
                                                prefixIcon: Icon(
                                                  Icons.search_sharp,
                                                  size: 16,
                                                  color: ksuffixColor.withOpacity(0.2),
                                                ),
                                                focusColor: kWhiteColor,
                                                hoverColor: kWhiteColor,
                                                focusedBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                                                enabledBorder: const UnderlineInputBorder(borderSide: BorderSide.none),
                                                border: const UnderlineInputBorder(borderSide: BorderSide.none)
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '⌘/',
                                        style: AppStyles.interTextStyle()
                                            .copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: ksuffixColor.withOpacity(0.2)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: (){
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
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: width / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: kFilterContainerColor,
                                        border: Border.all(color: kTableBorderColor)
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
                                        Text(kFilterBy,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                                        Container(
                                          width: 1,
                                          color: kLightGreyColor,
                                        ),
                                        Text("Crime Type",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
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
                                  MouseRegion(
                                    cursor: SystemMouseCursors.click,
                                    child: CustomButton(text: kAddCrime, height: 56,width: 147 ,onTap: (){
                                      Get.toNamed(kAddCrimeScreenRoute);
                                      menuController.selectedIndex(2);
                                    }),
                                  )
                                ],
                              ),
                              const SizedBox(height: 32,),
                              Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                  border: Border.all(color: kTableBorderColor,width: 1),
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
                                                kCrimeTypeText,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment: MainAxisAlignment.center,
                                            label: Flexible(
                                              child: Text(
                                                kLocation,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment: MainAxisAlignment.center,
                                            label: Flexible(
                                              child: Text(
                                                kDateTime,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            headingRowAlignment: MainAxisAlignment.center,
                                            label: Flexible(
                                              child: Text(
                                                kActions,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: controller.currentPageUsers
                                            .map((user) => _buildDataRow(
                                            user['Crime Type']!,
                                            user['Location']!,
                                            user['Date & Time']!,
                                          context
                                        ))
                                            .toList(),
                                        dataRowMaxHeight: 65,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 51,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: controller.isBackButtonDisabled
                                        ? null
                                        : controller.goToPreviousPage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: controller.isBackButtonDisabled
                                            ? kBackGroundColor
                                            : kPrimaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios_new_outlined,size: 12,color: controller.isBackButtonDisabled
                                              ? kBlackColor : kWhiteColor),
                                          const SizedBox(width: 4,),
                                          Text(
                                            'Back',
                                            style: AppStyles.interTextStyle().copyWith(
                                              fontSize: 12,
                                              color: controller.isNextButtonDisabled ? kWhiteColor : kBlackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12,),
                                  ...List.generate(
                                    controller.totalPages,
                                        (index) {
                                      bool isSelected = index + 1 == controller.currentPage.value;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 6),
                                        child: GestureDetector(
                                          onTap: () => controller.changePage(index + 1),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                            decoration: BoxDecoration(
                                              color: isSelected ? kPrimaryColor : kBackGroundColor,
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Center(
                                              child: Text(
                                                (index + 1).toString(),
                                                style: AppStyles.interTextStyle().copyWith(
                                                  fontSize: 12,
                                                  color: isSelected ? kWhiteColor : kBlackColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(width: 12,),
                                  GestureDetector(
                                    onTap: controller.isNextButtonDisabled
                                        ? null
                                        : controller.goToNextPage,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: controller.isNextButtonDisabled
                                            ? kBackGroundColor
                                            : kPrimaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Next',
                                            style: AppStyles.interTextStyle().copyWith(
                                              fontSize: 12,
                                              color: controller.isNextButtonDisabled ? kBlackColor : kWhiteColor,
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          Icon(Icons.arrow_forward_ios_outlined,size: 12,color:  controller.isNextButtonDisabled
                                              ? kBlackColor : kWhiteColor),
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
        },)
    );
  }

  DataRow _buildDataRow(String crimeType, String location, String dateTime, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(crimeType,textAlign: TextAlign.center,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),)),
        DataCell(Center(child: Text(location,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),))),
        DataCell(Center(child: Text(dateTime,textAlign: TextAlign.center,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),))),
        DataCell(
          Center(
            child: Container(
              height: 32,
              width: 96,
              decoration: BoxDecoration(
                  borderRadius: AppStyles.customBorder8,
                    color: kActionsBtnColor,
                  border: Border.all(color: kTableBorderColor)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return editCrimeDialogue(context);
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        kEditIcon,
                        height: 18,
                        width: 18,
                      ),
                    ),
                    Container(
                      width: 1,
                      color: kLightGreyColor,
                    ),
                    GestureDetector(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialog(onDelete: () {  },);
                          },
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
