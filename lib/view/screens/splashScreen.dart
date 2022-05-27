import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/images/todo.png"),
                fit: BoxFit.contain),
        ),
        // gradient: LinearGradient(
        //     colors: ColorsUtil.linear,
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight)),
      ),
    );
  }
}
