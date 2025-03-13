import 'dart:developer';

import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/utils/crime_category_enums.dart';
import 'package:crime_bee_admin/view/models/crime_model.dart';
import 'package:crime_bee_admin/view/screens/add_crime_screen/controller/add_crime_dashboard_controller.dart';
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
import '../../models/crime_category_model.dart';
import '../../models/get_location_model.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/location_controller.dart';
import 'location_screen.dart';

class AddCrimeDashboard extends GetView<AddCrimeDashboardController> {
  const AddCrimeDashboard({super.key});

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
                        "Select Crime Type",
                        style: AppStyles.workSansTextStyle()
                            .copyWith(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 10.h,
                        runSpacing: 10.w,
                        children: CommonCode.crimeCategories.map<Widget>((crime) {
                          return Obx(() {
                            controller.isFiltersUpdated.value;
                            return FilterButton(
                              text: crime.name,
                              height: 34,
                              onTap: () {
                                controller.toggleFilter(crime.crimeType.convertToString().toLowerCase());
                              },
                              borderColor: controller.selectedFilters.contains(crime.crimeType.convertToString().toLowerCase())
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains(crime.crimeType.convertToString().toLowerCase())
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains(crime.crimeType.convertToString().toLowerCase())
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },);
                        }).toList(),
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

  Widget editCrimeDialogue() {
    double width = Get.width;
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
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Text(
                  kTypeofCrime,
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: AppStyles.customBorder8,
                      border: Border.all(color: kBorderColor)),
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
                          style: AppStyles.workSansTextStyle().copyWith(
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
                          .map((CrimeCategoryModel crime) {
                        return DropdownMenuItem<CrimeCategoryModel>(
                          value: crime,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              crime.name,
                              style: AppStyles.workSansTextStyle().copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (CrimeCategoryModel? newValue) {
                        controller.selectedCrimeType.value = newValue!;
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  kSeverity,
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: AppStyles.customBorder8,
                    border: Border.all(
                      color: kBorderColor,
                    ),
                  ),
                  child: Obx(() {
                    return DropdownButton<String>(
                      dropdownColor: kWhiteColor,
                      borderRadius: AppStyles.customBorder8,
                      isExpanded: true,
                      focusColor: kWhiteColor,
                      value: controller.selectSeverityType.value.isNotEmpty
                          ? controller.selectSeverityType.value
                          : null,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          kSeverity,
                          style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 14,
                            color: kHintColor,
                          ),
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(
                          Icons.arrow_drop_down_outlined,
                          size: 25,
                          color: kBlackColor.withOpacity(0.4),
                        ),
                      ),
                      underline: const SizedBox.shrink(),
                      items: ["Low", "Medium", "High"]
                          .map((String crime) => DropdownMenuItem<String>(
                                value: crime,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    crime,
                                    style: AppStyles.workSansTextStyle()
                                        .copyWith(fontSize: 14),
                                  ),
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) {
                        controller.selectSeverityType.value = newValue!;
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Text(
                  kLocation,
                  style: AppStyles.workSansTextStyle().copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                MyCustomTextField(
                  hintText: kLocation,
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  suffixIcon: Icons.location_on_outlined,
                  controller: controller.locationController,
                  suffixOnPress: () async {
                    Get.put(LocationPickerController());
                    var result = await Get.dialog(
                      Dialog(
                        backgroundColor: kWhiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppStyles.customBorder8,
                        ),
                        child: SizedBox(
                          width: 400.w,
                          child: const LocationPickerScreen(),
                        ),
                      ),
                    );
                    if (result is GetLocationModel) {
                      controller.getLocationModel = result;
                      controller.locationController.text = result.location;
                    }
                  },
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Date",
                          style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        MyCustomTextField(
                          hintText: "Date",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          suffixIcon: Icons.date_range_rounded,
                          controller: controller.dateIncidentEditController,
                          suffixOnPress: () {
                            controller.openCalendarDialog();
                          },
                        ),
                      ],
                    )),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Time",
                          style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        MyCustomTextField(
                          hintText: "Time",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          controller: controller.timeIncidentEditController,
                          suffixIcon: Icons.access_time_outlined,
                          suffixOnPress: () {
                            Get.dialog(timeDialog());
                          },
                        ),
                      ],
                    )),
                  ],
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
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.descriptionController,
                ),
                SizedBox(
                  height: Get.height * 0.1,
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
                      text: "Update Now",
                      height: 40,
                      onTap: () {
                        Get.back();
                        controller.editCrime();
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
        ),
      ),
    );
  }

  Widget timeDialog(){
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
                  final TimeOfDay? pickedTime = await timePickerDialog(Get.context!);

                  if (pickedTime != null) {

                    bool isAm = pickedTime.period == DayPeriod.am;

                    String formattedTime = '${pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')}';

