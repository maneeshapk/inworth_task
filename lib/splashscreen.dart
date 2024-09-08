import 'package:demo/api.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const SuperheroList(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 136, 125, 125),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/sp1.gif",
              width: 800,
              height: 1000,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.width / 1 - 200,
            child: const Text(
              'SUPER HEROES',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 12, 12, 12),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
