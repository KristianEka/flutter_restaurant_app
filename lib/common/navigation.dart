import 'package:flutter/widgets.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static Future<dynamic>? intentWithDataAndReturn(
      String routeName, Object arguments) {
    return navigatorKey.currentState
        ?.pushNamed(routeName, arguments: arguments);
  }

  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static intent(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static back() => navigatorKey.currentState?.pop();
}
