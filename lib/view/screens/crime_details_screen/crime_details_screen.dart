import 'package:crime_bee_admin/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../models/comment_model.dart';
import '../../widgets/custom_hotspot_map_widget.dart';
import '../../widgets/custom_image_widget.dart';
import 'crime_details_controller.dart';

class CrimeDetailsScreen extends GetView<CrimeDetailsController> {
  const CrimeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        CommonCode.unFocus(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Obx(() {
          if(controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator(),);
          }
          return SingleChildScrollView(
            child: Padding(
              padding: AppStyles().horizontal28,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: kToolbarHeight.h,),
                  Obx(() {
                    return CustomHotspotMapWidget(
                      hotSpotModel: controller.crimeDetailModel.value,
                      padding: EdgeInsets.zero,
                      height: 460.h,
                    );
                  }),
                  SizedBox(height: 33.h,),
                  Builder(
                    builder: (context) {
                      if(controller.crimeDetailModel.value.reportedBy.userId.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Row(
                        children: [
                          Container(
                            height: 50.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              borderRadius: AppStyles.customBorderAll100,
                            ),
                            child: ClipRRect(
                              borderRadius: AppStyles.customBorderAll100,
                              child: CustomImageWidget(
                                imageAddress: controller.crimeDetailModel.value.reportedBy.profilePic,
                                errorWidget: const Icon(Icons.person),
                                boxFit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w,),
                              child: Obx(() {
                                return Text(
                                  controller.userName.value,
                                  style: AppStyles.headingTextStyle().copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kGrey1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              }),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 14.h,),
                  Row(
                    children: [
                      Image.asset(
                        kClockIcon,
                        height: 16,
                        width: 16,
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        DateFormat("MMM dd, yyyy, hh:mm a").format(
                          DateTime.parse(
                            controller.crimeDetailModel.value.dateTime,
                          ),
                        ),
                        style: AppStyles.headingTextStyle().copyWith(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: kGrey1,
                        ),
                      ),
                    ],
                  ),
                  Builder(
                    builder: (context) {
                      if(controller.crimeDetailModel.value.description.isEmpty) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: EdgeInsets.only(top: 12.h,),
                        child: Text(
                          controller.crimeDetailModel.value.description,
                          style: AppStyles.headingTextStyle().copyWith(
                            color: kGrey1,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.h),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Obx(() {
                              if(controller.isLikeServiceLoading.value) {
                                return Center(
                                  child: SizedBox(
                                    height: 18.h,
                                    width: 18.h,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                );
                              }
                              return const Icon(
                                Icons.favorite,
                                size: 18,
                                color: Colors.red,
                              );
                            }),
                            const SizedBox(
                              width: 7,
                            ),
                            Obx(() {
                              return Text(
                                controller.likeCount.value.toString(),
                                style: AppStyles.rubikTextStyle(),
                              );
                            }),
                          ],
                        ),
                        SizedBox(width: 10.w,),
                        Row(
                          children: [
                            CustomImageWidget(
                              imageAddress: kCommentIcon,
                              height: 18,
                              width: 18,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Obx(() {
                              return Text(
                                '${controller.commentCount.value}',
                                style: AppStyles.rubikTextStyle(),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.comments.length,
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommentWidget(
                          commentModel: controller.comments[index],
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CommentWidget extends GetView<CrimeDetailsController> {
  final CommentModel commentModel;
  final bool isReplies;

  const CommentWidget({
    super.key,
    required this.commentModel,
    this.isReplies=false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: AppStyles.customBorderAll100,
            ),
            child: ClipRRect(
              borderRadius: AppStyles.customBorderAll100,
              child: CustomImageWidget(
                imageAddress: commentModel.commentedBy.profilePic,
                boxFit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    commentModel.commentedBy.isAnonymousMode
                        ? commentModel.commentedBy.vigilanteName
                        : commentModel.commentedBy.name,
                    style: AppStyles.headingTextStyle().copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h,),
                    child: Text(
                      commentModel.text,
                      style: AppStyles.headingTextStyle()
                          .copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color:
                        kBlackColor.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() {
                        controller.isCommentsUpdate.value;
                        if(controller.commentFlagId.value == commentModel.commentId) {
                          return SizedBox(
                            width: 10.w,
                            height: 10.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation(
                                kPrimaryColor,
                              ),
                            ),
                          );
                        }
                        return Text(
                          commentModel.isFlagged ? "Comment Flagged":'Flag Comment',
                          style: AppStyles.headingTextStyle().copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 10.sp,
                            color: kPrimaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // void _replyModal() {
  //   controller.getRepliesToSpecificComments(
  //     commentId: commentModel.commentId,
  //   );
  //   Get.bottomSheet(
  //     GestureDetector(
  //       onTap: () {
  //         CommonCode.unFocus(Get.context!);
  //       },
  //       child: Container(
  //         decoration: const BoxDecoration(
  //           color: kWhiteColor,
  //           borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
  //         ),
  //         child: SingleChildScrollView(
  //           child: Padding(
  //             padding: AppStyles().horizontal16,
  //             child: Column(
  //               children: [
  //                 Obx(() {
  //                   if (controller.isRepliesLoading.value) {
  //                     return SizedBox(
  //                       height: 300.h,
  //                       child: const Center(
  //                         child: CircularProgressIndicator(),
  //                       ),
  //                     );
  //                   }
  //                   return ListView.builder(
  //                     shrinkWrap: true,
  //                     itemCount: controller.replies.length,
  //                     padding: EdgeInsets.symmetric(
  //                       vertical: 20.h,
  //                     ),
  //                     physics: const NeverScrollableScrollPhysics(),
  //                     itemBuilder: (context, index) {
  //                       return CommentWidget(
  //                         commentModel: controller.replies[index],
  //                         isReplies: true,
  //                       );
  //                     },
  //                   );
  //                 }),
  //                 SizedBox(
  //                   height: 16.h,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //     isScrollControlled: true,
  //   );
  // }
}
