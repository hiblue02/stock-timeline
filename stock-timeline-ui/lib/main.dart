import 'package:flutter/material.dart';
import 'package:ui/app_colors.dart';

import 'chart_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock TimeLine',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainBlue),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            foregroundColor: Colors.white,
            backgroundColor: AppColors.mainBlue,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            // Button color
            textStyle: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
        ),
        // Text Style
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.normal,
            color: AppColors.mainBlue,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // AppBar background color
          foregroundColor: AppColors.mainBlue, // Title text color
          titleTextStyle: TextStyle(
            // fontSize: 20, // Title font size
            fontWeight: FontWeight.bold, // Title font weight
            color: AppColors.mainBlue
          ),
        ),
      ),
      home: const HomePage(title: 'Stock TimeLine'),
    );
  }
}

class HomePage extends StatelessWidget {
  final String title;

  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text('Stock Timeline',
                style: TextStyle(
                    fontSize: 100,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainBlue)),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChartsListPage()),
                  );
                },
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
          ]),
        ));
  }
}
