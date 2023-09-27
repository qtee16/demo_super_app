import 'package:flutter/material.dart';
import 'package:launcher_app/view/app_screen.dart';
import 'package:launcher_app/view/main_app_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Map<String, dynamic>? arguments =
      settings.arguments as Map<String, dynamic>? ?? {};
    switch (settings.name) {
      case AppRoutes.home:
        return buildRoute(const MainApp(), settings: settings);
      case AppRoutes.appDetail:
        final app = arguments["app"];
        return buildRoute(AppScreen(app: app), settings: settings);
      default:
        return _errorRoute();
    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: const [
                SizedBox(
                  height: 450.0,
                  width: 450.0,
                  child: Text('ERROR'),
                ),
                Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}