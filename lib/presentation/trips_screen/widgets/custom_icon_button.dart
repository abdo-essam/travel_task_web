import 'package:flutter/material.dart';
import 'package:travel_task_web/core/app_export.dart';


extension IconButtonStyleHelper on CustomIconButton {
  static BoxDecoration get none => BoxDecoration();
}

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

  Widget get iconButtonWidget => SizedBox(
    height: height ?? 0,
    width: width ?? 0,
    child: DecoratedBox(
      decoration:
          decoration ??
          BoxDecoration(
            color: appTheme.gray90001,
            borderRadius: BorderRadius.circular(20.h),
          ),
      child: IconButton(
        padding: padding ?? EdgeInsetsDirectional.zero,
        onPressed: onTap,
        icon: child ?? Container(),
      ),
    ),
  );
}
