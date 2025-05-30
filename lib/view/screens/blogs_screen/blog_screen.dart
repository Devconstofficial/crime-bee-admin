import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/models/blog_model.dart';
import 'package:dotted_border/dotted_border.dart';
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
import '../../widgets/custom_button.dart';
import '../../widgets/delete_dialog.dart';
import '../../widgets/filter_btn.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/blog_controller.dart';

class BlogScreen extends GetView<BlogController> {
  const BlogScreen({super.key});

  Widget addBlogDialogue(BuildContext context) {
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Title",
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "Title",
                  controller: controller.title,
                  fillColor: kBackGroundColor,
                  borderColor: kFieldBorderColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  kCategory,
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 48,
                  width: width,
                  decoration: BoxDecoration(
                      color: kBackGroundColor,
                      borderRadius: AppStyles.customBorder8,
                      border: Border.all(color: kFieldBorderColor)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      borderRadius: AppStyles.customBorder8,
                      isExpanded: true,
                      focusColor: kWhiteColor,
                      dropdownColor: kWhiteColor,
                      value: controller.selectedBlogType.value.isNotEmpty
                          ? controller.selectedBlogType.value
                          : null,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          kCategory,
                          style: AppStyles.workSansTextStyle()
                              .copyWith(fontSize: 14, color: kHintColor),
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
                        controller.selectedBlogType.value = newValue!;
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "Description",
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  controller: controller.desc,
                  hintText: "Description",
                  fillColor: kBackGroundColor,
                  borderColor: kFieldBorderColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Obx(
                  () {
                    return GestureDetector(
                      child: controller.selectedImage.value == ''
                          ? DottedBorder(
                              color: kBackGroundColor,
                              strokeWidth: 5,
                              padding: const EdgeInsets.all(0),
                              dashPattern: const [10, 10],
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: AppStyles.customBorder8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 28),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        kGalleryIcon,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Text(
                                        "Drag and drop image here, or click add image",
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff858D9D)),
                                      ),
                                      Obx(
                                        () => controller.isUploading.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CustomButton(
                                                text: "Add Image",
                                                height: 40,
                                                onTap: () {
                                                  controller.pickImage();
                                                },
                                                width: 100,
                                                color: kBackGroundColor,
                                                borderColor: kBackGroundColor,
                                                textColor: kBlackColor,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : DottedBorder(
                              color: kBackGroundColor,
                              strokeWidth: 5,
                              padding: const EdgeInsets.all(0),
                              dashPattern: const [10, 10],
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    height: 180,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: AppStyles.customBorder8,
                                        border: Border.all(
                                            color: kFieldBorderColor)),
                                    child: ClipRRect(
                                      borderRadius: AppStyles.customBorder8,
                                      child: Image.network(
                                        controller.selectedImage.value,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "Cancel",
                      height: 40,
                      onTap: () {
                        controller.selectedImage.value = '';
                        controller.selectedBlogType.value = '';
                        controller.title.clear();
                        controller.desc.clear();
                        Get.close(1);
                      },
                      width: 75,
                      textColor: kBlackColor,
                      color: kWhiteColor,
                      borderColor: kFieldBorderColor,
                      fontSize: 14.sp,
                    ),
                    CustomButton(
                      text: "Add Blog",
                      height: 40,
                      onTap: () async {
                        if (controller.isUploading.value) {
                          Get.snackbar(
                              'Error', "Please wait image is uploading",
                              backgroundColor: kPrimaryColor,
                              colorText: kWhiteColor);
                          return;
                        }
                        if (controller.title.text.isEmpty ||
                            controller.desc.text.isEmpty ||
                            controller.selectedBlogType.value == '' ||
                            controller.selectedImage.value == '') {
                          Get.snackbar('Error', "All fields are required",
                              backgroundColor: kPrimaryColor,
                              colorText: kWhiteColor);
                          return;
                        }
                        await controller.createBlogAsAdmin(
                          title: controller.title.text,
                          category: controller.selectedBlogType.value,
                          description: controller.desc.text,
                          coverImage: controller.selectedImage.value,
                        );

                        controller.selectedImage.value = '';
                        controller.selectedBlogType.value = '';
                        controller.title.clear();
                        controller.desc.clear();
                        Get.close(1);
                        Get.snackbar('Success', "Blog Added successfully!!",
                            backgroundColor: Colors.green,
                            colorText: kWhiteColor);
                      },
                      width: 90,
                      color: kPrimaryColor,
                      fontSize: 13.sp,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editBlogDialogue(BuildContext context, BlogModel blog) {
    double width = MediaQuery.of(context).size.width;
    controller.title.text = blog.title;
    controller.desc.text = blog.description;
    controller.selectedBlogType.value = blog.category;
    controller.selectedImage.value = blog.coverImage;

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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Text(
                  "Title",
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  hintText: "Title",
                  controller: controller.title,
                  fillColor: kBackGroundColor,
                  borderColor: kFieldBorderColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  kCategory,
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 48,
                  width: width,
                  decoration: BoxDecoration(
                      color: kBackGroundColor,
                      borderRadius: AppStyles.customBorder8,
                      border: Border.all(color: kFieldBorderColor)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      borderRadius: AppStyles.customBorder8,
                      isExpanded: true,
                      focusColor: kWhiteColor,
                      dropdownColor: kWhiteColor,
                      value: controller.selectedBlogType.value.isNotEmpty
                          ? controller.selectedBlogType.value
                          : null,
                      hint: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          kCategory,
                          style: AppStyles.workSansTextStyle()
                              .copyWith(fontSize: 14, color: kHintColor),
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
                        controller.selectedBlogType.value = newValue!;
                      },
                    );
                  }),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  "Description",
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                MyCustomTextField(
                  controller: controller.desc,
                  hintText: "Description",
                  fillColor: kBackGroundColor,
                  borderColor: kFieldBorderColor,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Obx(
                  () {
                    return GestureDetector(
                      child: controller.selectedImage.value == ''
                          ? DottedBorder(
                              color: kBackGroundColor,
                              strokeWidth: 5,
                              padding: const EdgeInsets.all(0),
                              dashPattern: const [10, 10],
                              child: Container(
                                height: 180,
                                decoration: BoxDecoration(
                                    borderRadius: AppStyles.customBorder8),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 24, horizontal: 28),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SvgPicture.asset(
                                        kGalleryIcon,
                                        height: 16,
                                        width: 16,
                                      ),
                                      Text(
                                        "Drag and drop image here, or click add image",
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff858D9D)),
                                      ),
                                      Obx(
                                        () => controller.isUploading.value
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : CustomButton(
                                                text: "Add Image",
                                                height: 40,
                                                onTap: () {
                                                  controller.pickImage();
                                                },
                                                width: 100,
                                                color: kBackGroundColor,
                                                borderColor: kBackGroundColor,
                                                textColor: kBlackColor,
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : DottedBorder(
                              color: kBackGroundColor,
                              strokeWidth: 5,
                              padding: const EdgeInsets.all(0),
                              dashPattern: const [10, 10],
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    height: 180,
                                    width: width,
                                    decoration: BoxDecoration(
                                        borderRadius: AppStyles.customBorder8,
                                        border: Border.all(
                                            color: kFieldBorderColor)),
                                    child: ClipRRect(
                                      borderRadius: AppStyles.customBorder8,
                                      child: Image.network(
                                        controller.selectedImage.value,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      text: "Cancel",
                      height: 40,
                      onTap: () {
                        controller.selectedImage.value = '';
                        controller.selectedBlogType.value = '';
                        controller.title.clear();
                        controller.desc.clear();
                        Get.close(1);
                      },
                      width: 75,
                      textColor: kBlackColor,
                      color: kWhiteColor,
                      borderColor: kFieldBorderColor,
                      fontSize: 14.sp,
                    ),
                    CustomButton(
                      text: "Update Blog",
                      height: 40,
                      onTap: () async {
                        if (controller.isUploading.value) {
                          Get.snackbar(
                              'Error', "Please wait image is uploading",
                              backgroundColor: kPrimaryColor,
                              colorText: kWhiteColor);
                          return;
                        }
                        if (controller.title.text.isEmpty ||
                            controller.desc.text.isEmpty ||
                            controller.selectedBlogType.value == '' ||
                            controller.selectedImage.value == '') {
                          Get.snackbar('Error', "All fields are required",
                              backgroundColor: kPrimaryColor,
                              colorText: kWhiteColor);
                          return;
                        }
                        await controller.updateBlogAsAdmin(
                          id: blog.blogId,
                          title: controller.title.text,
                          category: controller.selectedBlogType.value,
                          description: controller.desc.text,
                          coverImage: controller.selectedImage.value,
                        );

                        controller.selectedImage.value = '';
                        controller.selectedBlogType.value = '';
                        controller.title.clear();
                        controller.desc.clear();
                        Get.close(1);
                        Get.snackbar('Success', "Blog Updated successfully!!",
                            backgroundColor: Colors.green,
                            colorText: kWhiteColor);
                      },
                      width: 90,
                      color: kPrimaryColor,
                      fontSize: 13.sp,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusUpdateDialogue(BuildContext context, String id) {
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
                const SizedBox(
                  height: 32,
                ),
                Text(
                  "Blog Status",
                  style: AppStyles.workSansTextStyle()
                      .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 40,
                  width: width,
                  decoration: BoxDecoration(
                      color: kBackGroundColor,
                      borderRadius: AppStyles.customBorder8,
                      border: Border.all(color: kGrey1)),
                  child: Obx(() {
                    return DropdownButton<String>(
                      dropdownColor: kWhiteColor,
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
                          style: AppStyles.workSansTextStyle()
                              .copyWith(fontSize: 14.sp, color: kHintColor),
                        ),
                      ),
                      icon: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Icon(Icons.arrow_drop_down_outlined,
                            size: 25, color: kBlackColor.withOpacity(0.4)),
                      ),
                      underline: const SizedBox.shrink(),
                      items: ['Approve', 'Reject', 'Pending']
                          .map((String crime) => DropdownMenuItem<String>(
                                value: crime,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
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
                        if (controller.selectedBlogStatus.value == 'Approve') {
                          controller.status.value = 'approved';
                        }
                        if (controller.selectedBlogStatus.value == 'Reject') {
                          controller.status.value = 'rejected';
                        }
                        if (controller.selectedBlogStatus.value == 'Pending') {
                          controller.status.value = 'pending';
                        }
                      },
                    );
                  }),
                ),
                const SizedBox(
                  height: 52,
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
                      fontSize: 14.sp,
                    ),
                    CustomButton(
                      text: "Update Now",
                      height: 40,
                      onTap: () async {
                        if (controller.selectedBlogStatus.value == '') {
                          Get.snackbar('Error', "Please select the status",
                              backgroundColor: kPrimaryColor,
                              colorText: kWhiteColor);
                          return;
                        }
                        await controller.approveRejectBlogAsAdmin(
                          id: id,
                          status: controller.status.value,
                        );
                        controller.selectedBlogStatus.value = '';
                        controller.status.value = '';

                        Get.close(1);
                        Get.snackbar('Success', "Blog Updated successfully!!",
                            backgroundColor: Colors.green,
                            colorText: kWhiteColor);
                      },
                      width: 110,
                      color: kPrimaryColor,
                      fontSize: 14.sp,
                    ),
                  ],
                )
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
                        "Select Blog Category",
                        style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Obx(
                            () {
                              return FilterButton(
                                text: "Tech",
                                height: 34,
                                onTap: () {
                                  controller.toggleFilter("Tech");
                                },
                                width: 82,
                                borderColor:
                                    controller.selectedFilters.contains("Tech")
                                        ? kWhiteColor
                                        : kActionsButtonColor,
                                color:
                                    controller.selectedFilters.contains("Tech")
                                        ? kPrimaryColor
                                        : kWhiteColor,
                                fontSize: 14,
                                textColor:
                                    controller.selectedFilters.contains("Tech")
                                        ? kWhiteColor
                                        : kBlackColor,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(
                            () {
                              return FilterButton(
                                text: "Health",
                                height: 34,
                                onTap: () {
                                  controller.toggleFilter("Health");
                                },
                                width: 74,
                                borderColor: controller.selectedFilters
                                        .contains("Health")
                                    ? kWhiteColor
                                    : kActionsButtonColor,
                                color: controller.selectedFilters
                                        .contains("Health")
                                    ? kPrimaryColor
                                    : kWhiteColor,
                                fontSize: 14,
                                textColor: controller.selectedFilters
                                        .contains("Health")
                                    ? kWhiteColor
                                    : kBlackColor,
                              );
                            },
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Obx(
                            () {
                              return FilterButton(
                                text: "Crime",
                                height: 34,
                                onTap: () {
                                  controller.toggleFilter("Crime");
                                },
                                width: 91,
                                borderColor:
                                    controller.selectedFilters.contains("Crime")
                                        ? kWhiteColor
                                        : kActionsButtonColor,
                                color:
                                    controller.selectedFilters.contains("Crime")
                                        ? kPrimaryColor
                                        : kWhiteColor,
                                fontSize: 14,
                                textColor:
                                    controller.selectedFilters.contains("Crime")
                                        ? kWhiteColor
                                        : kBlackColor,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 44,
                ),
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
                              controller.applyCategoryFilters();
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

    return GestureDetector(onTap: () {
      CommonCode.unFocus(context);
    }, child: Obx(
      () {
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
                      const SizedBox(
                        height: 21,
                      ),
                      Padding(
                        padding: AppStyles().horizontal,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Blogs",
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 32.sp, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            // Container(
                            //   height: 41,
                            //   width: width / 4.5,
                            //   decoration: BoxDecoration(
                            //       color: kWhiteColor,
                            //       borderRadius: BorderRadius.circular(8),
                            //       border: Border.all(color: kFieldBorderColor)),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(right: 8),
                            //     child: Row(
                            //       mainAxisAlignment:
                            //           MainAxisAlignment.spaceBetween,
                            //       children: [
                            //         Padding(
                            //           padding: const EdgeInsets.only(left: 3),
                            //           child: SizedBox(
                            //             width: width / 5.5,
                            //             child: TextField(
                            //               style: AppStyles.workSansTextStyle()
                            //                   .copyWith(
                            //                       fontSize: 14.sp,
                            //                       fontWeight: FontWeight.w400),
                            //               decoration: InputDecoration(
                            //                   hintText: 'Search',
                            //                   fillColor: kWhiteColor,
                            //                   hintStyle:
                            //                       AppStyles.workSansTextStyle()
                            //                           .copyWith(
                            //                               fontSize: 14,
                            //                               fontWeight:
                            //                                   FontWeight.w400,
                            //                               color: ksuffixColor
                            //                                   .withOpacity(
                            //                                       0.2)),
                            //                   // contentPadding: const EdgeInsets.only(top: 9),
                            //                   prefixIcon: Icon(
                            //                     Icons.search_sharp,
                            //                     size: 16,
                            //                     color: ksuffixColor
                            //                         .withOpacity(0.2),
                            //                   ),
                            //                   focusColor: kWhiteColor,
                            //                   hoverColor: kWhiteColor,
                            //                   focusedBorder:
                            //                       const UnderlineInputBorder(
                            //                           borderSide:
                            //                               BorderSide.none),
                            //                   enabledBorder:
                            //                       const UnderlineInputBorder(
                            //                           borderSide:
                            //                               BorderSide.none),
                            //                   border:
                            //                       const UnderlineInputBorder(
                            //                           borderSide:
                            //                               BorderSide.none)),
                            //             ),
                            //           ),
                            //         ),
                            //         Text(
                            //           '⌘/',
                            //           style: AppStyles.interTextStyle()
                            //               .copyWith(
                            //                   fontSize: 14,
                            //                   fontWeight: FontWeight.w400,
                            //                   color: ksuffixColor
                            //                       .withOpacity(0.2)),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(width: 20),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                  onTap: () {
                                    controller.toggleNotificationVisibility();
                                  },
                                  child: Image.asset(
                                    kNotification1Icon,
                                    height: 20,
                                    width: 20,
                                  )),
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
                                        kCategory,
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
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
                                          controller.resetCategoryFilters();
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
                                // Container(
                                //   height: 70,
                                //   width: 319,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(10),
                                //       color: kFilterContainerColor,
                                //       border:
                                //           Border.all(color: kTableBorderColor)),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceEvenly,
                                //     children: [
                                //       SvgPicture.asset(
                                //         kFilterIcon,
                                //         height: 23,
                                //         width: 20,
                                //       ),
                                //       Container(
                                //         width: 1,
                                //         color: kLightGreyColor,
                                //       ),
                                //       Text(
                                //         kFilterBy,
                                //         style: AppStyles.workSansTextStyle()
                                //             .copyWith(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w600),
                                //       ),
                                //       Container(
                                //         width: 1,
                                //         color: kLightGreyColor,
                                //       ),
                                //       Text(
                                //         kCategory,
                                //         style: AppStyles.workSansTextStyle()
                                //             .copyWith(
                                //                 fontSize: 14.sp,
                                //                 fontWeight: FontWeight.w600),
                                //       ),
                                //       InkWell(
                                //           onTap: () {
                                //             showDialog(
                                //               context: context,
                                //               builder: (BuildContext context) {
                                //                 return filterPopup(context);
                                //               },
                                //             );
                                //           },
                                //           child: const Icon(
                                //             Icons.keyboard_arrow_down_outlined,
                                //             size: 24,
                                //             color: kPrimaryColor,
                                //           )),
                                //       Container(
                                //         width: 1,
                                //         color: kLightGreyColor,
                                //       ),
                                //       const Icon(
                                //         Icons.refresh,
                                //         color: kPrimaryColor,
                                //         size: 18,
                                //       ),
                                //       InkWell(
                                //         onTap: () {
                                //           controller.resetCategoryFilters();
                                //         },
                                //         child: Text(
                                //           "Reset Filter",
                                //           style: AppStyles.workSansTextStyle()
                                //               .copyWith(
                                //             fontSize: 14.sp,
                                //             fontWeight: FontWeight.w600,
                                //             color: kPrimaryColor,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: CustomButton(
                                      text: "Add New Blog",
                                      height: 56,
                                      width: 173,
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return addBlogDialogue(context);
                                          },
                                        );
                                      }),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Obx(() {
                              if (controller.isLoading.value) {
                                return SizedBox(
                                  height: 500.h,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              if (controller.paginatedBlogs.isEmpty) {
                                return const Center(
                                    child: Text("No blogs found"));
                              }
                              return Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                  border: Border.all(
                                      color: kTableBorderColor, width: 1),
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
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Views",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Category",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Date",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Actions",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: controller.paginatedBlogs
                                            .map((user) => _buildDataRow(
                                                user,
                                                user.title,
                                                controller
                                                    .formatDate(user.updatedAt),
                                                user.category,
                                                "${user.views} Views",
                                                context))
                                            .toList(),
                                        dataRowMaxHeight: 65,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 51,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: controller.isBlogBackDisabled
                                      ? null
                                      : controller.goToPreviousBlogPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isBlogBackDisabled
                                          ? kBackGroundColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back_ios_new_outlined,
                                            size: 12,
                                            color: controller.isBlogBackDisabled
                                                ? kBlackColor
                                                : kWhiteColor),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Back',
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color: controller.isBlogNextDisabled
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                ...List.generate(
                                  controller.blogTotalPages.value,
                                  (index) {
                                    bool isSelected = index + 1 ==
                                        controller.blogsCurrentPage.value;
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.changeBlogPage(index + 1),
                                      child: Padding(
                                        padding:
                                            AppStyles().paginationBtnPadding,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
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
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: controller.isBlogNextDisabled
                                      ? null
                                      : controller.goToNextBlogPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isBlogNextDisabled
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
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color: controller.isBlogNextDisabled
                                                ? kBlackColor
                                                : kWhiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,
                                            size: 12,
                                            color: controller.isBlogNextDisabled
                                                ? kBlackColor
                                                : kWhiteColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 51,
                            ),
                            Text(
                              "User Blogs",
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 32.sp, fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Obx(() {
                              if (controller.isLoading1.value) {
                                return SizedBox(
                                  height: 500.h,
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return Container(
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(14),
                                    topRight: Radius.circular(14),
                                  ),
                                  border: Border.all(
                                      color: kTableBorderColor, width: 1),
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
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Submission Date",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Submitted By",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Status",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
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
                                                "Actions",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: AppStyles
                                                        .workSansTextStyle()
                                                    .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: kWhiteColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: controller
                                            .userBlogsCurrentPageUsers
                                            .map((user) => _buildBlogDataRow(
                                                user.blogId,
                                                user.title,
                                                controller
                                                    .formatDate(user.updatedAt),
                                                user.postedBy.name ?? 'NA',
                                                user.blogStatus,
                                                user.blogStatus == 'approved'
                                                    ? kLightBlue
                                                        .withOpacity(0.2)
                                                    : user.blogStatus ==
                                                            'pending'
                                                        ? kPrimaryColor
                                                            .withOpacity(0.2)
                                                        : kBrownColor
                                                            .withOpacity(0.2),
                                                user.blogStatus == 'approved'
                                                    ? kLightBlue
                                                    : user.blogStatus ==
                                                            'pending'
                                                        ? kPrimaryColor
                                                        : kBrownColor,
                                                context))
                                            .toList(),
                                        dataRowMaxHeight: 65,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(
                              height: 51,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: controller.isUserBlogBackDisabled
                                      ? null
                                      : controller.goToPreviousUserBlogPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isUserBlogBackDisabled
                                          ? kBackGroundColor
                                          : kPrimaryColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(Icons.arrow_back_ios_new_outlined,
                                            size: 12,
                                            color: controller
                                                    .isUserBlogBackDisabled
                                                ? kBlackColor
                                                : kWhiteColor),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          'Back',
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color: controller
                                                    .isUserBlogNextDisabled
                                                ? kWhiteColor
                                                : kBlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                ...List.generate(
                                  controller.userBlogTotalPages.value,
                                  (index) {
                                    bool isSelected = index + 1 ==
                                        controller.userBlogsCurrentPage.value;
                                    return GestureDetector(
                                      onTap: () => controller
                                          .changeUserBlogPage(index + 1),
                                      child: Padding(
                                        padding:
                                            AppStyles().paginationBtnPadding,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 12),
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
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: controller.isUserBlogNextDisabled
                                      ? null
                                      : controller.goToNextUserBlogPage,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      color: controller.isUserBlogNextDisabled
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
                                          style: AppStyles.interTextStyle()
                                              .copyWith(
                                            fontSize: 12,
                                            color: controller
                                                    .isUserBlogNextDisabled
                                                ? kBlackColor
                                                : kWhiteColor,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.arrow_forward_ios_outlined,
                                            size: 12,
                                            color: controller
                                                    .isUserBlogNextDisabled
                                                ? kBlackColor
                                                : kWhiteColor),
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
      },
    ));
  }

  DataRow _buildDataRow(BlogModel blog, String title, String views,
      String category, String dateTime, context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(title,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle()
                .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600))),
        DataCell(Center(
            child: Text(
          dateTime,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ))),
        DataCell(Center(
            child: Text(category.toString(),
                textAlign: TextAlign.center,
                style: AppStyles.workSansTextStyle()
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600)))),
        DataCell(Center(
            child: Text(views,
                textAlign: TextAlign.center,
                style: AppStyles.workSansTextStyle()
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600)))),
        DataCell(
          Center(
            child: Container(
              height: 32,
              width: 96,
              decoration: BoxDecoration(
                  borderRadius: AppStyles.customBorder8,
                  color: kActionsBtnColor,
                  border: Border.all(color: kTableBorderColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return editBlogDialogue(context, blog);
                          },
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
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialog(
                              onDelete: () async {
                                await controller.deleteBlog1(blog.blogId);
                              },
                            );
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

  DataRow _buildBlogDataRow(
      String id,
      String title,
      String submissionDate,
      String submittedBy,
      String status,
      Color statusBackColor,
      Color statusColor,
      context) {
    double width = MediaQuery.of(context).size.width;

    return DataRow(
      cells: [
        DataCell(Text(title,
            textAlign: TextAlign.center,
            style: AppStyles.workSansTextStyle()
                .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600))),
        DataCell(Center(
            child: Text(
          submissionDate,
          textAlign: TextAlign.center,
          style: AppStyles.workSansTextStyle()
              .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ))),
        DataCell(Center(
            child: Text(submittedBy.toString(),
                textAlign: TextAlign.center,
                style: AppStyles.workSansTextStyle()
                    .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600)))),
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
                    style: AppStyles.workSansTextStyle().copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: statusColor),
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
              width: 96,
              decoration: BoxDecoration(
                  borderRadius: AppStyles.customBorder8,
                  color: kActionsBtnColor,
                  border: Border.all(color: kTableBorderColor)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return statusUpdateDialogue(context, id);
                          },
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
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteDialog(
                              onDelete: () async {
                                await controller.deleteBlog(id);
                              },
                            );
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
