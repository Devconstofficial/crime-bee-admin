import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_styles.dart';

class DashboardContainer extends StatelessWidget {
  double? height;
  double? width;
  String? title;
  String? totalNumber;
  String? percent;
  Color? color;
  DashboardContainer({super.key,this.width,this.height,this.title,this.percent,this.totalNumber,this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: AppStyles.customBorder16,
          color: color
      ),
      child: Padding(
        padding: AppStyles().paddingAll24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$title',style: AppStyles.workSansTextStyle().copyWith(fontSize: 14,color: kWhiteColor),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$totalNumber',style: AppStyles.workSansTextStyle().copyWith(fontSize: 24,color: kWhiteColor,fontWeight: FontWeight.w600),),
                Row(
                  children: [
                    Text('$percent%',style: AppStyles.workSansTextStyle().copyWith(fontSize: 12,color: kWhiteColor),),
                    const SizedBox(width: 11,),
                    SvgPicture.asset(
                      kArrowIcon,
                      height: 10,
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
