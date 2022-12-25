import 'package:bloc_with_freezed_with_test/config/routing_constants.dart';
import 'package:flutter/material.dart';

import '../login/login_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {

  currentRoute=settings.name!;
  switch (settings.name) {

    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) =>   LoginScreen());

    case otppage:
      // final args = settings.arguments as Map<String, dynamic>;
      // return MaterialPageRoute(
      //   builder: (context) => OtpScreen(
      //     mobileNo: args['mobileno'],
      //   ),
      // );


    case product:
      // final args = settings.arguments as Map<String, dynamic>;
      // return MaterialPageRoute(
      //   builder: (context) => ProductListScreen(
      //     mobileNo: args['id'],
      //   ),
      // );

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );

  }
}
