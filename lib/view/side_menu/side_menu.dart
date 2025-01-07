import 'package:crime_bee_admin/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';
import '../../utils/app_strings.dart';
import 'controller/menu_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final menuController = Get.put(MenuControllers());

  @override
  Widget build(BuildContext context) {
    // bool isTablet = ResponsiveBreakpoints.of(context).largerThan(TABLET);
    double width = MediaQuery.of(context).size.width;

    return Drawer(
      backgroundColor: kWhiteColor,
      shape: const Border(right: BorderSide(color: kBackGroundColor)),
      width: 220,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 170,
              child: DrawerHeader(
                child: SizedBox(
                    height: 170,
                    width: 140,
                    child: Center(
                        child: Image  .asset(
                          kLogo1,
                          fit: BoxFit.contain,
                        ),)),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(0);
                              Get.toNamed(kDashboardScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 49,
                                      decoration: BoxDecoration(
                                        color: menuController.selectedIndex.value == 0 ? kPrimaryColor : kWhiteColor,
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only( left: 24),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                              kDashboardIcon,
                                              height: 26,
                                              width: 26,
                                              colorFilter: ColorFilter.mode(
                                                menuController.selectedIndex.value == 0 ? kWhiteColor : kBlackColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                            Text(
                                                "Dashboard",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 0
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                  fontSize: 16
                                                ),
                                              ),
                                          ],
                                        ),
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 0 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(1);
                              Get.toNamed(kUserScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 1 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kPersonIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 1 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "User",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 1
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 1 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(2);
                              Get.toNamed(kAddCrimeDashboardRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 2 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kClownIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 2 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Add Crime",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 2
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16

                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 2 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(3);
                              Get.toNamed(kSubscriptionScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 3 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kSubscriptionIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 3 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Subscription",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 3
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16

                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 3 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(4);
                              Get.toNamed(kCommentScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 4 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kCommentIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 4 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Comments",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 4
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16

                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 4 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(5);
                              Get.toNamed(kBlogScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 5 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kBlogIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 5 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Blogs",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 5
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 5 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(6);
                              Get.toNamed(kNotificationScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 6 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                kNotificationIcon,
                                                height: 26,
                                                width: 26,
                                                color: menuController.selectedIndex.value == 6 ?
                                                kWhiteColor : kBlackColor,
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Notification",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                  color: menuController.selectedIndex.value == 6
                                                      ? kWhiteColor
                                                      : kBlackColor,
                                                    fontSize: 16

                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 6 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(height: 20,),
                      Obx(() {
                        return MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              menuController.onItemTapped(7);
                              Get.toNamed(kTermsScreenRoute);
                            },
                            child: SizedBox(
                              width: width,
                              height: 49,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 49,
                                        decoration: BoxDecoration(
                                          color: menuController.selectedIndex.value == 7 ? kPrimaryColor : kWhiteColor,
                                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only( left: 24),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                kTermsIcon,
                                                height: 26,
                                                width: 26,
                                                colorFilter: ColorFilter.mode(
                                                  menuController.selectedIndex.value == 7 ? kWhiteColor : kBlackColor,
                                                  BlendMode.srcIn,
                                                ),
                                              ),
                                              SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                              Text(
                                                "Terms",
                                                style: AppStyles.workSansTextStyle().copyWith(
                                                    color: menuController.selectedIndex.value == 7
                                                        ? kWhiteColor
                                                        : kBlackColor,
                                                    fontSize: 16

                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: 49,
                                    width: 5,
                                    color: menuController.selectedIndex.value == 7 ? kSecondaryColor : kWhiteColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 15),
              child: Obx(() {
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      menuController.onItemTapped(8);
                      Get.offAllNamed(kLoginScreenRoute);
                    },
                    child: SizedBox(
                      width: width,
                      height: 49,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                height: 49,
                                decoration: BoxDecoration(
                                  color: menuController.selectedIndex.value == 8 ? kPrimaryColor : kWhiteColor,
                                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only( left: 24),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        kLogoutIcon,
                                        height: 22,
                                        width: 22,
                                        colorFilter: const ColorFilter.mode(
                                          kPrimaryColor,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width * 0.01,),
                                      Text(
                                        "Logout",
                                        style: AppStyles.workSansTextStyle().copyWith(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 15.sp
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                            ),
                          ),
                          Container(
                            height: 49,
                            width: 5,
                            color: menuController.selectedIndex.value == 8 ? kSecondaryColor : kWhiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
