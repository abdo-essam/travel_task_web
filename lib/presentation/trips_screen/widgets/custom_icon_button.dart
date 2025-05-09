import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';


class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.decoration,
    this.padding,
    this.onTap,
    this.child,
  });

  final AlignmentGeometry? alignment;
  final double? height;
  final double? width;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? AlignmentDirectional.center,
      child: iconButtonWidget,
    )
        : iconButtonWidget;
  }

  Widget get iconButtonWidget => Container(
    height: height ?? 32.h,
    width: width ?? 32.h,
    decoration: decoration ??
        BoxDecoration(
          color: appTheme.gray90001,
          shape: BoxShape.circle,
        ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(height != null ? height! / 2 : 16.h),
        onTap: onTap,
        child: Center(
          child: padding != null
              ? Padding(
            padding: padding!,
            child: child ?? Container(),
          )
              : child ?? Container(),
        ),
      ),
    ),
  );
}
