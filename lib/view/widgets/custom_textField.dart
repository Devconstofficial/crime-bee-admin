import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';

class MyCustomTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final VoidCallback? suffixOnPress;
  final VoidCallback? onTap;
  // final double fontSize;
  final Widget? prefixIcon;
  final Color? fillColor;
  // final FontWeight fontWeight;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Color? hintColor;
  final Color? textColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final String? errorText;
  final bool showError;
  final bool? isObscureText;
  final bool? errorBool;
  final double? width;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry? contentPadding;

  const MyCustomTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.suffixIcon,
    this.suffixOnPress,
    this.onTap,
    this.prefixIcon,
    this.controller,
    this.textInputType,
    this.fillColor,
    this.hintColor,
    this.textColor,
    this.errorText,
    this.isObscureText = false,
    this.showError = false,
    // required this.fontWeight,
    // required this.fontSize,
    this.width,
    this.onChanged,
    this.errorBool,
    this.maxLines,
    this.contentPadding,
    this.borderColor,
    this.focusBorderColor,
    this.suffixIconColor,
  });

  @override
  State<MyCustomTextField> createState() => _MyCustomTextFieldState();
}

class _MyCustomTextFieldState extends State<MyCustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: widget.onTap,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      obscureText: widget.isObscureText!,
      onChanged: widget.onChanged,
      // maxLines: widget.isObscureText! ? 1 : widget.maxLines,
      style: AppStyles.workSansTextStyle().copyWith(color: widget.textColor,fontSize: 12),
      decoration: InputDecoration(
        contentPadding: widget.contentPadding,
        labelText: widget.labelText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
          onPressed: widget.suffixOnPress,
          icon: Icon(widget.suffixIcon,color: widget.suffixIconColor ?? kLocationIconColor,size: 18,),
        )
            : null,
        fillColor: widget.fillColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: AppStyles.workSansTextStyle().copyWith(color: widget.textColor,fontSize: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppStyles.customBorderAll,
          borderSide: BorderSide(
            color: widget.focusBorderColor ?? kSecondaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppStyles.customBorderAll,
          borderSide: BorderSide(
            color: widget.borderColor ?? kBackGroundColor,
          ),
        ),
      ),
    );
  }
}