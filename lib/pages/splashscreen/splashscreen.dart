import 'dart:async';

import 'package:autonomo_app/whapper.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Whapper()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          child: FlareActor(
            "lib/images/Logo.flr",
            animation: "Untitled",
          ),
        ),
      ),
    );
  }
}
