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
import 'controller/comment_controller.dart';

class CommentScreen extends GetView<CommentController> {
  const CommentScreen({super.key});

  Widget seeCommentDialog(BuildContext context){
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
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: AppStyles.customBorderAll100,
                      ),
                      child: ClipRRect(
                        borderRadius: AppStyles.customBorderAll100,
                        child: Center(
                          child: SvgPicture.asset(
                            kUser1,
                            height: 12,
                            width: 12,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "NightC",
                      style: AppStyles.headingTextStyle().copyWith(fontSize: 22.sp,fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Text(
                  "Comment",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "Comment",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.commentController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  "Associated Post/Thread",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "Associated Post/Thread",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.threadController,
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(text: "View Full Post", height: 25,width: 123,fontSize: 14, onTap: (){

                    },),
                  ],
                ),
                Text(
                  "User Details",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 9,),
                Text(
                  "UserName",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "username",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.usernameController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  "Joined",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "joined",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.joinedController,

                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  "Contributions",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "contributions",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.contributionsController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                Text(
                  "Flagged Comments",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "flagged",
                  fillColor: kWhiteColor,
                  borderColor: kFieldBorderColor,
                  controller: controller.flaggedCommentController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(text: "Cancel", height: 40, onTap: (){
                      Get.back();
                    },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,),
                    CustomButton(text: "Delete Comment", height: 40, onTap: (){},width: 140,color: kPrimaryColor,fontSize: 14,),
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
                              Text(kComments,style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const SizedBox(height: 32,),
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
                                                "User",
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
                                                "Comment",
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
                                                "Post ID",
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
                                                "Date & Time",
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
                                            user['User']!,
                                            user['Comment']!,
                                            user['PostId']!,
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
                                            ? kTableBorderColor
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

  DataRow _buildDataRow(String id, String comment, String postId, String dateTime, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(id,textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600))),
        DataCell(Center(child: Text(comment,textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),))),
        DataCell(Center(child: Text(postId.toString(),textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600)))),
        DataCell(Center(child: Text(dateTime,textAlign: TextAlign.center,
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
                    InkWell(
                      onTap: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return seeCommentDialog(context);
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        kEyeIcon,
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
