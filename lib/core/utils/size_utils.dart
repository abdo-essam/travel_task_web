import 'package:flutter/material.dart';

// These are the Viewport values of your Figma Design.
const num FIGMA_DESIGN_WIDTH = 375;
const num FIGMA_DESIGN_HEIGHT = 812;
const num FIGMA_DESIGN_STATUS_BAR = 0;

// Web design values
const num WEB_DESIGN_WIDTH = 1440;
const num WEB_DESIGN_HEIGHT = 1024;

extension ResponsiveExtension on num {
  double get _width => SizeUtils.width;
  double get _webWidth => SizeUtils.width;

  // Responsive dimensions
  double get h {
    if (SizeUtils.deviceType == DeviceType.desktop) {
      return ((this * _webWidth) / WEB_DESIGN_WIDTH);
    } else {
      return ((this * _width) / FIGMA_DESIGN_WIDTH);
    }
  }

  // Responsive font sizes
  double get fSize {
    if (SizeUtils.deviceType == DeviceType.desktop) {
      // For desktop, use a more controlled scaling to avoid overly large text
      final scale = _webWidth / WEB_DESIGN_WIDTH;
      return (this * (scale > 1.2 ? 1.2 : scale)); // Cap scaling at 1.2x
    } else {
      return ((this * _width) / FIGMA_DESIGN_WIDTH);
    }
  }

  // Web-specific scaling
  double get w {
    if (SizeUtils.deviceType == DeviceType.desktop) {
      return ((this * _webWidth) / WEB_DESIGN_WIDTH);
    } else {
      return ((this * _width) / FIGMA_DESIGN_WIDTH);
    }
  }
}

extension FormatExtension on double {
  double toDoubleValue({int fractionDigits = 2}) {
    return double.parse(this.toStringAsFixed(fractionDigits));
  }

  double isNonZero({num defaultValue = 0.0}) {
    return this > 0 ? this : defaultValue.toDouble();
  }
}

enum DeviceType { mobile, tablet, desktop }

typedef ResponsiveBuild = Widget Function(
    BuildContext context,
    Orientation orientation,
    DeviceType deviceType,
    );

class Sizer extends StatelessWidget {
  const Sizer({Key? key, required this.builder}) : super(key: key);

  /// Builds the widget whenever the orientation changes.
  final ResponsiveBuild builder;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeUtils.setScreenSize(constraints, orientation);
            return builder(context, orientation, SizeUtils.deviceType);
          },
        );
      },
    );
  }
}

// ignore_for_file: must_be_immutable
class SizeUtils {
  /// Device's BoxConstraints
  static late BoxConstraints boxConstraints;

  /// Device's Orientation
  static late Orientation orientation;

  /// Type of Device
  static late DeviceType deviceType;

  /// Device's Height
  static late double height;

  /// Device's Width
  static late double width;

  static void setScreenSize(
      BoxConstraints constraints,
      Orientation currentOrientation,
      ) {
    boxConstraints = constraints;
    orientation = currentOrientation;

    // Set width and height based on orientation
    if (orientation == Orientation.portrait) {
      width = boxConstraints.maxWidth.isNonZero(
        defaultValue: FIGMA_DESIGN_WIDTH,
      );
      height = boxConstraints.maxHeight.isNonZero();
    } else {
      width = boxConstraints.maxHeight.isNonZero(
        defaultValue: FIGMA_DESIGN_WIDTH,
      );
      height = boxConstraints.maxWidth.isNonZero();
    }

    // Determine device type based on width
    if (width < 600) {
      deviceType = DeviceType.mobile;
    } else if (width < 1200) {
      deviceType = DeviceType.tablet;
    } else {
      deviceType = DeviceType.desktop;
    }
  }

  /// Get responsive value for width based on device type
  static double getResponsiveWidth(double value) {
    if (deviceType == DeviceType.desktop) {
      return (value * width) / WEB_DESIGN_WIDTH;
    } else {
      return (value * width) / FIGMA_DESIGN_WIDTH;
    }
  }

  /// Get responsive value for height based on device type
  static double getResponsiveHeight(double value) {
    if (deviceType == DeviceType.desktop) {
      return (value * height) / WEB_DESIGN_HEIGHT;
    } else {
      return (value * height) / FIGMA_DESIGN_HEIGHT;
    }
  }

  /// Get adaptive padding for different screen sizes
  static EdgeInsets getAdaptivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    double scale = deviceType == DeviceType.desktop ? 1.2 : 1.0;

    if (all != null) {
      final value = getResponsiveWidth(all) * scale;
      return EdgeInsets.all(value);
    }

    return EdgeInsets.only(
      left: left != null ? getResponsiveWidth(left) * scale :
      horizontal != null ? getResponsiveWidth(horizontal) * scale : 0,
      top: top != null ? getResponsiveHeight(top) * scale :
      vertical != null ? getResponsiveHeight(vertical) * scale : 0,
      right: right != null ? getResponsiveWidth(right) * scale :
      horizontal != null ? getResponsiveWidth(horizontal) * scale : 0,
      bottom: bottom != null ? getResponsiveHeight(bottom) * scale :
      vertical != null ? getResponsiveHeight(vertical) * scale : 0,
    );
  }

  /// Get adaptive font size for different screen sizes
  static double getAdaptiveFontSize(double fontSize) {
    double scaleFactor = deviceType == DeviceType.desktop ?
    (width / WEB_DESIGN_WIDTH).clamp(0.8, 1.2) :
    (width / FIGMA_DESIGN_WIDTH).clamp(0.8, 1.2);

    return fontSize * scaleFactor;
  }

  /// Calculate the number of grid columns based on screen width
  static int getGridColumns(double minWidth) {
    int columns = (width / minWidth).floor();
    return columns < 1 ? 1 : columns;
  }
}