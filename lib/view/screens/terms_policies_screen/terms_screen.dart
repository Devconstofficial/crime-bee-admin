import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';
import '../../widgets/notifiction_panel.dart';
import 'controller/terms_controller.dart';
import 'package:flutter_quill/flutter_quill.dart';

class TermsScreen extends GetView<TermsController> {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                    const SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: AppStyles().horizontal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Policy Management",
                            style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 41,
                            width: Get.width / 4.5,
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: SizedBox(
                                      width: Get.width / 5.5,
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
                                              color:
                                                  ksuffixColor.withOpacity(0.2),
                                            ),
                                            // contentPadding: const EdgeInsets.only(top: 9),
                                            prefixIcon: Icon(
                                              Icons.search_sharp,
                                              size: 16,
                                              color:
                                                  ksuffixColor.withOpacity(0.2),
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
                                            )),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '⌘/',
                                    style: AppStyles.interTextStyle().copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: ksuffixColor.withOpacity(0.2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
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
                      padding: AppStyles().horizontal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(() {
                            return Wrap(
                              runSpacing: 45,
                              spacing: 45,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: ()=> controller.onChangeIndex(0),
                                  child: Container(
                                    height: 56,
                                    width: 173,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controller.selectedIndex.value == 0
                                          ? kPrimaryColor
                                          : kPrimaryColor.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Privacy Policy',
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: ()=> controller.onChangeIndex(1),
                                  child: Container(
                                    height: 56,
                                    width: 178,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controller.selectedIndex.value == 1
                                          ? kPrimaryColor
                                          : kPrimaryColor.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cookies Policy',
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: ()=> controller.onChangeIndex(2),
                                  child: Container(
                                    height: 56,
                                    width: 217,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: controller.selectedIndex.value == 2
                                          ? kPrimaryColor
                                          : kPrimaryColor.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Terms & Conditions',
                                        style: AppStyles.workSansTextStyle()
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                          const SizedBox(
                            height: 34,
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
                            if (controller.isEditing.value) {
                              return SizedBox(
                                height: 600,
                                child: Column(
                                  children: [
                                    QuillSimpleToolbar(
                                      controller: controller.quillController,
                                      configurations: const QuillSimpleToolbarConfigurations(
                                        color: kWhiteColor,
                                        showUndo: false,
                                        showUnderLineButton: true,
                                        showSuperscript: false,
                                        showSubscript: false,
                                        showStrikeThrough: false,
                                        showSearchButton: false,
                                        showRightAlignment: false,
                                        sectionDividerSpace: 10,
                                        toolbarSectionSpacing: 10,
                                        showBackgroundColorButton: false,
                                        showDirection: false,
                                        showClipboardCopy: false,
                                        showClipboardCut: false,
                                        showCenterAlignment: false,
                                        showJustifyAlignment: false,
                                        showLeftAlignment: true,
                                        showSmallButton: false,
                                        showRedo: false,
                                        showQuote: true,
                                        showListNumbers: true,
                                        showListBullets: true,
                                        multiRowsDisplay: false,
                                        showListCheck: false,
                                        showItalicButton: true,
                                        showAlignmentButtons: true,
                                        showBoldButton: true,
                                        showIndent: false,
                                        showHeaderStyle: false,
                                        showFontSize: false,
                                        showFontFamily: false,
                                        showDividers: false,
                                        showLink: false,
                                        showClipboardPaste: false,
                                        showColorButton: false,
                                        showCodeBlock: false,
                                        showClearFormat: false,
                                        showInlineCode: true,
                                        showLineHeightButton: false,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: kFieldBorderColor,
                                            width: 1,
                                          ),
                                        ),
                                        child: QuillEditor.basic(
                                          controller: controller.quillController,
                                          configurations: const QuillEditorConfigurations(
                                            padding: EdgeInsets.all(20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return QuillEditor.basic(
                              controller: controller.readOnlyQuillController,
                              configurations: const QuillEditorConfigurations(
                                padding: EdgeInsets.all(20),
                                showCursor: false,
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 200,
                          ),
                          Obx(() {
                            if (controller.isEditing.value) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  CustomButton(
                                    textColor: controller.enabledUpdate.value
                                        ? kWhiteColor
                                        : kDisableBtnTextColor,
                                    text: "UPDATE",
                                    height: 40,
                                    width: 114,
                                    fontSize: 14.sp,
                                    onTap: controller.setPolicies,
                                    color: controller.enabledUpdate.value
                                        ? kPrimaryColor
                                        : kDisableButtonColor,
                                    borderColor: controller.enabledUpdate.value
                                        ? kPrimaryColor
                                        : kDisableButtonColor,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CustomButton(
                                    text: "DISCARD CHANGES",
                                    height: 40,
                                    width: 171,
                                    fontSize: 14.sp,
                                    textColor: controller.enabledDiscardChange.value
                                        ? kWhiteColor
                                        : kDisableBtnTextColor,
                                    onTap: () {
                                      controller.readOnlyQuillController
                                          .document = Document.fromDelta(
                                        Delta()
                                          ..insert(
                                              "${controller.selectedTermModel.text}\n"),
                                      );
                                    },
                                    color: controller.enabledDiscardChange.value
                                        ? kPrimaryColor
                                        : kDisableButtonColor,
                                    borderColor: controller.enabledDiscardChange.value
                                        ? kPrimaryColor
                                        : kDisableButtonColor,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  CustomButton(
                                    fontSize: 14.sp,
                                    textColor: kBlackColor,
                                    text: "CANCEL",
                                    height: 40,
                                    width: 90,
                                    onTap: () {
                                      controller.toggleEditing();
                                    },
                                    color: kWhiteColor,
                                    borderColor: kFieldBorderColor,
                                  ),
                                ],
                              );
                            }
                            return Center(
                              child: CustomButton(
                                text: "Edit ${controller.selectedIndex.value==0? "Privacy Policy": controller.selectedIndex.value == 1? "Cookies Policy" : "Terms & Conditions"}",
                                height: 56,
                                onTap: () {
                                  controller.toggleEditing();
                                },
                                width: 209,
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 50,
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
}
