import 'package:car_price_prediction/screens/about_developer.dart';
import 'package:car_price_prediction/screens/more_charts.dart';
import 'package:flutter/material.dart';
import './screens/chart_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Price Prediction',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Car Price Prediction'),
      routes: {
        Charts.routeName: (context) =>
            const Charts(title: 'Car Price Prediction'),
        MoreChartsMain.routeName: (context) =>
            const MoreChartsMain(title: 'Car Price Prediction'),
        AboutDeveloperScreen.routeName: (context) => AboutDeveloperScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 38, 38, 38),
        body: Home(title: 'Car Price Prediction'),
      ),
    );
  }
}
