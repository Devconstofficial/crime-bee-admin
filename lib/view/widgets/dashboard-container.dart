import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_styles.dart';

class DashboardContainer extends StatefulWidget {
  double? height;
  double? width;
  String? title;
  String? totalNumber;
  String? percent;
  Color? color;

  DashboardContainer(
      {super.key,
      this.width,
      this.height,
      this.title,
      this.percent,
      this.totalNumber,
      this.color});

  @override
  State<DashboardContainer> createState() => _DashboardContainerState();
}

class _DashboardContainerState extends State<DashboardContainer> {
  bool _isTitleHovered = false;
  bool _isRowHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            borderRadius: AppStyles.customBorder16, color: widget.color),
        child: Padding(
          padding: AppStyles().paddingAll21,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isTitleHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isTitleHovered = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: _isTitleHovered
                          ? kBlackColor1.withOpacity(0.1)
                          : widget.color,
                      borderRadius: AppStyles.customBorder16),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text(
                          '${widget.title}',
                          style: AppStyles.workSansTextStyle()
                              .copyWith(fontSize: 14, color: kWhiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              MouseRegion(
                onEnter: (_) {
                  setState(() {
                    _isRowHovered = true;
                  });
                },
                onExit: (_) {
                  setState(() {
                    _isRowHovered = false;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: _isRowHovered
                        ? kBlackColor1.withOpacity(0.1)
                        : widget.color,
                    borderRadius: AppStyles.customBorder16,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _isRowHovered
                            ? Row(
                                children: [
                                  Text(
                                    widget.percent ?? '',
                                    style: AppStyles.workSansTextStyle().copyWith(
                                      fontSize: 12,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  SvgPicture.asset(
                                    kArrowIcon,
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              )
                            : Text(
                                widget.totalNumber ?? '',
                                style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 24,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                        !_isRowHovered
                            ? Row(
                                children: [
                                  Text(
                                    widget.percent ?? '',
                                    style: AppStyles.workSansTextStyle().copyWith(
                                      fontSize: 12,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                  const SizedBox(width: 11),
                                  SvgPicture.asset(
                                    kArrowIcon,
                                    height: 10,
                                    width: 10,
                                  ),
                                ],
                              )
                            : Text(
                                widget.totalNumber ?? '',
                                style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 24,
                                  color: kWhiteColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
