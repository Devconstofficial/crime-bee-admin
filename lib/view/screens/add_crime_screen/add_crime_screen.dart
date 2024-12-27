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
import '../../widgets/notifiction_panel.dart';
import 'controller/add_crime_controller.dart';

class AddCrimeScreen extends GetView<AddCrimeController> {
  const AddCrimeScreen({super.key});

  // Widget dateTimeDialog(BuildContext context){
  //
  //   return Dialog(
  //     backgroundColor: kWhiteColor,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(topLeft: Radius.circular(32),topRight: Radius.circular(32)),
  //     ),
  //     child: SizedBox(
  //       width: 400,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 48),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text('Select Incident Date & Time',style: AppStyles.poppinsTextStyle().copyWith(fontSize: 20,color: kPrimaryColor),),
  //             const SizedBox(height: 32,),
  //             Obx(() => SizedBox(
  //           height: 340,
  //           child: TableCalendar(
  //             firstDay: DateTime.utc(2000, 1, 1),
  //             lastDay: DateTime.utc(2100, 12, 31),
  //             focusedDay: controller.selectedDate.value ?? DateTime.now(),
  //             selectedDayPredicate: (day) => isSameDay(controller.selectedDate.value, day),
  //             onDaySelected: (newSelectedDay, newFocusedDay) {
  //               controller.selectedDate.value = newSelectedDay;
  //               controller.dateIncidentController.text =
  //               "${controller.selectedDate.value!.day}-${controller.selectedDate.value!.month}-${controller.selectedDate.value!.year}";
  //               Get.back();
  //             },
  //             calendarStyle: CalendarStyle(
  //               todayDecoration: BoxDecoration(
  //                 color: kPrimaryColor.withOpacity(0.3),
  //                 borderRadius: BorderRadius.circular(8),
  //                 shape: BoxShape.rectangle,
  //               ),
  //               selectedDecoration: BoxDecoration(
  //                 color: kPrimaryColor,
  //                 borderRadius: BorderRadius.circular(8),
  //                 shape: BoxShape.rectangle,
  //               ),
  //             ),
  //             headerStyle: HeaderStyle(
  //               formatButtonVisible: false,
  //               decoration: BoxDecoration(
  //                 color: kGrey1.withOpacity(0.7),
  //                 borderRadius: const BorderRadius.only(topRight: Radius.circular(16),topLeft: Radius.circular(16)),
  //               ),
  //               titleCentered: true,
  //               titleTextStyle: const TextStyle(
  //                 fontSize: 18,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         )),
  //             const SizedBox(height: 24,),
  //             Row(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text(
  //                   'Time',
  //                   style: AppStyles.poppinsTextStyle().copyWith(fontSize: 16.sp),
  //                 ),
  //                 const SizedBox(width: 12,),
  //                 InkWell(
  //                   onTap: () async {
  //                     final TimeOfDay? pickedTime = await timePickerDialog(context);
  //
  //                     if (pickedTime != null) {
  //                       // Determine AM/PM
  //                       bool isAm = pickedTime.period == DayPeriod.am;
  //
  //                       // Format time in 12-hour format
  //                       String formattedTime = '${pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')}';
  //
  //                       controller.setSelectedTime(formattedTime);
  //                       controller.isAm.value = isAm;
  //                     }
  //                   },
  //                   child: Container(
  //                     width: 60,
  //                     height: 35,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(8),
  //                         color: kLightGreyColor
  //                     ),
  //                     child: Center(
  //                       child: Obx(() {
  //                         return Text(
  //                           controller.selectedTime.value,
  //                           style: AppStyles.poppinsTextStyle().copyWith(fontSize: 16.sp),
  //                         );
  //                       }),
  //                     ),
  //                   ),
  //                 ),
  //                 const SizedBox(width: 12,),
  //                 Obx(() {
  //                   return SizedBox(
  //                     child: Row(
  //                       children: [
  //                         Radio(
  //                           value: true,
  //                           groupValue: controller.isAm.value,
  //                           focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
  //                           fillColor: MaterialStateProperty.resolveWith(
  //                                   (states) => controller.isAm.value ? kPrimaryColor : kLightGreyColor),
  //                           onChanged: (val) {
  //                             controller.isAm.value = val!;
  //                             log('AM selected');
  //                           },
  //                         ),
  //                         Text(
  //                           'AM',
  //                           style: TextStyle(fontSize: 16, color: controller.isAm.value ? kPrimaryColor : kBlackColor),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 }),
  //                 const SizedBox(width: 12,),
  //                 Obx(() {
  //                   return SizedBox(
  //                     child: Row(
  //                       children: [
  //                         Radio(
  //                           value: false,
  //                           groupValue: controller.isAm.value,
  //                           focusColor: controller.isAm.value ? kPrimaryColor : kLightGreyColor,
  //                           fillColor: MaterialStateProperty.resolveWith(
  //                                   (states) => controller.isAm.value ? kPrimaryColor : kLightGreyColor),
  //                           onChanged: (val) {
  //                             controller.isAm.value = val!;
  //                             log('PM selected');
  //                           },
  //                         ),
  //                         Text(
  //                           'PM',
  //                           style: TextStyle(fontSize: 16, color: controller.isAm.value ? kPrimaryColor : kBlackColor),
  //                         ),
  //                       ],
  //                     ),
  //                   );
  //                 },)
  //               ],
  //             ),
  //           ]
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget timeDialog(BuildContext context){
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

                    String formattedTime = '${pickedTime.hourOfPeriod == 0 ? 12 : pickedTime.hourOfPeriod}:${pickedTime.minute.toString().padLeft(2, '0')}';

                    controller.setSelectedTime(formattedTime);
                    controller.isAm.value = isAm;
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
                            padding: AppStyles().horizontal,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                GestureDetector(
                                  onTap: (){
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
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 37,vertical: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // const SizedBox(height: 11,),
                              Text(kAddCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 18,),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kTypeofCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text("*",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    Container(
                                      height: 48,
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: AppStyles.customBorder8,border: Border.all(color: kFieldBorderColor)),
                                      child: Obx(() {
                                        return DropdownButton<String>(
                                          borderRadius: AppStyles.customBorder8,
                                          isExpanded: true,
                                          focusColor: kWhiteColor,
                                          value: controller.selectedCrimeType1.value.isNotEmpty
                                              ? controller.selectedCrimeType1.value
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
                                            controller.selectedCrimeType1.value = newValue!;
                                          },
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kSeverityLevel,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text("*",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    Container(
                                      height: 48,
                                      width: width,
                                      decoration: BoxDecoration(
                                          color: kWhiteColor,
                                          borderRadius: AppStyles.customBorder8,border: Border.all(color: kFieldBorderColor)),
                                      child: Obx(() {
                                        return DropdownButton<String>(
                                          borderRadius: AppStyles.customBorder8,
                                          isExpanded: true,
                                          focusColor: kWhiteColor,
                                          value: controller.selectedSeverityLevel1.value.isNotEmpty
                                              ? controller.selectedSeverityLevel1.value
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
                                            controller.selectedSeverityLevel1.value = newValue!;
                                          },
                                        );
                                      }),
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kLocation,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text("*",style: TextStyle(color: kPrimaryColor),),
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
                                        Text(kDateIncident,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text("*",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kDateIncident,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.dateIncidentController,
                                      onTap: (){
                                        controller.openCalendarDialog(context);
                                      },
                                    ),
                                    const SizedBox(height: 20,),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(kTimeIncident,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),),
                                        const Text("*",style: TextStyle(color: kPrimaryColor),),
                                      ],
                                    ),
                                    MyCustomTextField(
                                      hintText: kTimeIncident,
                                      fillColor: kWhiteColor,
                                      borderColor: kFieldBorderColor,
                                      controller: controller.timeIncidentController,
                                      onTap: (){
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return timeDialog(context);
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
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: controller.isNotificationVisible.value,
                  child: NotificationAndActivitySection(
                    notifications: controller.notifications,
                    activities: controller.activities,
                  ),
                )
              ],
            ),
          );
        },)
    );
  }

}
