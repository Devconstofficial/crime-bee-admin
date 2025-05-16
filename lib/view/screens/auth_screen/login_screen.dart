import 'package:crime_bee_admin/view/screens/auth_screen/controller/login_controller.dart';
import 'package:crime_bee_admin/view/widgets/custom_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/common_code.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CommonCode.unFocus(context);
      },
      child: Scaffold(
        key: controller.screenKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 57.h,
            ),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 196.h,
                    width: 196.w,
                    child: Image.asset(
                      kLogo1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                Center(
                  child: SizedBox(
                    width: 500.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Welcome back!',
                            style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 40.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Center(
                          child: Text(
                            'Log In to your Crime Bee account to have admin access.',
                            style: AppStyles.workSansTextStyle().copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: kLoginDetailColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 44.h,
                        ),
                        Text(
                          'Email Address',
                          style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: kLoginDetailColor,
                          ),
                        ),
                        MyCustomTextField(
                          hintText: "Enter your email address",
                          fillColor: kWhiteColor,
                          borderColor: kFieldBorderColor,
                          contentPadding: EdgeInsets.all(20.sp),
                          onChanged: (value) => controller.validateEmail(),
                          controller: controller.emailController,
                        ),
                        Obx(() {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Visibility(
                              visible: controller.emailErrorMsg.isNotEmpty,
                              child: Text(
                                controller.emailErrorMsg.value,
                                style: AppStyles.headingTextStyle().copyWith(
                                  color: kPrimaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          'Password',
                          style: AppStyles.workSansTextStyle().copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: kLoginDetailColor,
                          ),
                        ),
                        Obx(() {
                          return MyCustomTextField(
                            hintText: "Enter your password",
                            borderColor: kGrey1.withOpacity(0.2),
                            fillColor: kWhiteColor,
                            controller: controller.passwordController,
                            onChanged: (value) => controller.validatePassword(),
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            contentPadding: EdgeInsets.all(20.sp),
                            suffixOnPress: () {
                              controller.showPassword.toggle();
                            },
                            suffixIcon: controller.showPassword.value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            isObscureText: !controller.showPassword.value,
                          );
                        }),
                        Obx(() {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Visibility(
                              visible: controller.passwordErrorMsg.isNotEmpty,
                              child: Text(
                                controller.passwordErrorMsg.value,
                                style: AppStyles.headingTextStyle().copyWith(
                                  color: kPrimaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          );
                        }),
                        SizedBox(
                          height: 32.h,
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: controller.onLoginButton,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 64.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: kPrimaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  'Login',
                                  style: AppStyles.workSansTextStyle().copyWith(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w500,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
