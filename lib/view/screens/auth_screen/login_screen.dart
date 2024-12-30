import 'dart:developer';
import 'package:crime_bee_admin/utils/app_strings.dart';
import 'package:crime_bee_admin/view/screens/auth_screen/controller/auth_controller.dart';
import 'package:crime_bee_admin/view/widgets/custom_button.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';
import '../../side_menu/side_menu.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          CommonCode.unFocus(context);
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 57),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 196,
                      width: 196,
                      child: Image.asset(kLogo1, fit: BoxFit.contain,),
                    ),
                  ),
                  SizedBox(height: 44,),
                  Center(
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text('Welcome back!',
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 40.sp, fontWeight: FontWeight.w600),),
                          ),
                          SizedBox(height: 4,),
                          Center(
                            child: Text(
                              'Log In to your Crime Bee account to have admin access.',
                              style: AppStyles.workSansTextStyle().copyWith(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: kLoginDetailColor),),
                          ),
                          SizedBox(height: 44,),
                          Text('Email Address',
                            style: AppStyles.workSansTextStyle().copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: kLoginDetailColor),),
                          MyCustomTextField(
                            hintText: "Enter your email address",
                            fillColor: kWhiteColor,
                            borderColor: kFieldBorderColor,
                            contentPadding: EdgeInsets.all(20),
                          ),
                          SizedBox(height: 24,),
                          Text('Password',
                            style: AppStyles.workSansTextStyle().copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: kLoginDetailColor),),
                          const MyCustomTextField(
                            hintText: "Enter your password",
                            fillColor: kWhiteColor,
                            borderColor: kFieldBorderColor,
                            contentPadding: EdgeInsets.all(20),
                            suffixIcon: Icons.remove_red_eye_outlined,
                          ),
                          const SizedBox(height: 32,),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: (){
                                Get.toNamed(kDashboardScreenRoute);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 64,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kPrimaryColor
                                ),
                                child: Center(
                                  child: Text('Login',
                                    style: AppStyles.workSansTextStyle().copyWith(
                                        fontSize: 20.sp, fontWeight: FontWeight.w500,color: kWhiteColor),),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}

