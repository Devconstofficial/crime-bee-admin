import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_styles.dart';

class NotificationAndActivitySection extends StatelessWidget {
  final List notifications;
  final List activities;

  const NotificationAndActivitySection({
    super.key,
    required this.notifications,
    required this.activities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: kBackGroundColor, width: 2)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Notification",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 252,
                child: ListView.builder(
                  itemCount: notifications.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              borderRadius: AppStyles.customBorder8,
                              color: notification['backColor']
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                kUserIcon,
                                height: 12,
                                width: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 7),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['title']!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                notification['time']!,
                                style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kBlackColor.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "Activities",
                style: AppStyles.workSansTextStyle().copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: activities.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Container(
                            height: 24,
                            width: 24,
                            decoration: BoxDecoration(
                              borderRadius: AppStyles.customBorderAll100,
                              color: activity['backColor'],
                            ),
                            child: ClipRRect(
                              borderRadius: AppStyles.customBorderAll100,
                              child: Center(
                                child: SvgPicture.asset(
                                  kUserIcon,
                                  height: 12,
                                  width: 12,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  activity['title']!,
                                  style: AppStyles.workSansTextStyle().copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  activity['time']!,
                                  style: AppStyles.workSansTextStyle().copyWith(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: kBlackColor.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
