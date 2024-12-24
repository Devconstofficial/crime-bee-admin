import 'dart:developer';

import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import 'controller/add_crime_controller.dart';

class AddCrimeScreen extends GetView<AddCrimeController> {
  const AddCrimeScreen({super.key});

  Widget dateTimeDialog(BuildContext context){

    return Dialog(
      backgroundColor: kWhiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
      ),
      child: SizedBox(
        width: 400,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24,vertical: 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select Incident Date & Time',style: AppStyles.poppinsTextStyle().copyWith(fontSize: 20,color: kPrimaryColor),),
              SizedBox(height: 32,),
              Obx(() => SizedBox(
            height: 340,
            child: TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: controller.selectedDate.value ?? DateTime.now(),
              selectedDayPredicate: (day) => isSameDay(controller.selectedDate.value, day),
              onDaySelected: (newSelectedDay, newFocusedDay) {
                controller.selectedDate.value = newSelectedDay;
                controller.dateTimeIncidentController.text =
                "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}";
                Get.back();
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
                selectedDecoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                ),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                decoration: BoxDecoration(
                  color: kGrey1.withOpacity(0.7),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
                ),
                titleCentered: true,
                titleTextStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )),
              SizedBox(height: 24,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Time',
                    style: AppStyles.poppinsTextStyle().copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(width: 12,),
                  InkWell(
                    onTap: ()async{
                      final TimeOfDay? pickedTime = await timePickerDialog(context);

                      if (pickedTime != null) {
                        String formattedTime =
                            '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                        controller.setSelectedTime(formattedTime);
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
                  SizedBox(width: 12,),
                  Obx(() {
                    return SizedBox(
                      child: Row(
                        children: [
                          Radio(
                            value: true,
                            groupValue: controller.isAm.value,
                            focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
                            fillColor: MaterialStateProperty.resolveWith(
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
                  SizedBox(width: 12,),
                  Obx(() {
                    return SizedBox(
                      child: Row(
                        children: [
                          Radio(
                            value: false,
                            groupValue: controller.isAm.value,
                            focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
                            fillColor: MaterialStateProperty.resolveWith(
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
            ]
          ),
        ),
      ),
    );
  }

  Future<TimeOfDay?> timePickerDialog(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
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
                        Container(
                          height: 61,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: kBackGroundColor,width: 2))),
                          child: Padding(
                            padding: AppStyles().appBarPadding,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Dashboard/Driver Management',style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,color: kLightBlack1),),
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
                          padding: const EdgeInsets.symmetric(horizontal: 37,vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 11,),
                              Text(kAddCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 32,),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kTypeofCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text(" *",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kTypeofCrime,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.typeofCrimeController,
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kSeverityLevel,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text(" *",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kSeverityLevel,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.severityLevelController,
                                      suffixIcon: Icons.location_on_outlined,
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kLocation,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text(" *",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kLocation,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.locationController,
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kDateTimeIncident,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text(" *",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kDateTimeIncident,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.dateTimeIncidentController,
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return dateTimeDialog(context);
                                          },
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Description (optional)",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: "Description",
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.descriptionController,
                                    ),
                                    const SizedBox(height: 280,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CustomButton(
                                          textColor: controller.isFormValid.value
                                              ? kWhiteColor
                                              : kDisableBtnTextColor,
                                          text: "ADD Crime", height: 40,width: 114,
                                          fontSize: 14.sp,
                                          onTap: (){
                                            controller.isFormValid.value
                                                ? controller.addCrime
                                                : null;
                                          },
                                          color: controller.isFormValid.value
                                              ? kPrimaryColor
                                              : kDisableButtonColor,
                                          borderColor: controller.isFormValid.value
                                              ? kPrimaryColor
                                              : kDisableButtonColor,
                                        ),
                                        const SizedBox(width: 8,),
                                        CustomButton(
                                          text: "DISCARD CHANGES",
                                          height: 40,
                                          width: 171,
                                          fontSize: 14.sp,
                                          textColor: controller.isFormValid.value
                                              ? kWhiteColor
                                              : kDisableBtnTextColor,
                                          onTap: (){
                                          controller.clearFields();
                                        },
                                          color: controller.isFormValid.value
                                            ? kPrimaryColor
                                            : kDisableButtonColor,
                                          borderColor: controller.isFormValid.value
                                              ? kPrimaryColor
                                              : kDisableButtonColor,),
                                        const SizedBox(width: 8,),
                                        CustomButton(
                                          fontSize: 14.sp,
                                          textColor: kBlackColor,
                                          text: "CANCEL", height: 40,width: 90, onTap: (){
                                          Get.back();
                                        },color: kWhiteColor,borderColor: kFieldBorderColor,),

                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
              // width: 96,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kBackGroundColor,
                  border: Border.all(color: kTableBorderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(
                      kEditIcon,
                      height: 15,
                      width: 15,
                    ),
                    Container(
                      width: 1,
                      color: kLightGreyColor,
                    ),
                    SvgPicture.asset(
                      kDeleteIcon,
                      height: 15,
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }}
