import 'package:flutter/material.dart';

class MoreChartsMain extends StatefulWidget {
  static String routeName = '/more-cahrt-page';
  const MoreChartsMain({super.key, required this.title});

  final String title;

  @override
  State<MoreChartsMain> createState() => MoreCharts();
}

class MoreCharts extends State<MoreChartsMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 38, 38, 38),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25),
              Row(children: [
                const SizedBox(width: 15),
                InkWell(
                  borderRadius: BorderRadius.circular(20.0),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 255, 243, 23)),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 38, 38, 38),
                      size: 20.0,
                    ),
                  ),
                ),
              ]),
              const Text(
                'Multiple Regression',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 100),
              Image.asset('assets/seats.png'),
              const SizedBox(height: 100),
              Image.asset('assets/Priceand Power.png'),
              const SizedBox(height: 100),
              Image.asset('assets/engine.png'),
              const SizedBox(height: 100),
              Image.asset('assets/Priceand Mileage.png'),
              const SizedBox(height: 200),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
