import 'package:car_price_prediction/components/text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Data/data.dart';
import '../components/dropdown.dart';
import '../components/button.dart';
import './about_developer.dart';
import 'more_charts.dart';

class Charts extends StatefulWidget {
  static String routeName = '/chart-page';
  const Charts({super.key, required this.title});

  final String title;

  @override
  State<Charts> createState() => ChartsClass();
}

class ChartsClass extends State<Charts> {
  final List<ChartDataPie> chartDataDoughnut = [];
  final List<ChartDataBar> chartDataBar = [];
  List<dynamic> y = [];
  final List<ChartDataScatterLine> chartDataScatterLine = [];
  final List<ChartDataScatterLine> chartScatterPower = [];
  final List<ChartDataScatterLine> chartScatterEngine = [];
  final List<ChartDataScatterLine> chartScatterMileage = [];
  final List<ChartDataScatterLine> chartScatterSeats = [];
  final List<ChartHistogram> chartHistogramKilometer = [];
  final List<ChartHistogram> chartHistogramEngine = [];
  final List<ChartHistogram> chartHistogramPower = [];
  final List<ChartHistogram> chartHistogramMilage = [];
  final List<ChartHistogram> chartHistogramSeats = [];
  List<dynamic> parameters = [];
  List<dynamic> variables = [];
  bool loadingMainChartPage = true;
  bool loadingScatter = false;
  final kilometerDriven = TextEditingController();
  final mileage = TextEditingController();
  final engine = TextEditingController();
  final power = TextEditingController();
  final seats = TextEditingController();
  static String year = '';
  static String carBrand = '';
  static String fuelType = '';
  static String transmission = '';
  static String ownerType = '';
  static String location = '';
  static String kilometer = '';
  static String mileageStr = '';
  static String powerStr = '';
  static String engineStr = '';
  static String seatStr = '';

  String scatter = 'Power';

  String histogram = 'Price';

  String whisker = 'Price';

  String result = '0';

  final List<String> carNames = [
    'Year',
    'KMS',
    'Mileage',
    'Engine',
    'Power',
    'Seats',
  ];

  final List<String> bounds = [
    'Lower Bound',
    'Upper Bound',
  ];

  final List<String> boundsValue = [
    '1.6640201317877241',
    '1.9861701221895092',
  ];

  final List<Icon> carIcons = [
    const Icon(
      Icons.arrow_drop_up,
      color: Colors.green,
      size: 35,
    ),
    const Icon(
      Icons.arrow_drop_down,
      color: Colors.red,
      size: 35,
    ),
    const Icon(
      Icons.arrow_drop_down,
      color: Colors.red,
      size: 35,
    ),
    const Icon(
      Icons.arrow_drop_up,
      color: Colors.green,
      size: 35,
    ),
    const Icon(
      Icons.arrow_drop_up,
      color: Colors.green,
      size: 35,
    ),
    const Icon(
      Icons.arrow_drop_up,
      color: Colors.green,
      size: 35,
    ),
  ];

  List<BoxAndWhiskerSeries<ChartWhisker, dynamic>> _getPriceBoxWhiskerSeries() {
    return <BoxAndWhiskerSeries<ChartWhisker, dynamic>>[
      BoxAndWhiskerSeries<ChartWhisker, dynamic>(
        dataSource: <ChartWhisker>[
          ChartWhisker('Price', Data().y, null, Colors.blue),
        ],
        showMean: true,
        boxPlotMode: BoxPlotMode.exclusive,
        borderColor: Colors.white,
        borderWidth: 2,
        xValueMapper: (ChartWhisker sales, _) => sales.x,
        yValueMapper: (ChartWhisker sales, _) => sales.y,
        pointColorMapper: (ChartWhisker sales, _) => sales.color,
      )
    ];
  }

  List<BoxAndWhiskerSeries<ChartWhisker, dynamic>> _getSeatsBoxWhiskerSeries() {
    return <BoxAndWhiskerSeries<ChartWhisker, dynamic>>[
      BoxAndWhiskerSeries<ChartWhisker, dynamic>(
        dataSource: <ChartWhisker>[
          ChartWhisker('Seats', Data().seats, null, Colors.blue),
        ],
        showMean: true,
        boxPlotMode: BoxPlotMode.exclusive,
        borderColor: Colors.white,
        borderWidth: 2,
        xValueMapper: (ChartWhisker sales, _) => sales.x,
        yValueMapper: (ChartWhisker sales, _) => sales.y,
        pointColorMapper: (ChartWhisker sales, _) => sales.color,
      )
    ];
  }

  List<BoxAndWhiskerSeries<ChartWhisker, dynamic>> _getPowerBoxWhiskerSeries() {
    return <BoxAndWhiskerSeries<ChartWhisker, dynamic>>[
      BoxAndWhiskerSeries<ChartWhisker, dynamic>(
        dataSource: <ChartWhisker>[
          ChartWhisker('Power', Data().power, null, Colors.blue),
        ],
        showMean: true,
        boxPlotMode: BoxPlotMode.exclusive,
        borderColor: Colors.white,
        borderWidth: 2,
        xValueMapper: (ChartWhisker sales, _) => sales.x,
        yValueMapper: (ChartWhisker sales, _) => sales.y,
        pointColorMapper: (ChartWhisker sales, _) => sales.color,
      )
    ];
  }

