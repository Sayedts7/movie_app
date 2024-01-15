import 'package:Movie_App/ui/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:device_preview/device_preview.dart';

import 'core/providers/fav_provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    //device preview to check apps responsiveness on different screens
    DevicePreview(
      enabled: false,
    //uncomment the code below to use device preview
    // enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme: ThemeData(
      
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

