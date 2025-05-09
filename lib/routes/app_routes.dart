import 'package:flutter/material.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/trips_screen/trips_screen.dart';
import '../presentation/web_trips_screen/web_trips_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String tripsScreen = '/trips_screen';
  static const String webTripsScreen = '/web_trips_screen';
  static const String initialRoute = splashScreen;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case tripsScreen:
        return MaterialPageRoute(
          builder: (context) => ResponsiveLayoutRoute(
            mobile: TripsScreen(),
            desktop: WebTripsScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => ResponsiveLayoutRoute(
            mobile: TripsScreen(),
            desktop: WebTripsScreen(),
          ),
        );
    }
  }

  static Map<String, WidgetBuilder> routes = {
    splashScreen: (context) => SplashScreen(),
    tripsScreen: (context) => ResponsiveLayoutRoute(
      mobile: TripsScreen(),
      desktop: WebTripsScreen(),
    ),
  };
}

class ResponsiveLayoutRoute extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayoutRoute({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200 && desktop != null) {
          return desktop!;
        } else if (constraints.maxWidth >= 600 && tablet != null) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}