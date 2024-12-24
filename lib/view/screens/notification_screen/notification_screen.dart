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
import '../../side_menu/side_menu.dart';
import 'controller/notification_controller.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  Widget addNotiDialogue(BuildContext context){
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
              SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
              Text(
                "Notification type",
                style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                    color: kBackGroundColor,
                    borderRadius: AppStyles.customBorder8,border: Border.all(color: kBorderColor)),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    focusColor: kWhiteColor,
                    value: controller.selectedNotiType.value.isNotEmpty
                        ? controller.selectedNotiType.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        kCategory,
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
                    items: ['Tech', 'Crime', 'Health']
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
                      controller.selectedNotiType.value = newValue!;
                    },
                  );
                }),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Text(
                "Title",
                style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
              ),
              MyCustomTextField(
                hintText: "Title",
                fillColor: kBackGroundColor,
                borderColor: kFieldBorderColor,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Text(
                "Description",
                style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
              ),
              MyCustomTextField(
                hintText: "Description",
                fillColor: kBackGroundColor,
                borderColor: kFieldBorderColor,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
              Text(
                "Specify audience",
                style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
              ),
              Container(
                height: 40,
                width: width,
                decoration: BoxDecoration(
                    color: kBackGroundColor,
                    borderRadius: AppStyles.customBorder8,border: Border.all(color: kBorderColor)),
                child: Obx(() {
                  return DropdownButton<String>(
                    borderRadius: AppStyles.customBorder8,
                    isExpanded: true,
                    focusColor: kWhiteColor,
                    value: controller.allUserType.value.isNotEmpty
                        ? controller.allUserType.value
                        : null,
                    hint: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        kCategory,
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
                    items: ['All Users', '1232', '12324']
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
                      controller.allUserType.value = newValue!;
                    },
                  );
                }),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.08,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(text: "Cancel", height: 40, onTap: (){
                    Get.back();
                  },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,),
                  CustomButton(text: "Create Notification", height: 40, onTap: (){},width: 159,color: kPrimaryColor,fontSize: 14,),
                ],
              )
            ],
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
                        Container(
                          height: 61,
                          decoration: const BoxDecoration(
                              border: Border(bottom: BorderSide(color: kBackGroundColor,width: 2))),
                          child: Padding(
                            padding: AppStyles().appBarPadding,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Dashboard/Notifications',style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,color: kLightBlack1),),
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
                          padding: AppStyles().paddingAll21,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 11,),
                              Text(kUserManagement,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 32,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 425,
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
                                        Text(kDate,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                                        const Icon(Icons.keyboard_arrow_down_outlined,size: 17,color: kPrimaryColor,),
                                        Container(
                                          width: 1,
                                          color: kLightGreyColor,
                                        ),
                                        Text("Type",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                                        const Icon(Icons.keyboard_arrow_down_outlined,size: 17,color: kPrimaryColor,),
                                      ],
                                    ),
                                  ),
                                  CustomButton(text: "Create Notification", height: 56,width: 220 ,onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return addNotiDialogue(context);
                                      },
                                    );
                                  })
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
                                                'Title',
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
                                            label: Flexible(
                                              child: Text(
                                                'Type',
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
                                            label: Flexible(
                                              child: Text(
                                                'Date',
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
                                            label: Flexible(
                                              child: Text(
                                                'User Type',
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
                                            user['title']!,
                                            user['Type']!,
                                            user['userType']!,
                                            user['date']!,
                                            context
                                        ))
                                            .toList(),
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
                                            ? kTableBorderColor
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
                                      return GestureDetector(
                                        onTap: () => controller.changePage(index + 1),
                                        child: Padding(
                                          padding: AppStyles().paginationBtnPadding,
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
                // Container(
                //   width: 200,
                //   decoration: const BoxDecoration(
                //       border: Border(left: BorderSide(color: kBackGroundColor,width: 2))
                //   ),
                // )
              ],
            ),
          );
        },)
    );
  }

  DataRow _buildDataRow(String title,String crimeType, String userType, String dateTime, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(title,textAlign: TextAlign.center,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),)),
        DataCell(Text(crimeType,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),)),
        DataCell(Text(dateTime.toString(),textAlign: TextAlign.center,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),)),
        DataCell(Text(userType,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),)),
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
                padding: EdgeInsets.symmetric(vertical: 9,horizontal: width * 0.01),
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
