import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timely/utils/routes/routes_name.dart';


class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.normal:
        // final args = settings.arguments as Map<String, dynamic>;
        print("");


     /* case RoutesName.otp:
        final args = settings.arguments as Map<String, dynamic>;
        var username = args['username'];
        var call_back = args['call_back'];
        return MaterialPageRoute(
          builder: (BuildContext context) =>
              OTPScreen(username: username, onLoginPressed: call_back),
        );*/


      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
