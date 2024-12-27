import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import 'custom_button.dart';

class DeleteDialog extends StatelessWidget {
  VoidCallback onDelete;
  DeleteDialog({super.key,required this.onDelete});

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 10),
                SizedBox(
                  height: 96,
                  width: 96,
                  child: SvgPicture.asset(
                    kDeleteDialogIcon,
                    height: 16,
                    width: 16,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Confirm Delete?",
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: 20.sp,fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    textAlign: TextAlign.center,
                    kDeleteDetail,
                    style: AppStyles.workSansTextStyle().copyWith(fontSize: 15.sp,fontWeight: FontWeight.w400,color: kGrey),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(text: "Cancel", height: 40, onTap: (){
                      Get.back();
                    },width: 75,textColor: kBlackColor,color: kWhiteColor,borderColor: kFieldBorderColor,fontSize: 14,),
                    CustomButton(text: "Confirm Deletion", height: 40, onTap: onDelete,width: 145,color: kPrimaryColor,fontSize: 14,),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

