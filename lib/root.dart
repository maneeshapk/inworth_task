import 'package:demo/api.dart';
import 'package:demo/routes.dart';
import 'package:demo/splashscreen.dart';
import 'package:flutter/material.dart';


class Root extends StatelessWidget {
  const Root({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,

      initialRoute:Routes.splashscreen ,

      routes: {
        Routes.splashscreen:(context) => const SplashScreen(),
        Routes.api:(context)=>  const SuperheroList()
      },
    );
  }
}