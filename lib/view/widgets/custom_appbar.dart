import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../utils/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? iconColor;
  final Color? backgroundColor;
  final List<Widget>? actions;
  bool? centreTitle = false;
  bool automaticallyLeading ;
  final Widget customTitle;
  bool? backArrow = false;



  CustomAppBar({super.key,
    this.iconColor,
    this.backgroundColor,
    this.actions,
    this.centreTitle,
    required this.automaticallyLeading,
    required this.customTitle,
    this.backArrow
  });

  @override
  Widget build(BuildContext context) {

    return AppBar(
      surfaceTintColor: kWhiteColor,
      leading: backArrow == true ? InkWell(
        onTap: () {
          Get.back();
        },
        child: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Icon(Icons.arrow_back_ios_new_outlined,size: 17,color: kBlackColor,),
        ),
      ) :
      const SizedBox.shrink(),
      backgroundColor: backgroundColor ?? kWhiteColor,
      iconTheme: IconThemeData(color: iconColor),
      title: customTitle,
      centerTitle: centreTitle ?? false,
      automaticallyImplyLeading: automaticallyLeading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
