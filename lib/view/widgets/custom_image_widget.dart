import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class CustomImageWidget extends StatelessWidget {
  final String imageAddress;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final Color? color;
  final bool isColorBlendMode;
  final EdgeInsets? padding;
  final Widget? errorWidget;

  const CustomImageWidget({
    super.key,
    required this.imageAddress,
    this.height,
    this.width,
    this.boxFit,
    this.isColorBlendMode=false,
    this.padding,
    this.color, this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if(imageAddress.isEmpty) {
      return Container(
        height: height,
        width: width,
        padding: padding,
        child: FittedBox(
          child: errorWidget ??  const Icon(Icons.error_outline),
        ),
      );
    } else if(imageAddress.startsWith("http")) {
      return CachedNetworkImage(
        imageUrl: imageAddress,
        height: height,
        width: width,
        fit: boxFit,
        color:isColorBlendMode? Colors.black54:color,
        colorBlendMode: BlendMode.darken,
        placeholder: (_, str) {
          return Shimmer.fromColors(
            period: const Duration(milliseconds: 2500),
            baseColor: kPrimaryColor,
            highlightColor: Colors.black,
            child: Container(
              height: height,
              width: width,
              padding: padding,
              color: Colors.black.withOpacity(0.3),
              child: FittedBox(
                child: Image.asset(
                  kLogo,
                  fit: boxFit ?? BoxFit.contain,
                  height: height,
                  width: width,
                ),
              ),
            ),
          );
        },
        errorWidget: (_, str, obj) {
          return Container(
            height: height,
            width: width,
            color: Colors.black.withOpacity(0.3),
            padding: padding,
            child: errorWidget ?? Image.asset(
              kLogo,
              fit: boxFit ?? BoxFit.contain,
              height: height,
              width: width,
            ),
          );
        },
      );
    } else if(imageAddress.endsWith(".svg")) {
      return SvgPicture.asset(
        imageAddress,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.contain,
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      );
    } else if(_isLocalFile(imageAddress)) {
      return Image.file(
        File(imageAddress),
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.contain,
        color: color,
        errorBuilder: (ctx,err,stc) {
          return Container(
            height: height,
            width: width,
            padding: padding,
            child: errorWidget ??  const Icon(Icons.error_outline),
          );
        },
      );
    }
    return Image.asset(
      imageAddress,
      height: height,
      width: width,
      fit: boxFit,
      color: color,
      errorBuilder: (ctx,err,stc) {
        return Container(
          height: height,
          width: width,
          padding: padding,
          child: errorWidget ??  const Icon(Icons.error_outline),
        );
      },
    );
  }

  bool _isLocalFile(String path) {
    return File(path).existsSync();
  }
}