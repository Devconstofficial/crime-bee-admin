import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/screens/dashboard/controller/dashboard_controller.dart';
import 'package:dotted_border/dotted_border.dart';
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
import 'controller/blog_controller.dart';

class BlogScreen extends GetView<BlogController> {
  const BlogScreen({super.key});

  Widget addBlogDialogue(BuildContext context){
    double width = MediaQuery.of(context).size.width;

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
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
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
                  kCategory,
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
                      value: controller.selectedBlogType.value.isNotEmpty
                          ? controller.selectedBlogType.value
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
                        controller.selectedBlogType.value = newValue!;
                      },
                    );
                  }),
                ),
                Text(
                  kLocation,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
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
                GestureDetector(
                  onTap: (){},
                  child: DottedBorder(
                    color: kBackGroundColor,
                    strokeWidth: 5,
                    padding: const EdgeInsets.all(0),
                    dashPattern: const [10, 10],
                    child: Container(
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: AppStyles.customBorder8
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 28),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset(
                              kGalleryIcon,
                              height: 16,
                              width: 16,
                            ),
                            Text(
                              "Drag and drop image here, or click add image",
                              style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w400,color: const Color(0xff858D9D)),
                            ),
                            CustomButton(text: "Add Image", height: 40, onTap: (){},width: 100,color: kBackGroundColor,borderColor: kBackGroundColor,textColor: kBlackColor,),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(text: "Cancel", height: 40, onTap: (){
                      Get.back();
                    },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,),
                    CustomButton(text: "Add Blog", height: 40, onTap: (){},width: 90,color: kPrimaryColor),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusUpdateDialogue(BuildContext context){
    double width = MediaQuery.of(context).size.width;

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
                const SizedBox(height: 32,),
                Text(
                  "Blog Status",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: kBackGroundColor,
                      borderRadius: AppStyles.customBorder8,border: Border.all(color: kGrey1)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      borderRadius: AppStyles.customBorder8,
                      isExpanded: true,
                      focusColor: kWhiteColor,
                      value: controller.selectedBlogStatus.value.isNotEmpty
                          ? controller.selectedBlogStatus.value
                          : null,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          kStatus,
                          style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 14.sp, color: kHintColor),
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(Icons.arrow_drop_down_outlined,
                            size: 25, color: kBlackColor.withOpacity(0.4)),
                      ),
                      underline: const SizedBox.shrink(),
                      items: ['Approve', 'Reject']
                          .map((String crime) => DropdownMenuItem<String>(
                        value: crime,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            crime,
                            style: AppStyles.workSansTextStyle()
                                .copyWith(fontSize: 14.sp),
                          ),
                        ),
                      ))
                          .toList(),
                      onChanged: (String? newValue) {
                        controller.selectedBlogStatus.value = newValue!;
                      },
                    );
                  }),
                ),
                const SizedBox(height: 52,),
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
                                Text('Dashboard/Comments',style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,color: kLightBlack1),),
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
                              Text("Blogs",style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
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
                                        Text(kCategory,style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
                                        const Icon(Icons.keyboard_arrow_down_outlined,size: 17,color: kPrimaryColor,),

                                      ],
                                    ),
                                  ),
                                  CustomButton(text: "Add New Blog", height: 56,width: 173 ,onTap: (){
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return addBlogDialogue(context);
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
                                                "Title",
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
                                                "Date",
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
                                                "Category",
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
                                                "Views",
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
                                                "Actions",
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
                                            user['Title']!,
                                            user['date']!,
                                            user['Category']!,
                                            user['Views']!,
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
                              ),
                              const SizedBox(height: 51,),
                              Text("Blogs",style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
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
                                                "Title",
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
                                                "Submission Date",
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
                                                "Submitted By",
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
                                                "Status",
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
                                                "Actions",
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
                                        rows: controller.userBlogsCurrentPageUsers
                                            .map((user) => _buildBlogDataRow(
                                            user['title']!,
                                            user['submissionDate']!,
                                            user['submitBy']!,
                                            user['Status']!,
                                            user['statusBackColor']!,
                                            user['StatusColor']!,
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
                                    onTap: controller.isBackButtonDisabled1
                                        ? null
                                        : controller.goToPreviousPage1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: controller.isBackButtonDisabled1
                                            ? kBackGroundColor
                                            : kPrimaryColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child:Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.arrow_back_ios_new_outlined,size: 12,color: controller.isBackButtonDisabled1
                                              ? kBlackColor : kWhiteColor),
                                          const SizedBox(width: 4,),
                                          Text(
                                            'Back',
                                            style: AppStyles.interTextStyle().copyWith(
                                              fontSize: 12,
                                              color: controller.isNextButtonDisabled1 ? kWhiteColor : kBlackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12,),
                                  ...List.generate(
                                    controller.userBlogTotalPages,
                                        (index) {
                                      bool isSelected = index + 1 == controller.userBlogsCurrentPage.value;
                                      return GestureDetector(
                                        onTap: () => controller.userBlogChangePage(index + 1),
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
                                    onTap: controller.isNextButtonDisabled1
                                        ? null
                                        : controller.goToNextPage1,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 12),
                                      decoration: BoxDecoration(
                                        color: controller.isNextButtonDisabled1
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
                                              color: controller.isNextButtonDisabled1 ? kBlackColor : kWhiteColor,
                                            ),
                                          ),
                                          const SizedBox(width: 4,),
                                          Icon(Icons.arrow_forward_ios_outlined,size: 12,color:  controller.isNextButtonDisabled1
                                              ? kBlackColor : kWhiteColor),
                                        ],
                                      ),
                                    ),
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

  DataRow _buildDataRow(String title, String views, String category, String dateTime, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(title,textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600))),
        DataCell(Center(child: Text(dateTime,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),))),
        DataCell(Center(child: Text(category.toString(),textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)))),
        DataCell(Center(child: Text(views,textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)))),
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
  }
  DataRow _buildBlogDataRow(String title, String submissionDate, String submittedBy, String status,Color statusBackColor, Color statusColor,context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(title,textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600))),
        DataCell(Center(child: Text(submissionDate,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),))),
        DataCell(Center(child: Text(submittedBy.toString(),textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)))),
        DataCell(
          Center(
            child: Container(
              width: width * 0.08,
              height: 27,
              decoration: BoxDecoration(
                color: statusBackColor,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Center(
                  child: Text(
                    status,
                    style: AppStyles.workSansTextStyle().copyWith(fontSize: 12.sp,fontWeight: FontWeight.w700,color: statusColor),
                  ),
                ),
              ),
            ),
          ),
        ),
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
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return statusUpdateDialogue(context);
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
  }

}
