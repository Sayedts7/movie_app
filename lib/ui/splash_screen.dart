import 'package:flutter/material.dart';

import '../core/utils/mySize.dart';
import '../core/utils/theme_helper.dart';
import 'movie_list_widget/movielistwidget.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Add a delay of 3 seconds before navigating to the next screen
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MovieListWidget(),
        ),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return  const Scaffold(
      backgroundColor: ThemeColors.mainColor,
      body: Center(child: Text("Movie App", style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700, color: Colors.white),)),
    );
  }
}
