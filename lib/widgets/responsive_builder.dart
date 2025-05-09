import 'package:flutter/material.dart';
import '../core/app_export.dart';

class ResponsiveBuilder extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveBuilder({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (SizeUtils.deviceType == DeviceType.desktop && desktop != null) {
          return desktop!;
        } else if (SizeUtils.deviceType == DeviceType.tablet && tablet != null) {
          return tablet!;
        }
        return mobile;
      },
    );
  }
}