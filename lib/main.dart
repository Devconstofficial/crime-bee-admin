import 'package:crime_bee_admin/firebase_options.dart';
import 'package:crime_bee_admin/utils/app_colors.dart';
import 'package:crime_bee_admin/utils/app_styles.dart';
import 'package:crime_bee_admin/utils/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'utils/app_strings.dart';
import 'utils/screen_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      timePickerTheme: const TimePickerThemeData(
        backgroundColor: kWhiteColor,
      ),
      primaryColor: kWhiteColor,
      scaffoldBackgroundColor: kWhiteColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: kWhiteColor,
        iconTheme: IconThemeData(color: kBlackColor),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppStyles.workSansTextStyle().copyWith(
          fontSize: 14,
          color: kLightBlackColor,
        ),
        prefixIconColor: kLightBlackColor,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 12,
        ),
        fillColor: kBackGroundColor,
        filled: true,
        iconColor: kBackGroundColor,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kBackGroundColor),
          borderRadius: AppStyles.customBorderAll,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kPrimaryColor),
          borderRadius: AppStyles.customBorderAll,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.customBorderAll,
          borderSide: const BorderSide(color: kSecondaryColor),
        ),
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(color: kBlackColor, fontSize: 14),
        bodyLarge: TextStyle(color: kBlackColor, fontSize: 14),
        bodyMedium: TextStyle(color: kBlackColor, fontSize: 14),
      ),
      colorScheme: ThemeData().colorScheme.copyWith(primary: kSecondaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1440, 1024),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          theme: _buildTheme(Brightness.light),
          title: kAppName,
          debugShowCheckedModeBanner: false,
          initialBinding: ScreenBindings(),
          initialRoute: kLoginScreenRoute,
          getPages: RouteGenerator.getPages(),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                  MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                ),
              ),
              child: child!,
            );
          },
        );
      },
    );
  }
}
