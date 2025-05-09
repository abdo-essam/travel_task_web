import 'package:flutter/material.dart';

import '../../../../core/utils/size_utils.dart';
import '../../../../theme/theme_helper.dart';

enum Style { bgOutlineGray900, transparent }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height,
    this.shape,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
    this.onLeadingTapped,
  });

  final double? height;
  final ShapeBorder? shape;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;
  final VoidCallback? onLeadingTapped;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      shape: shape,
      toolbarHeight: height ?? (SizeUtils.deviceType == DeviceType.desktop ? 80.h : 72.h),
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading != null
          ? InkWell(
        onTap: onLeadingTapped,
        child: Center(child: leading),
      )
          : null,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
      SizeUtils.width,
      height ?? (SizeUtils.deviceType == DeviceType.desktop ? 80.h : 72.h)
  );

  _getStyle() {
    switch (styleType) {
      case Style.bgOutlineGray900:
        return Container(
          height: SizeUtils.deviceType == DeviceType.desktop ? 80.h : 72.h,
          width: SizeUtils.width,
          decoration: BoxDecoration(
            color: appTheme.black900,
            border: Border(
              bottom: BorderSide(color: appTheme.gray900, width: 1.h),
            ),
          ),
        );
      case Style.transparent:
        return Container(
          height: SizeUtils.deviceType == DeviceType.desktop ? 80.h : 72.h,
          width: SizeUtils.width,
          color: Colors.transparent,
        );
      default:
        return Container(
          height: SizeUtils.deviceType == DeviceType.desktop ? 80.h : 72.h,
          width: SizeUtils.width,
          color: appTheme.black900,
        );
    }
  }
}