  List<BoxAndWhiskerSeries<ChartWhisker, dynamic>>
      _getEngineBoxWhiskerSeries() {
    return <BoxAndWhiskerSeries<ChartWhisker, dynamic>>[
      BoxAndWhiskerSeries<ChartWhisker, dynamic>(
        dataSource: <ChartWhisker>[
          ChartWhisker('Engine', Data().engine, null, Colors.blue),
        ],
        showMean: true,
        boxPlotMode: BoxPlotMode.exclusive,
        borderColor: Colors.white,
        borderWidth: 2,
        xValueMapper: (ChartWhisker sales, _) => sales.x,
        yValueMapper: (ChartWhisker sales, _) => sales.y,
        pointColorMapper: (ChartWhisker sales, _) => sales.color,
      )
    ];
  }

  List<BoxAndWhiskerSeries<ChartWhisker, dynamic>>
      _getMileageBoxWhiskerSeries() {
    return <BoxAndWhiskerSeries<ChartWhisker, dynamic>>[
      BoxAndWhiskerSeries<ChartWhisker, dynamic>(
        dataSource: <ChartWhisker>[
          ChartWhisker('Mileage', Data().mileage, null, Colors.blue),
        ],
        showMean: true,
        boxPlotMode: BoxPlotMode.exclusive,
        borderColor: Colors.white,
        borderWidth: 2,
        xValueMapper: (ChartWhisker sales, _) => sales.x,
        yValueMapper: (ChartWhisker sales, _) => sales.y,
        pointColorMapper: (ChartWhisker sales, _) => sales.color,
      )
    ];
  }

  Future<void> _simulateLoading(int i) async {
    setState(() {
      (i == 2) ? loadingMainChartPage = true : loadingScatter = true;
    });
    await Future.delayed(Duration(seconds: i));
    setState(() {
      (i == 2) ? loadingMainChartPage = false : loadingScatter = false;
    });
  }

  Future<void> loadData() async {
    var uri = 'https://bilaltariq360.github/Car_Price_Prediction/';

    final res = await http.get(Uri.parse(uri));
    final result = json.decode(res.body) as Map<String, dynamic>;
    setState(
      () {
        List<dynamic> fuelType = result['result']['pie_chart_data']['labels'];
        List<dynamic> fuelCount = result['result']['pie_chart_data']['values'];
        chartDataDoughnut.clear();
        for (int i = 0; i < fuelType.length; i++) {
          chartDataDoughnut.add(
            ChartDataPie(
              fuelType: fuelType[i],
              counts: fuelCount[i],
              color:
                  Color.fromARGB(255, ((i * 255) - 255), 126, ((i * 75) - 75)),
            ),
          );
        }

        List<dynamic> carCompany = result['result']['bar_chart_data']['labels'];
        List<dynamic> carCompanyCounts =
            result['result']['bar_chart_data']['values'];
        chartDataBar.clear();
        for (int i = 0; i < carCompany.length; i++) {
          chartDataBar.add(
            ChartDataBar(
              carCompany: carCompany[i],
              counts: carCompanyCounts[i],
            ),
          );
        }

        List<dynamic> kilometer =
            result['result']['scatter_data']['Kilometers_Driven'];
        y = result['result']['LRM']['y'];
        List<dynamic> yhat = result['result']['LRM']['yhat'];
        chartDataScatterLine.clear();
        for (int i = 0; i < kilometer.length; i++) {
          chartDataScatterLine.add(
            ChartDataScatterLine(
                xAxis: double.parse(kilometer[i].toString()),
                y: (y[i] <= 0) ? 0.10761931532135419 : y[i],
                yhat: (yhat[i] <= 0) ? 0.10761931532135419 : yhat[i]),
          );
        }

        parameters = result['result']['LRM']['Parameters'];
        variables = result['result']['LRM']['Variables'];

        List<dynamic> histKilometerBinEdges = result['result']
            ['histogram_of_price_Log']['hist']['bin_edges_Price_Log'];

        List<dynamic> histPowerValues = result['result']
            ['histogram_of_price_Log']['hist']['values_Price_Log'];
        chartHistogramKilometer.clear();
        for (int i = 0; i < histKilometerBinEdges.length - 1; i++) {
          chartHistogramKilometer.add(
            ChartHistogram(
              binEdgesY: histKilometerBinEdges[i],
              values: histPowerValues[i],
            ),
          );
        }

        List<dynamic> engine = result['result']['scatter_data']['Engine'];
        chartScatterEngine.clear();
        for (int i = 0; i < engine.length; i++) {
          chartScatterEngine.add(
            ChartDataScatterLine(
                xAxis: double.parse(engine[i].toString()),
                y: y[i],
                yhat: yhat[i]),
          );
        }

        List<dynamic> seats = result['result']['scatter_data']['Seats'];
        chartScatterSeats.clear();
        for (int i = 0; i < seats.length; i++) {
          chartScatterSeats.add(
            ChartDataScatterLine(
                xAxis: double.parse(seats[i].toString()),
                y: y[i],
                yhat: yhat[i]),
          );
        }

        List<dynamic> mileage = result['result']['scatter_data']['Mileage'];
        chartScatterMileage.clear();
        for (int i = 0; i < mileage.length; i++) {
          chartScatterMileage.add(
            ChartDataScatterLine(
                xAxis: double.parse(mileage[i].toString()),
                y: y[i],
                yhat: yhat[i]),
          );
        }

        List<dynamic> power = result['result']['scatter_data']['Power'];
        chartScatterPower.clear();
        for (int i = 0; i < power.length; i++) {
          chartScatterPower.add(
            ChartDataScatterLine(
                xAxis: double.parse(power[i].toString()),
                y: y[i],
                yhat: yhat[i]),
          );
        }

        List<dynamic> histMileageBinEdges = result['result']
            ['histogram_of_price_Log']['hist']['bin_edges_Mileage'];
        List<dynamic> histMileage = result['result']['histogram_of_price_Log']
            ['hist']['hist_values_Mileage'];
        chartHistogramMilage.clear();
        for (int i = 0; i < histMileageBinEdges.length - 1; i++) {
          chartHistogramMilage.add(ChartHistogram(
            binEdgesY: histMileageBinEdges[i],
            values: histMileage[i],
          ));
        }

        List<dynamic> histEngineBinEdges = result['result']
            ['histogram_of_price_Log']['hist']['bin_edges_Engine'];
        List<dynamic> histEngine = result['result']['histogram_of_price_Log']
            ['hist']['hist_values_Engine'];
        chartHistogramEngine.clear();
        for (int i = 0; i < histEngineBinEdges.length - 1; i++) {
          chartHistogramEngine.add(ChartHistogram(
            binEdgesY: histEngineBinEdges[i],
            values: histEngine[i],
          ));
        }

        List<dynamic> histPowerBinEdges = result['result']
            ['histogram_of_price_Log']['hist']['bin_edges_Power'];
        List<dynamic> histPower = result['result']['histogram_of_price_Log']
            ['hist']['hist_values_Power'];
        chartHistogramPower.clear();
        for (int i = 0; i < histPowerBinEdges.length - 1; i++) {
          chartHistogramPower.add(ChartHistogram(
            binEdgesY: histPowerBinEdges[i],
            values: histPower[i],
          ));
        }

        List<dynamic> histSeatBinEdges = result['result']
            ['histogram_of_price_Log']['hist']['bin_edges_Seats'];
        List<dynamic> histSeat = result['result']['histogram_of_price_Log']
            ['hist']['hist_values_Seats'];
        chartHistogramSeats.clear();
        for (int i = 0; i < histSeatBinEdges.length - 1; i++) {
          chartHistogramSeats.add(ChartHistogram(
            binEdgesY: histSeatBinEdges[i],
            values: histSeat[i],
          ));
        }
      },
    );
    _simulateLoading(2);
  }

