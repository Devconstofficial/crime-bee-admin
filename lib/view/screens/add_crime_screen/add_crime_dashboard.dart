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
import 'controller/add_crime_controller.dart';

class AddCrimeDashboard extends GetView<AddCrimeController> {
  AddCrimeDashboard({super.key});

  final menuController = Get.put(MenuControllers());

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
                  kLocation,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: kLocation,
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
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
                          "Date & Time",
                          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                        ),
                        MyCustomTextField(
                          hintText: "Date & Time",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
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
                          "Severity",
                          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                        ),
                        MyCustomTextField(
                          hintText: "User Name",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          controller: controller.severityLevelController,
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
                    },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,),
                    CustomButton(text: "Update Now", height: 40, onTap: (){},width: 110,color: kPrimaryColor),
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
                          padding: AppStyles().paddingAll21,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 11,),
                              Text(kAddCrime,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 32,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 70,
                                    width: 314,
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
                                        const Icon(Icons.keyboard_arrow_down_outlined,size: 17,color: kPrimaryColor,)
                                      ],
                                    ),
                                  ),
                                  CustomButton(text: kAddCrime, height: 56,width: 147 ,onTap: (){
                                    Get.toNamed(kAddCrimeScreenRoute);
                                    menuController.selectedIndex(2);
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
                padding: EdgeInsets.symmetric(vertical: 9),
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
                        height: 15,
                        width: 15,
                      ),
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
