import 'package:bloc_with_freezed_with_test/config/routing_constants.dart';
import 'package:bloc_with_freezed_with_test/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../login/bloc/login_bloc.dart';
import '../login/bloc/login_bloc2.dart';
import '../login/login_screen.dart';

final _loginBloc = LoginBloc();
final _loginBloc2 = LoginBloc2();

Route<dynamic> generateRoute(RouteSettings settings) {

  currentRoute = settings.name!;
  switch (settings.name) {
    // case loginScreenRoute:
    //   return MaterialPageRoute(builder: (context) => LoginScreen());
    //
    case loginScreenRoute:
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                providers: [
                  // we can add mulitple here...

                  BlocProvider.value(
                    value: _loginBloc,
                  ),

                  BlocProvider.value(
                    value: _loginBloc2,
                  ),


                ],
                child: LoginScreen(),
              ));
    // case otppage:
    //   final args = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => OtpScreen(
    //       email: args['email'],
    //     ),
    //   );

    case otppage:
      // final args = settings.arguments as Map<String, dynamic>;
      return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
                  providers: [
                    // we can add mulitple here...

                    BlocProvider.value(
                      value: _loginBloc,
                    ),

                    BlocProvider.value(
                      value: _loginBloc2,
                    ),
                  ],
                  child: OtpScreen(
                    // email: args['email'],
                  )));

    case dashboardScreenRoute:
      return MaterialPageRoute(builder: (context) => LoginScreen());

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
