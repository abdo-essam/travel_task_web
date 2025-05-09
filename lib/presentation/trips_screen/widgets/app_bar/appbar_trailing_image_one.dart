import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';

import '../../../../theme/app_decoration.dart';
import '../../../../widgets/custom_image_view.dart';

class AppbarTrailingImageOne extends StatelessWidget {
  const AppbarTrailingImageOne({
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
        borderRadius: BorderRadiusStyle.circleBorder16,
        onTap: () {
          onTap?.call();
        },
        child: CustomImageView(
          imagePath: imagePath!,
          height: height ?? 24.h,
          width: width ?? 24.h,
          fit: BoxFit.contain,
          radius: BorderRadius.circular(16.h),
        ),
      ),
    );
  }
}