  void goHome() {
    Navigator.pop(context);
  }

  void predict() {
    double yearP = double.parse(ChartsClass.year);
    double kilometerP = double.parse(ChartsClass.kilometer);
    double mileageP = double.parse(ChartsClass.mileageStr);
    double engineP = double.parse(ChartsClass.engineStr);
    double powerP = double.parse(ChartsClass.powerStr);
    double seatsP = double.parse(ChartsClass.seatStr);
    int i = 0;
    for (i = 0; i < variables.length; i++) {
      if (variables[i] == 'Encoded_${ChartsClass.location}') {
        break;
      }
    }
    double locP = 1.0 * parameters[i];
    for (i = 0; i < variables.length; i++) {
      if (variables[i] == 'Encoded_${ChartsClass.fuelType}') {
        break;
      }
    }
    double fuelTypeP = 1.0 * parameters[i];
    for (i = 0; i < variables.length; i++) {
      if (variables[i] == 'Encoded_${ChartsClass.carBrand}') {
        break;
      }
    }
    double carBrandP = 1.0 * parameters[i];
    double transmissionP = 0;
    if (ChartsClass.transmission == 'Automatic') {
      transmissionP = 1.0 * -61.5550268119036;
    } else if (ChartsClass.transmission == 'Manual') {
      transmissionP = 1.0 * -61.6761805249703;
    }
    for (i = 0; i < variables.length; i++) {
      if (variables[i] == 'Encoded_${ChartsClass.ownerType}') {
        break;
      }
    }
    double ownerTypeP = 1.0 * parameters[i];
    print(
        '${(yearP * 0.127639864645658)} $kilometerP $mileageP $engineP $powerP $seatsP $locP $fuelTypeP $carBrandP $transmissionP $ownerTypeP');
    setState(() {
      result = (-123.23120733685012 +
              (yearP * 0.127639864645658) +
              (kilometerP * -0.0000000824732968361632) +
              (mileageP * -0.018827618971459) +
              (engineP * 0.00013600468702621) +
              (powerP * 0.00522515351046763) +
              (seatsP * 0.0428589192934134) +
              locP +
              fuelTypeP +
              carBrandP +
              transmissionP +
              ownerTypeP)
          .toStringAsFixed(2);
    });
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 38, 38, 38),
        body: (loadingMainChartPage)
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                        color: Color.fromARGB(255, 255, 243, 23)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Fetching Data...',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          const SizedBox(width: 15),
                          InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: goHome,
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
                        Row(children: [
                          const SizedBox(width: 15),
                          InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AboutDeveloperScreen.routeName);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 255, 243, 23)),
                              child: const Icon(
                                Icons.code_off,
                                color: Color.fromARGB(255, 38, 38, 38),
                                size: 20.0,
                              ),
                            ),
                          ),
                        ]),
                        Row(children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(20.0),
                            onTap: loadData,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 255, 243, 23)),
                              child: const Icon(
                                CupertinoIcons.refresh_thick,
                                color: Color.fromARGB(255, 38, 38, 38),
                                size: 20.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                        ]),
                      ],
                    ),
                    const SizedBox(height: 40),
                    const Text('Price Prediction Parameters',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 70),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 180,
                            child: MyDropdown(
                                hintText: 'Year',
                                list: [
                                  '1998',
                                  '1999',
                                  '2000',
                                  '2001',
                                  '2002',
                                  '2003',
                                  '2004',
                                  '2005',
                                  '2006',
                                  '2007',
                                  '2008',
                                  '2009',
                                  '2010',
                                  '2011',
                                  '2012',
                                  '2013',
                                  '2014',
                                  '2015',
                                  '2016',
                                  '2017',
                                  '2018',
                                  '2019'
                                ],
                                prefixIcon: Icons.calendar_month_outlined),
                          ),
                          SizedBox(
                            width: 250,
                            child: MyDropdown(
                                hintText: 'Car Brand',
                                list: [
                                  'Audi',
                                  'Ambassador',
                                  'Bentley',
                                  'BMW',
                                  'Chevrolet',
                                  'Datsun',
                                  'Fiat',
                                  'Ford',
                                  'Force',
                                  'Honda',
                                  'Hyundai',
                                  'Isuzu',
                                  'Jaguar',
                                  'Jeep',
                                  'Lamborghini',
                                  'Land Rover',
                                  'Mahindra',
                                  'Maruti',
                                  'Mercedes-Benz',
                                  'Mini',
                                  'Mitsubishi',
                                  'Nissan',
                                  'Porsche',
                                  'Renault',
                                  'Skoda',
                                  'Smart',
                                  'Tata',
                                  'Toyota',
                                  'Volkswagen',
                                  'Volvo'
                                ],
                                prefixIcon: CupertinoIcons.car_detailed),
                          ),
                          SizedBox(
                            width: 210,
                            child: MyDropdown(
                                hintText: 'Fuel Type',
                                list: [
                                  'CNG',
                                  'Diesel',
                                  'Electric',
                                  'LPG',
                                  'Petrol'
                                ],
                                prefixIcon: Icons.filter_alt_rounded),
                          ),
                          SizedBox(
                            width: 230,
                            child: MyDropdown(
                                hintText: 'Transmission Type',
                                list: ['Automatic', 'Manual'],
                                prefixIcon: Icons.transform),
                          ),
                          SizedBox(
                            width: 220,
                            child: MyDropdown(
                                hintText: 'Owner Type',
                                list: [
                                  'First',
                                  'Second',
                                  'Third',
                                  'Fourth & Above'
                                ],
                                prefixIcon: Icons.people_sharp),
                          ),
                          SizedBox(
                            width: 210,
                            child: MyDropdown(
                                hintText: 'Location',
                                list: [
                                  'Bangalore',
                                  'Chennai',
                                  'Coimbatore',
                                  'Delhi',
                                  'Hyderabad',
                                  'Jaipur',
                                  'Kochi',
                                  'Kolkata',
                                  'Mumbai',
                                  'Pune'
                                ],
                                prefixIcon: CupertinoIcons.location_fill),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 280,
                            child: MyTextField(
                                controller: kilometerDriven,
                                hintText: 'Kilometer Driven',
                                obscureText: false,
                                maxLength: 8,
                                exactLength: 8,
                                minLength: 1,
                                textInputType: TextInputType.number,
                                filteringTextInputFormatter:
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                check: false,
                                prefixIcon: Icons.add_road_rounded,
                                hideCheckMark: true),
                          ),
                          SizedBox(
                            width: 200,
                            child: MyTextField(
                                controller: mileage,
                                hintText: 'Mileage',
                                obscureText: false,
                                maxLength: 8,
                                exactLength: 8,
                                minLength: 1,
                                textInputType: TextInputType.number,
                                filteringTextInputFormatter:
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                check: false,
                                prefixIcon: Icons.car_crash_rounded,
                                hideCheckMark: true),
                          ),
                          SizedBox(
                            width: 200,
                            child: MyTextField(
                                controller: power,
                                hintText: 'Power',
                                obscureText: false,
                                maxLength: 8,
                                exactLength: 8,
                                minLength: 1,
                                textInputType: TextInputType.number,
                                filteringTextInputFormatter:
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.]')),
                                check: false,
                                prefixIcon: Icons.power_outlined,
                                hideCheckMark: true),
                          ),
                          SizedBox(
                            width: 200,
                            child: MyTextField(
                                controller: engine,
                                hintText: 'Engine',
                                obscureText: false,
                                maxLength: 8,
                                exactLength: 8,
                                minLength: 1,
                                textInputType: TextInputType.number,
                                filteringTextInputFormatter:
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                check: false,
                                prefixIcon: Icons.energy_savings_leaf_outlined,
                                hideCheckMark: true),
                          ),
                          SizedBox(
                            width: 200,
                            child: MyTextField(
                                controller: seats,
                                hintText: 'Seats',
                                obscureText: false,
                                maxLength: 8,
                                exactLength: 8,
                                minLength: 1,
                                textInputType: TextInputType.number,
                                filteringTextInputFormatter:
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                check: false,
                                prefixIcon: Icons.chair_alt_outlined,
                                hideCheckMark: true),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 300,
                      child: MyButton(
                        btnText: 'Predict',
                        onTap: predict,
                        backgroudColor: const Color.fromARGB(255, 255, 243, 23),
                        foregroudColor: const Color.fromARGB(255, 38, 38, 38),
                        icon: Icons.gamepad_outlined,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Row(children: [
                      const SizedBox(width: 50),
                      const SizedBox(
                        child: Text(
                          'Predicted Price:',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        child: Text(
                          result,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 255, 243, 23),
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
                    const SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(width: 50),
                          SizedBox(
                            child: Text(
                              'Note: This predicted price is 95% accurate if it lies between Confidence Interval.',
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Text('Confidence Intervals',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 50),
                    SizedBox(
                      child: DataTable(
                        dataRowMinHeight: 28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Set the border color
                            width: 2.0, // Set the border thickness
                          ),
                        ),
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Confidence Type',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Confidence Value',
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                        rows: List<DataRow>.generate(
                          bounds.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text(
                                bounds[index],
                                style: const TextStyle(color: Colors.white),
                              )),
                              DataCell(Text(
                                boundsValue[index],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 243, 23)),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    const Text('Parameters relation with price',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 50),
                    SizedBox(
                      child: DataTable(
                        dataRowMinHeight: 28,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white, // Set the border color
                            width: 2.0, // Set the border thickness
                          ),
                        ),
                        columns: const [
                          DataColumn(
                              label: Text(
                            'Name',
                            style: TextStyle(color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Relation',
                            style: TextStyle(color: Colors.white),
                          )),
                        ],
                        rows: List<DataRow>.generate(
                          carNames.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(Text(
                                carNames[index],
                                style: const TextStyle(color: Colors.white),
                              )),
                              DataCell(carIcons[index]),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    SizedBox(
                      width: 750,
                      child: SfCircularChart(
                        title: ChartTitle(
                          text: 'Pie Chart',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        legend: const Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                          alignment: ChartAlignment.center,
                          backgroundColor: Color.fromARGB(255, 57, 57, 57),
                          orientation: LegendItemOrientation.horizontal,
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          title: LegendTitle(
                            text: 'Fuel Types',
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        series: <PieSeries<ChartDataPie, String>>[
                          PieSeries<ChartDataPie, String>(
                            dataSource: chartDataDoughnut,
                            xValueMapper: (ChartDataPie data, _) =>
                                data.fuelType,
                            yValueMapper: (ChartDataPie data, _) => data.counts,
                            dataLabelMapper: (ChartDataPie data, _) =>
                                '${((data.counts / 6019) * 100).toStringAsFixed(2)}%',
                            radius: '60%',
                            dataLabelSettings: const DataLabelSettings(
                              margin: EdgeInsets.zero,
                              isVisible: true,
                              textStyle:
                                  TextStyle(color: Colors.white, fontSize: 14),
                              labelPosition: ChartDataLabelPosition.outside,
                              connectorLineSettings: ConnectorLineSettings(
                                  type: ConnectorType.curve, length: '50%'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 700,
                      width: 1200,
                      child: SfCartesianChart(
                        legend: const Legend(
                            isVisible: true,
                            overflowMode: LegendItemOverflowMode.wrap,
                            alignment: ChartAlignment.center,
                            backgroundColor: Color.fromARGB(255, 57, 57, 57),
                            orientation: LegendItemOrientation.horizontal,
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255)),
                            title: LegendTitle(
                                text: 'Cars and Fuel Types',
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                        title: ChartTitle(
                          text: 'Bar Chart',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        series: <ChartSeries>[
                          BarSeries<ChartDataBar, String>(
                              isVisible: true,
                              color: const Color.fromARGB(255, 255, 243, 23),
                              dataSource: chartDataBar,
                              xValueMapper: (ChartDataBar data, _) =>
                                  data.carCompany,
                              yValueMapper: (ChartDataBar data, _) =>
                                  data.counts,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              width: 0.4,
                              spacing: 0.5,
                              name: 'Car Brands'),
                          BarSeries<ChartDataPie, String>(
                              isVisible: false,
                              color: const Color.fromARGB(255, 255, 243, 23),
                              dataSource: chartDataDoughnut,
                              xValueMapper: (ChartDataPie data, _) =>
                                  data.fuelType,
                              yValueMapper: (ChartDataPie data, _) =>
                                  data.counts,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              width: 0.4,
                              spacing: 0.5,
                              name: 'Fuels'),
                        ],
                        primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255,
                                255), // Change the label color here
                          ),
                          majorGridLines: const MajorGridLines(
                            color: Color.fromARGB(100, 255, 23, 124),
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255,
                                255), // Change the label color here
                          ),
                          majorGridLines: const MajorGridLines(
                            color: Color.fromARGB(100, 255, 23, 124),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    (loadingScatter)
                        ? SizedBox(
                            height: 500,
                            width: 1200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(
                                      color: Color.fromARGB(255, 255, 243, 23)),
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Generating Scatter Chart for $scatter...',
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 500,
                            width: 1200,
                            child: SfCartesianChart(
                              legend: const Legend(
                                width: '250',
                                isVisible: true,
                                overflowMode: LegendItemOverflowMode.wrap,
                                alignment: ChartAlignment.center,
                                backgroundColor:
                                    Color.fromARGB(255, 57, 57, 57),
                                orientation: LegendItemOrientation.horizontal,
                                textStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                                title: LegendTitle(
                                  text: 'Cars and Fuel Types',
                                  textStyle: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: ChartTitle(
                                text: 'Scatter Graph',
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                              series: (scatter == 'Mileage')
                                  ? <ChartSeries>[
                                      ScatterSeries<ChartDataScatterLine,
                                              double>(
                                          color: const Color.fromARGB(
                                              255, 255, 23, 124),
                                          dataSource: chartScatterMileage,
                                          xValueMapper:
                                              (ChartDataScatterLine data, _) =>
                                                  data.xAxis,
                                          yValueMapper:
                                              (ChartDataScatterLine data, _) =>
                                                  data.y,
                                          markerSettings: const MarkerSettings(
                                              width: 7,
                                              height: 7,
                                              shape: DataMarkerType.circle),
                                          name: 'Orig. price'),
                                      ScatterSeries<ChartDataScatterLine,
                                              double>(
                                          color: const Color.fromARGB(
                                              255, 255, 243, 23),
                                          dataSource: chartScatterMileage,
                                          xValueMapper:
                                              (ChartDataScatterLine data, _) =>
                                                  data.xAxis,
                                          yValueMapper:
                                              (ChartDataScatterLine data, _) =>
                                                  data.yhat,
                                          markerSettings: const MarkerSettings(
                                              width: 7,
                                              height: 7,
                                              shape: DataMarkerType.circle),
                                          name: 'Pred. Price'),
                                    ]
                                  : (scatter == 'Engine')
                                      ? <ChartSeries>[
                                          ScatterSeries<ChartDataScatterLine,
                                                  double>(
                                              color: const Color.fromARGB(
                                                  255, 255, 23, 124),
                                              dataSource: chartScatterEngine,
                                              xValueMapper:
                                                  (ChartDataScatterLine data,
                                                          _) =>
                                                      data.xAxis,
                                              yValueMapper:
                                                  (ChartDataScatterLine data,
                                                          _) =>
                                                      data.y,
                                              markerSettings:
                                                  const MarkerSettings(
                                                      width: 7,
                                                      height: 7,
                                                      shape: DataMarkerType
                                                          .circle),
                                              name: 'Orig. price'),
                                          ScatterSeries<ChartDataScatterLine,
                                                  double>(
                                              color: const Color.fromARGB(
                                                  255, 255, 243, 23),
                                              dataSource: chartScatterEngine,
                                              xValueMapper:
                                                  (ChartDataScatterLine data,
                                                          _) =>
                                                      data.xAxis,
                                              yValueMapper:
                                                  (ChartDataScatterLine data,
                                                          _) =>
                                                      data.yhat,
                                              markerSettings:
                                                  const MarkerSettings(
                                                      width: 7,
                                                      height: 7,
                                                      shape: DataMarkerType
                                                          .circle),
                                              name: 'Pred. Price'),
                                        ]
                                      : (scatter == 'Seats')
                                          ? <ChartSeries>[
                                              ScatterSeries<
                                                      ChartDataScatterLine,
                                                      double>(
                                                  color: const Color.fromARGB(
                                                      255, 255, 23, 124),
                                                  dataSource: chartScatterSeats,
                                                  xValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.xAxis,
                                                  yValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.y,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                          width: 7,
                                                          height: 7,
                                                          shape: DataMarkerType
                                                              .circle),
                                                  name: 'Orig. price'),
                                              ScatterSeries<
                                                      ChartDataScatterLine,
                                                      double>(
                                                  color: const Color.fromARGB(
                                                      255, 255, 243, 23),
                                                  dataSource: chartScatterSeats,
                                                  xValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.xAxis,
                                                  yValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.yhat,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                          width: 7,
                                                          height: 7,
                                                          shape: DataMarkerType
                                                              .circle),
                                                  name: 'Pred. Price'),
                                            ]
                                          : <ChartSeries>[
                                              ScatterSeries<
                                                      ChartDataScatterLine,
                                                      double>(
                                                  color: const Color.fromARGB(
                                                      255, 255, 23, 124),
                                                  dataSource: chartScatterPower,
                                                  xValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.xAxis,
                                                  yValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.y,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                          width: 7,
                                                          height: 7,
                                                          shape: DataMarkerType
                                                              .circle),
                                                  name: 'Orig. price'),
                                              ScatterSeries<
                                                      ChartDataScatterLine,
                                                      double>(
                                                  color: const Color.fromARGB(
                                                      255, 255, 243, 23),
                                                  dataSource: chartScatterPower,
                                                  xValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.xAxis,
                                                  yValueMapper:
                                                      (ChartDataScatterLine data,
                                                              _) =>
                                                          data.yhat,
                                                  markerSettings:
                                                      const MarkerSettings(
                                                          width: 7,
                                                          height: 7,
                                                          shape: DataMarkerType
                                                              .circle),
                                                  name: 'Pred. Price'),
                                            ],
                              primaryXAxis: CategoryAxis(
                                title: AxisTitle(
                                    text: scatter,
                                    textStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 243, 23),
                                        fontWeight: FontWeight.bold)),
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255,
                                      255), // Change the label color here
                                ),
                                majorGridLines: const MajorGridLines(
                                    color: Color.fromARGB(100, 255, 23, 124)),
                              ),
                              primaryYAxis: NumericAxis(
                                title: AxisTitle(
                                    text: 'Y',
                                    textStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 243, 23),
                                        fontWeight: FontWeight.bold)),
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255,
                                      255), // Change the label color here
                                ),
                                majorGridLines: const MajorGridLines(
                                    color: Color.fromARGB(100, 255, 23, 124)),
                              ),
                            ),
                          ),
                    const SizedBox(height: 25),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                scatter = 'Mileage';
                                _simulateLoading(3);
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  size: 35,
                                  color: (scatter == 'Mileage')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Mileage Scatter',
                                  style: TextStyle(
                                      color: (scatter == 'Mileage')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          InkWell(
                            onTap: () {
                              setState(() {
                                scatter = 'Power';
                                _simulateLoading(3);
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.power_outlined,
                                  size: 35,
                                  color: (scatter == 'Power')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Power Scatter',
                                  style: TextStyle(
                                      color: (scatter == 'Power')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          InkWell(
                            onTap: () {
                              setState(() {
                                scatter = 'Engine';
                                _simulateLoading(3);
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.energy_savings_leaf_outlined,
                                  size: 35,
                                  color: (scatter == 'Engine')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Engine Scatter',
                                  style: TextStyle(
                                      color: (scatter == 'Engine')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          InkWell(
                            onTap: () {
                              setState(() {
                                scatter = 'Seats';
                                _simulateLoading(3);
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.chair_alt_outlined,
                                  size: 35,
                                  color: (scatter == 'Seats')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Seats Scatter',
                                  style: TextStyle(
                                      color: (scatter == 'Seats')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      height: 500,
                      width: 1000,
                      child: SfCartesianChart(
                        title: ChartTitle(
                          text: 'Histogram',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        primaryXAxis: NumericAxis(
                          title: AxisTitle(
                              text: histogram,
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 243, 23),
                                  fontWeight: FontWeight.bold)),
                          majorGridLines: const MajorGridLines(
                              //width: 1.5,
                              color: Color.fromARGB(100, 255, 23, 124)),
                          minimum: (histogram == 'Price')
                              ? -1.2
                              : (histogram == 'Engine')
                                  ? 10
                                  : (histogram == 'Mileage')
                                      ? 0
                                      : (histogram == 'Power')
                                          ? 10
                                          : (histogram == 'Seat')
                                              ? 0
                                              : 0,
                          maximum: (histogram == 'Price')
                              ? 6
                              : (histogram == 'Engine')
                                  ? 6500
                                  : (histogram == 'Mileage')
                                      ? 35
                                      : (histogram == 'Power')
                                          ? 600
                                          : (histogram == 'Seat')
                                              ? 10
                                              : 0,
                          interval: 1,
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        primaryYAxis: NumericAxis(
                          title: AxisTitle(
                              text: 'Density',
                              textStyle: const TextStyle(
                                  color: Color.fromARGB(255, 255, 243, 23),
                                  fontWeight: FontWeight.bold)),
                          majorGridLines: const MajorGridLines(
                              //width: 1,
                              color: Color.fromARGB(100, 255, 23, 124)),
                          labelStyle: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        series: <ChartSeries>[
                          ColumnSeries<ChartHistogram, double>(
                            name: 'Price',
                            color: Colors.blue,
                            dataSource: (histogram == 'Engine')
                                ? chartHistogramEngine
                                : (histogram == 'Mileage')
                                    ? chartHistogramMilage
                                    : (histogram == 'Power')
                                        ? chartHistogramPower
                                        : (histogram == 'Price')
                                            ? chartHistogramKilometer
                                            : chartHistogramSeats,
                            xValueMapper: (ChartHistogram data, _) =>
                                data.binEdgesY,
                            yValueMapper: (ChartHistogram data, _) =>
                                data.values,
                            width: 1,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.top,
                              textStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                histogram = 'Mileage';
                                whisker = 'Mileage';
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.car_crash,
                                  size: 35,
                                  color: (histogram == 'Mileage')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Mileage Histogram',
                                  style: TextStyle(
                                      color: (histogram == 'Mileage')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          InkWell(
                            onTap: () {
                              setState(() {
                                histogram = 'Power';
                                whisker = 'Power';
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.power_outlined,
                                  size: 35,
                                  color: (histogram == 'Power')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Power Histogram',
                                  style: TextStyle(
                                      color: (histogram == 'Power')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          InkWell(
                            onTap: () {
                              setState(() {
                                histogram = 'Engine';

                                whisker = 'Engine';
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.energy_savings_leaf_outlined,
                                  size: 35,
                                  color: (histogram == 'Engine')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Engine Histogram',
                                  style: TextStyle(
                                      color: (histogram == 'Engine')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 70),
                          /*InkWell(
                            onTap: () {
                              setState(() {
                                histogram = 'Seats';
                                whisker = 'Seats';
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.chair_alt_outlined,
                                  size: 35,
                                  color: (histogram == 'Seats')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Seats Histogram',
                                  style: TextStyle(
                                      color: (scatter == 'Seats')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),*/
                          InkWell(
                            onTap: () {
                              setState(() {
                                histogram = 'Price';
                                whisker = 'Price';
                              });
                            },
                            mouseCursor: SystemMouseCursors.progress,
                            child: Column(
                              children: [
                                Icon(
                                  Icons.price_change_outlined,
                                  size: 35,
                                  color: (histogram == 'Price')
                                      ? const Color.fromARGB(255, 255, 243, 23)
                                      : Colors.white,
                                ),
                                Text(
                                  'Price Histogram',
                                  style: TextStyle(
                                      color: (histogram == 'Price')
                                          ? const Color.fromARGB(
                                              255, 255, 243, 23)
                                          : Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: 900,
                      height: 600,
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        title: ChartTitle(
                          text: 'Whisker Chart',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        primaryXAxis: CategoryAxis(
                          labelStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 255, 243, 23),
                          ),
                          majorGridLines: const MajorGridLines(width: 0),
                          labelIntersectAction:
                              AxisLabelIntersectAction.rotate45,
                        ),
                        isTransposed: true,
                        primaryYAxis: NumericAxis(
                            title: AxisTitle(
                                text: 'Density',
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 255, 243, 23),
                                    fontWeight: FontWeight.bold)),
                            name: 'Price',
                            minimum: (whisker == 'Price')
                                ? -1.2
                                : (whisker == 'Engine')
                                    ? 10
                                    : (whisker == 'Mileage')
                                        ? 5
                                        : (whisker == 'Power')
                                            ? 30
                                            : (whisker == 'Seat')
                                                ? 0
                                                : 0,
                            maximum: (whisker == 'Price')
                                ? 6
                                : (whisker == 'Engine')
                                    ? 6500
                                    : (whisker == 'Mileage')
                                        ? 35
                                        : (whisker == 'Power')
                                            ? 600
                                            : (whisker == 'Seat')
                                                ? 10
                                                : 0,
                            majorGridLines: const MajorGridLines(
                                //width: 1,
                                color: Color.fromARGB(100, 255, 23, 124)),
                            labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                            //interval: 10,
                            axisLine: const AxisLine(width: 0),
                            majorTickLines: const MajorTickLines(size: 0)),
                        series: (whisker == 'Engine')
                            ? _getEngineBoxWhiskerSeries()
                            : (whisker == 'Mileage')
                                ? _getMileageBoxWhiskerSeries()
                                : (whisker == 'Power')
                                    ? _getPowerBoxWhiskerSeries()
                                    : (whisker == 'Price')
                                        ? _getPriceBoxWhiskerSeries()
                                        : _getSeatsBoxWhiskerSeries(),
                        //tooltipBehavior: _tooltipBehavior,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 300,
                        child: MyButton(
                          btnText: 'Show more charts',
                          onTap: () {
                            Navigator.pushNamed(
                                context, MoreChartsMain.routeName);
                          },
                          backgroudColor:
                              const Color.fromARGB(255, 255, 243, 23),
                          foregroudColor: const Color.fromARGB(255, 38, 38, 38),
                          icon: Icons.more,
                        ),
                      ),
                    ]),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final double x;
  final double y;
}

class ChartDataPie {
  final String fuelType;
  final int counts;
  final Color color;

  ChartDataPie(
      {required this.fuelType, required this.counts, required this.color});
}

class ChartDataBar {
  final String carCompany;
  final int counts;

  ChartDataBar({required this.carCompany, required this.counts});
}

class ChartDataScatterLine {
  final double xAxis;
  final double y;
  final double yhat;

  ChartDataScatterLine(
      {required this.xAxis, required this.y, required this.yhat});
}

class ChartHistogram {
  final double binEdgesY;
  final double values;

  ChartHistogram({required this.binEdgesY, required this.values});
}

class ChartWhisker {
  ChartWhisker(this.x, this.y, [this.date, this.color]);
  final dynamic x;
  final dynamic y;
  final Color? color;
  final DateTime? date;
}
