import 'package:bloc_with_freezed_with_test/login/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:bloc_with_freezed_with_test/config/app_router.dart' as router;

import 'config/routing_constants.dart';


void main() {
  runApp(MyApp());
}




class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [

        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: const MaterialApp(
        onGenerateRoute: router.generateRoute,
        initialRoute: loginScreenRoute,
        title: "Test Bloc",
      ),


    );
  }
}
