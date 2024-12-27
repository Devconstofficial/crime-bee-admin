import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/comment_controller.dart';

class CommentScreen extends GetView<CommentController> {
  const CommentScreen({super.key});

  Widget seeCommentDialog(BuildContext context){
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
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(text: "View Full Post", height: 25,width: 123,fontSize: 14.sp, onTap: (){
                      Get.back();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return seePostDialog(context);
                        },
                      );
                    },),
                  ],
                ),
                Text(
                  "User Details",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 9,),
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

  Widget seePostDialog(BuildContext context){
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
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Row(
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
                ),
                const SizedBox(height: 24,),
                Container(
                  height: 460,
                  decoration: AppStyles.mapContainerDecor,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: AppStyles.customBorderAll,
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(37.7749, -122.4194),
                            zoom: 14.0,
                          ),
                          markers: {
                            const Marker(
                              markerId: MarkerId('Park Theft'),
                              position: LatLng(37.7749, -122.4194),
                              icon: BitmapDescriptor.defaultMarker,
                            ),
                          },
                          zoomControlsEnabled: false,
                          buildingsEnabled: true,
                          onMapCreated: controller.onMapCreated,
                        ),
                      ),
                      SizedBox(
                        height: 460,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 21,right: 22,bottom: 31,top: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: 104,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: kDarkGrey.withOpacity(0.4)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16,right: 16,bottom: 16,top: 11),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Park Theft",style: AppStyles.robotoTextStyle().copyWith(color: kWhiteColor,fontSize: 24.sp,fontWeight: FontWeight.w600),),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(kLocationIcon,height: 22,width: 22,),
                                              const SizedBox(width: 12,),
                                              Text('South America',
                                                style: AppStyles.robotoTextStyle().copyWith(
                                                    color: kWhiteColor,fontSize: 18.sp,fontWeight: FontWeight.w400),),
                                            ],
                                          ),
                                          // Row(
                                          //   children: [
                                          //     Image.asset(kRatingIcon,height: 12,width: 12,),
                                          //     const SizedBox(width: 12,),
                                          //     Text(data['rating'].toString(),style: AppStyles.robotoTextStyle().copyWith(color: kWhiteColor,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                                          //   ],
                                          // ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Positioned(
                      //     right: -1000,
                      //     child: customMarker()),
                    ],
                  ),
                ),
                const SizedBox(height: 33,),
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
                          child: Image.asset(kUserLogo,fit: BoxFit.cover,)),
                    ),
                    const SizedBox(width: 7,),
                    Text('Nightclaw',style: AppStyles.headingTextStyle().copyWith(fontSize: 18.sp,fontWeight: FontWeight.w500,color: kGrey1),),
                    // SizedBox(width: width * 0.04,),
                    ],
                ),
                const SizedBox(height: 14,),
                Row(
                  children: [
                    Image.asset(kClockIcon,height: 16,width: 16,),
                    const SizedBox(width: 12,),
                    Text('Dec 6, 2024, 10:45 AM',style: AppStyles.headingTextStyle().copyWith(
                        fontSize: 18.sp,fontWeight: FontWeight.w500,color: kGrey1),),
                  ],
                ),
                const SizedBox(height: 12,),
                RichText(
                    text: TextSpan(
                        children: [
                          TextSpan(
                              text: kTheftDetail,
                              style: AppStyles.headingTextStyle().copyWith(color: kGrey1)
                          ),
                          TextSpan(
                              text: '#CentralPark #Backpack #SuspectDescription #CrimeAlert.',
                              style: AppStyles.headingTextStyle().copyWith(color: kPrimaryColor)
                          ),
                        ]
                    )),
                const SizedBox(height: 12,),
                Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            // controller.toggleLike();
                          },
                          child: const Icon(
                              Icons.favorite ,size: 18,color: Colors.red),),
                        const SizedBox(width: 7,),
                        Text('27',style: AppStyles.rubikTextStyle())
                      ],
                    ),
                    SizedBox(width: 15,),
                    Row(
                      children: [
                        SvgPicture.asset(
                          kComment1Icon,
                          height: 16,
                          width: 16,
                        ),
                        const SizedBox(width: 7,),
                        Text('27',style: AppStyles.rubikTextStyle(),),
                      ],
                    ),
                  ],
                ),
                Obx(() {
                  return  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.comments.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final comment = controller.comments[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: AppStyles.customBorderAll100,
                              ),
                              child: ClipRRect(
                                  borderRadius: AppStyles.customBorderAll100,
                                  child: Image.asset(comment.image,fit: BoxFit.contain,)),
                            ),
                            const SizedBox(width: 7,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(comment.username,style: AppStyles.headingTextStyle().copyWith(fontWeight: FontWeight.w600,fontSize: 14.sp),),
                                        const SizedBox(width: 7,),
                                        Text(comment.content,style: AppStyles.headingTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 14.sp,color: kBlackColor.withOpacity(0.6)),),
                                      ],
                                    ),
                                  ],
                                ),
                                Text('Flagged',style: AppStyles.headingTextStyle().copyWith(fontWeight: FontWeight.w500,fontSize: 10.sp,color: kPrimaryColor,decoration: TextDecoration.underline),),
                              ],
                            )
                          ],
                        ),
                      );
                    },);
                },),
              ],
            ),
          ),
        ),
      ),
    );
  }

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
                            return FilterButton(
                              text: "Last 7 Days",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Last 7 Days");
                              },
                              width: 129,
                              borderColor: controller.selectedFilters.contains("Last 7 Days")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Last 7 Days")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Last 7 Days")
                                  ? kWhiteColor
                                  : kBlackColor,
                            );
                          },),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(() {
                            return FilterButton(
                              text: "Last 30 Days",
                              height: 34,
                              onTap: () {
                                controller.toggleFilter("Last 30 Days");
                              },
                              width: 130,
                              borderColor:
                              controller.selectedFilters.contains("Last 30 Days")
                                  ? kWhiteColor
                                  : kActionsButtonColor,
                              color: controller.selectedFilters.contains("Last 30 Days")
                                  ? kPrimaryColor
                                  : kWhiteColor,
                              fontSize: 14,
                              textColor: controller.selectedFilters.contains("Last 30 Days")
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
                        const SizedBox(height: 21,),
                        Padding(
                          padding: AppStyles().horizontal,
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Flag Comments",style: AppStyles.workSansTextStyle().copyWith(fontSize: 32.sp,fontWeight: FontWeight.w600),),
                              const Spacer(),
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
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
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
                              Container(
                                height: 70,
                                width: 311,
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
                                    Text("Date Range",style: AppStyles.workSansTextStyle().copyWith(fontSize: 14.sp,fontWeight: FontWeight.w600),),
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
              width: 96,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kActionsBtnColor,
                  border: Border.all(color: kTableBorderColor)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
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
                        height: 25,
                        width: 25,
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
