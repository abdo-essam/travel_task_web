import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';

import '../../../../widgets/custom_image_view.dart';

class AppbarTitleImage extends StatelessWidget {
  const AppbarTitleImage({
    super.key,
    this.imagePath,
    this.height,
    this.width,
    this.onTap,
    this.margin,
  });

  final double? height;

  final double? width;

  final String? imagePath;

  final Function? onTap;

  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          onTap?.call();
        },
        child: SizedBox(
          width: double.maxFinite,
          child: CustomImageView(
            imagePath: imagePath!,
            height: height ?? 24.h,
            width: width ?? 24.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
