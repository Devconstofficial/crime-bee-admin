import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class FilterButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? width;
  final double height;
  final double? fontSize;
  final VoidCallback onTap;
  bool? isImage = false;
  String? image;
  // bool? buttonTextStyle = false;

  FilterButton(
      {super.key,
        required this.text,
        this.color,
        this.textColor,
        this.width,
        required this.height,
        required this.onTap,
        this.isImage,
        this.image,
        this.borderColor,
        // this.buttonTextStyle,
        this.fontSize
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? kPrimaryColor),
            borderRadius: AppStyles.customBorderAll100,
            color: color ?? kPrimaryColor
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  text,
                  style: AppStyles.workSansTextStyle().copyWith(fontSize: fontSize ?? 16.sp,fontWeight: FontWeight.w600,color: textColor ?? kWhiteColor)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