                    controller.setSelectedTime(formattedTime);
                    controller.isAm.value = isAm;
                    controller.selectedDateEdit.value.add(
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
                      color: kLightGreyColor
                  ),
                  child: Center(
                    child: Obx(() {
                      return Text(
                        controller.selectedTime.value,
                        style: AppStyles.poppinsTextStyle().copyWith(fontSize: 16.sp),
                      );
                    }),
                  ),
                ),
              ),
              Obx(() {
                return SizedBox(
                  child: Row(
                    children: [
                      Radio(
                        value: true,
                        groupValue: controller.isAm.value,
                        focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
                        fillColor: WidgetStateProperty.resolveWith(
                                (states) => controller.isAm.value ? kPrimaryColor : kLightGreyColor),
                        onChanged: (val) {
                          controller.isAm.value = val!;
                          log('AM selected');
                        },
                      ),
                      Text(
                        'AM',
                        style: TextStyle(fontSize: 16, color: controller.isAm.value ? kPrimaryColor : kBlackColor),
                      ),
                    ],
                  ),
                );
              },),
              Obx(() {
                return SizedBox(
                  child: Row(
                    children: [
                      Radio(
                        value: false,
                        groupValue: controller.isAm.value,
                        focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
                        fillColor: WidgetStateProperty.resolveWith(
                                (states) => controller.isAm.value ? kPrimaryColor : kLightGreyColor),
                        onChanged: (val) {
                          controller.isAm.value = val!;
                          log('PM selected');
                        },
                      ),
                      Text(
                        'PM',
                        style: TextStyle(fontSize: 16, color: controller.isAm.value ? kPrimaryColor : kBlackColor),
                      ),
                    ],
                  ),
                );
              },)
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

  Widget locationDialogue(BuildContext context){
    LocationPickerController locController = Get.put(LocationPickerController());

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
              children: [
                TextField(
                  controller: locController.searchController,
                  decoration: InputDecoration(
                    hintText: 'Search location',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        locController.searchLocation(locController.searchController.text);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Obx(() {
                        if (!locController.isLocationLoaded.value) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        return ClipRRect(
                          borderRadius: AppStyles.customBorderAll,
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: locController.currentLocation!,
                              zoom: 14,
                            ),
                            onMapCreated: (GoogleMapController mapController) {
                              locController.mapController= mapController;
                            },
                            onCameraMove: locController.onMapCameraMove,
                            onCameraIdle: locController.onMapCameraIdle,
                            markers: Set<Marker>.of(locController.markers),
                            onTap: locController.onMapTap,
                          ),
                        );
                      }),
                      Obx(() {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              height: 150,
                              margin: const EdgeInsets.only(bottom: 20),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  locController.isLoadingAddress.value
                                      ? const CircularProgressIndicator()
                                      : Text(locController.selectedAddress.value.isNotEmpty
                                      ? locController.selectedAddress.value
                                      : "Select a location", style: AppStyles.workSansTextStyle().copyWith(color: kWhiteColor,),),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Pick Location'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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
                    SizedBox(
                      height: 21.h,
                    ),
                    Padding(
                      padding: AppStyles().horizontal,
                      child: Row(
                        children: [
                          Text(
                            kAddCrime,
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
                                    style: AppStyles.interTextStyle().copyWith(
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
                          const SizedBox(
                            width: 20,
                          ),
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
                                width: width / 3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kFilterContainerColor,
                                  border: Border.all(
                                    color: kTableBorderColor,
                                  ),
                                ),
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      color: kLightGreyColor,
                                    ),
                                    Text(
                                      "Crime Type",
                                      style: AppStyles.workSansTextStyle()
                                          .copyWith(
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
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: CustomButton(
                                  text: kAddCrime,
                                  height: 56,
                                  width: 147,
                                  onTap: () {
                                    Get.toNamed(kAddCrimeScreenRoute);
                                    controller.menuController.selectedIndex(2);
                                  },
                                ),
                              )
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
                                      return SizedBox(
                                        height: Get.height*0.6,
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
                                              kCrimeTypeText,
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
                                              kLocation,
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
                                              kDateTime,
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
                                              kActions,
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
                                      rows: controller.crimes
                                          .where((test) {
                                        if (controller
                                            .selectedFilters.isEmpty) {
                                          return true;
                                        } else if (controller.selectedFilters
                                            .contains(
                                            test.crimeType.convertToString().toLowerCase())) {
                                          return true;
                                        } else {
                                          return false;
                                        }
                                      }).map((crime) => _buildDataRow(crime)).toList(),
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

  DataRow _buildDataRow(CrimeModel crimeModel) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            crimeModel.crimeType.convertToString(),
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
              crimeModel.location,
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
              DateFormat("MMM dd, yyyy hh:mm aa").format(DateTime.parse(crimeModel.dateTime)),
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
                    InkWell(
                      onTap: () {
                        controller.filterCrimeData(crimeModel: crimeModel);
                        Get.dialog(
                          editCrimeDialogue(),
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
                      onTap: () {
                        Get.dialog(
                          DeleteDialog(
                            onDelete: () {
                              Get.back();
                              controller.deleteCrimeById(crimeModel.crimeId);
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
