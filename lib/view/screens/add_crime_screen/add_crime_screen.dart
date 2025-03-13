import 'dart:developer';
import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/models/crime_category_model.dart';
import 'package:crime_bee_admin/view/models/get_location_model.dart';
import 'package:crime_bee_admin/view/screens/add_crime_screen/location_screen.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/add_crime_controller.dart';
import 'controller/location_controller.dart';

class AddCrimeScreen extends GetView<AddCrimeController> {
  const AddCrimeScreen({super.key});

  Widget timeDialog(BuildContext context) {
    return Dialog(
      backgroundColor: kWhiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyles.customBorder8,
      ),
      child: SizedBox(
        width: 342,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time',
                style: AppStyles.poppinsTextStyle().copyWith(fontSize: 16.sp),
              ),
              InkWell(
                onTap: () async {
                  final TimeOfDay? pickedTime = await timePickerDialog(context);

                  if (pickedTime != null) {
                    bool isAm = pickedTime.period == DayPeriod.am;

                    String formattedTime =
                        '${pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')}';

                    controller.setSelectedTime(formattedTime);
                    controller.isAm.value = isAm;
                    controller.selectedDate.value.add(
                      Duration(
                        hours: pickedTime.hour,
                        minutes: pickedTime.minute,
                      ),
                    );
                  }
                },
                child: Container(
                  width: 60,
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kLightGreyColor,),
                  child: Center(
                    child: Obx(() {
                      return Text(
                        controller.selectedTime.value,
                        style: AppStyles.poppinsTextStyle()
                            .copyWith(fontSize: 16.sp,),
                      );
                    }),
                  ),
                ),
              ),
              Obx(
                () {
                  return SizedBox(
                    child: Row(
                      children: [
                        Radio(
                          value: true,
                          groupValue: controller.isAm.value,
                          focusColor: controller.isAm.value
                              ? kPrimaryColor
                              : kLightGreyColor,
                          fillColor: WidgetStateProperty.resolveWith(
                              (states) => controller.isAm.value
                                  ? kPrimaryColor
                                  : kLightGreyColor,),
                          onChanged: (val) {
                            controller.isAm.value = val!;
                            log('AM selected');
                          },
                        ),
                        Text(
                          'AM',
                          style: TextStyle(
                              fontSize: 16,
                              color: controller.isAm.value
                                  ? kPrimaryColor
                                  : kBlackColor,),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Obx(
                () {
                  return SizedBox(
                    child: Row(
                      children: [
                        Radio(
                          value: false,
                          groupValue: controller.isAm.value,
                          focusColor: controller.isAm.value
                              ? kPrimaryColor
                              : kLightGreyColor,
                          fillColor: WidgetStateProperty.resolveWith(
                              (states) => controller.isAm.value
                                  ? kPrimaryColor
                                  : kLightGreyColor,),
                          onChanged: (val) {
                            controller.isAm.value = val!;
                            log('PM selected');
                          },
                        ),
                        Text(
                          'PM',
                          style: TextStyle(
                              fontSize: 16,
                              color: controller.isAm.value
                                  ? kPrimaryColor
                                  : kBlackColor),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> timePickerDialog(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    return pickedTime;
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
                    Container(
                      height: 68,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: kBackGroundColor,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: AppStyles().horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                padding: const EdgeInsets.only(
                                  right: 8,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 3,
                                      ),
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
                                              color: ksuffixColor.withOpacity(
                                                0.2,
                                              ),
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
                                      style:
                                          AppStyles.interTextStyle().copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: ksuffixColor.withOpacity(
                                          0.2,
                                        ),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 37,
                        vertical: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            kAddCrime,
                            style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kTypeofCrime,
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 41,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: AppStyles.customBorder8,
                                    border: Border.all(
                                      color: kFieldBorderColor,
                                    ),
                                  ),
                                  child: Obx(() {
                                    return DropdownButton<CrimeCategoryModel>(
                                      borderRadius: AppStyles.customBorder8,
                                      isExpanded: true,
                                      focusColor: kWhiteColor,
                                      dropdownColor: kWhiteColor,
                                      value: controller.selectedCrimeType.value.name.isNotEmpty
                                          ? controller.selectedCrimeType.value
                                          : null,
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          kCrimeType,
                                          style: AppStyles.workSansTextStyle()
                                              .copyWith(
                                            fontSize: 14,
                                            color: kHintColor,
                                          ),
                                        ),
                                      ),
                                      icon: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 25,
                                          color: kBlackColor.withOpacity(
                                            0.4,
                                          ),
                                        ),
                                      ),
                                      underline: const SizedBox.shrink(),
                                      items: CommonCode.crimeCategories
                                          .map((CrimeCategoryModel crime){
                                        return DropdownMenuItem<CrimeCategoryModel>(
                                          value: crime,
                                          child: Padding(
                                            padding: const EdgeInsets
                                                .symmetric(
                                              horizontal: 12,
                                            ),
                                            child: Text(
                                              crime.name,
                                              style: AppStyles.workSansTextStyle()
                                                  .copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (CrimeCategoryModel? newValue) {
                                        controller.selectedCrimeType
                                            .value = newValue!;
                                        controller.validateDiscard();
                                      },
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kSeverityLevel,
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 41,
                                  width: width,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
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
                                      value: controller.selectSeverityType.value.isNotEmpty
                                          ? controller.selectSeverityType.value
                                          : null,
                                      hint: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          kSeverity,
                                          style: AppStyles.workSansTextStyle()
                                              .copyWith(
                                            fontSize: 14,
                                            color: kHintColor,
                                          ),
                                        ),
                                      ),
                                      icon: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                        ),
                                        child: Icon(
                                          Icons.arrow_drop_down_outlined,
                                          size: 25,
                                          color: kBlackColor.withOpacity(
                                            0.4,
                                          ),
                                        ),
                                      ),
                                      underline: const SizedBox.shrink(),
                                      items: <String>["Low","Medium","High"]
                                          .map((String severity){
                                          return DropdownMenuItem<String>(
                                            value: severity,
                                            child: Padding(
                                              padding: const EdgeInsets
                                                  .symmetric(
                                                horizontal: 12,
                                              ),
                                              child: Text(
                                                severity,
                                                style: AppStyles.workSansTextStyle()
                                                    .copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        if(newValue==null) {
                                          return;
                                        }
                                        controller.selectSeverityType
                                            .value = newValue;
                                        controller.validateDiscard();
                                      },
                                    );
                                  }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kLocation,
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 41,
                                  child: MyCustomTextField(
                                    hintText: kLocation,
                                    fillColor: kWhiteColor,
                                    borderColor: kFieldBorderColor,
                                    suffixIcon: Icons.location_on_outlined,
                                    suffixIconColor: ksuffix2Color,
                                    controller: controller.locationController,
                                    onChanged: (value) {
                                      controller.validateDiscard();
                                    },
                                    suffixOnPress: () async {
                                      Get.put(LocationPickerController());
                                      var result = await Get.dialog(
                                        Dialog(
                                          backgroundColor: kWhiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                AppStyles.customBorder8,
                                          ),
                                          child: SizedBox(
                                            width: 400.w,
                                            child: const LocationPickerScreen(),
                                          ),
                                        ),
                                      );
                                      if(result is GetLocationModel) {
                                        controller.getLocationModel = result;
                                        controller.locationController.text = result.location;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kDateIncident,
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 41,
                                  child: MyCustomTextField(
                                    hintText: kDateIncident,
                                    fillColor: kWhiteColor,
                                    hintColor: kHintColor,
                                    borderColor: kFieldBorderColor,
                                    controller: controller.dateIncidentController,
                                    suffixIcon: Icons.date_range_rounded,
                                    suffixIconColor: ksuffix2Color,
                                    onChanged: (value) {
                                      controller.validateDiscard();
                                    },
                                    onTap: () {
                                      controller.openCalendarDialog(context);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      kTimeIncident,
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "*",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 41,
                                  child: MyCustomTextField(
                                    hintText: kTimeIncident,
                                    fillColor: kWhiteColor,
                                    hintColor: kHintColor,
                                    borderColor: kFieldBorderColor,
                                    controller: controller.timeIncidentController,
                                    suffixIcon: Icons.access_time_outlined,
                                    suffixIconColor: ksuffix2Color,
                                    onChanged: (value) {
                                      controller.validateDiscard();
                                    },
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return timeDialog(context);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description (optional)",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 41,
                                  child: MyCustomTextField(
                                    hintText: "Description",
                                    fillColor: kWhiteColor,
                                    hintColor: kHintColor,
                                    borderColor: kFieldBorderColor,
                                    onChanged: (value) {
                                      controller.validateDiscard();
                                    },
                                    controller:
                                        controller.descriptionController,
                                  ),
                                ),
                                const SizedBox(
                                  height: 173,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(() {
                                      return CustomButton(
                                        textColor: controller.enableAddCrime.value
                                            ? kWhiteColor
                                            : kDisableBtnTextColor,
                                        text: "ADD Crime",
                                        height: 40,
                                        fontSize: 14.sp,
                                        onTap: controller.addCrime,
                                        color: controller.enableAddCrime.value
                                            ? kPrimaryColor
                                            : kDisableButtonColor,
                                        borderColor: controller.enableAddCrime.value
                                            ? kPrimaryColor
                                            : kDisableButtonColor,
                                      );
                                    }),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Obx(() {
                                      return CustomButton(
                                        text: "DISCARD CHANGES",
                                        height: 40,
                                        width: 171,
                                        fontSize: 14.sp,
                                        textColor: controller.enabledDiscard.value
                                            ? kWhiteColor : kDisableBtnTextColor,
                                        onTap: controller.onDiscardButtonTap,
                                        color: controller.enabledDiscard.value
                                            ? kPrimaryColor : kDisableButtonColor,
                                        borderColor: controller.enabledDiscard.value
                                            ? kPrimaryColor : kDisableButtonColor,
                                      );
                                    }),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    CustomButton(
                                      fontSize: 14.sp,
                                      textColor: kBlackColor,
                                      text: "CANCEL",
                                      height: 40,
                                      width: 90,
                                      onTap: () {
                                        Get.back();
                                      },
                                      color: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
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
}
