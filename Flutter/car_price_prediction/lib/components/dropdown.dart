import 'package:flutter/material.dart';
import '../screens/chart_screen.dart';

class MyDropdown extends StatefulWidget {
  final String hintText;
  final List<dynamic> list;
  final IconData prefixIcon;

  const MyDropdown(
      {super.key,
      required this.hintText,
      required this.list,
      required this.prefixIcon});
  @override
  State<StatefulWidget> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  @override
  Widget build(BuildContext context) {
    String dropDownValue = widget.hintText;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: DropdownButtonFormField(
        decoration: InputDecoration(
          prefixIcon: Icon(widget.prefixIcon,
              color: const Color.fromARGB(255, 255, 243, 23), size: 22),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 243, 23)),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 243, 23)),
            borderRadius: BorderRadius.circular(5),
          ),
          enabled: false,
          disabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromARGB(255, 255, 243, 23)),
            borderRadius: BorderRadius.circular(5),
          ),
          filled: true,
          fillColor: Colors.transparent,
        ),
        dropdownColor: const Color.fromARGB(255, 38, 38, 38),
        // ignore: unnecessary_null_comparison
        hint: dropDownValue == null
            ? const Text('Dropdown')
            : Text(
                dropDownValue,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 243, 23), fontSize: 16),
              ),
        isExpanded: true,
        iconSize: 25.0,
        iconDisabledColor: const Color.fromARGB(255, 255, 243, 23),
        iconEnabledColor: const Color.fromARGB(255, 255, 243, 23),
        items: widget.list.map(
          (val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(
                val,
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 243, 23)),
              ),
            );
          },
        ).toList(),
        onChanged: (val) {
          /********************Year*********************/
          setState(() {
            if (val == '1998') {
              ChartsClass.year = val.toString();
            } else if (val == '1999') {
              ChartsClass.year = val.toString();
            } else if (val == '2000') {
              ChartsClass.year = val.toString();
            } else if (val == '2001') {
              ChartsClass.year = val.toString();
            } else if (val == '2002') {
              ChartsClass.year = val.toString();
            } else if (val == '2003') {
              ChartsClass.year = val.toString();
            } else if (val == '2004') {
              ChartsClass.year = val.toString();
            } else if (val == '2005') {
              ChartsClass.year = val.toString();
            } else if (val == '2006') {
              ChartsClass.year = val.toString();
            } else if (val == '2007') {
              ChartsClass.year = val.toString();
            } else if (val == '2008') {
              ChartsClass.year = val.toString();
            } else if (val == '2009') {
              ChartsClass.year = val.toString();
            } else if (val == '2010') {
              ChartsClass.year = val.toString();
            } else if (val == '2011') {
              ChartsClass.year = val.toString();
            } else if (val == '2012') {
              ChartsClass.year = val.toString();
            } else if (val == '2013') {
              ChartsClass.year = val.toString();
            } else if (val == '2014') {
              ChartsClass.year = val.toString();
            } else if (val == '2015') {
              ChartsClass.year = val.toString();
            } else if (val == '2016') {
              ChartsClass.year = val.toString();
            } else if (val == '2017') {
              ChartsClass.year = val.toString();
            } else if (val == '2018') {
              ChartsClass.year = val.toString();
            } else if (val == '2019') {
              ChartsClass.year = val.toString();
            }
            /********************Car Brand*********************/
            if (val == 'Audi') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Ambassador') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Bentley') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'BMW') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Chevrolet') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Datsun') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Fiat') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Ford') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Force') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Honda') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Isuzu') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Jaguar') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Jeep') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Lamborghini') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Land Rover') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Mahindra') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Maruti') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Mercedes-Benz') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Mini') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Mitsubishi') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Nissan') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Porsche') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Renault') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Skoda') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Smart') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Tata') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Toyota') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Volkswagen') {
              ChartsClass.carBrand = val.toString();
            } else if (val == 'Volvo') {
              ChartsClass.carBrand = val.toString();
            }
            /********************Fuel Type*********************/
            if (val == 'CNG') {
              ChartsClass.fuelType = val.toString();
            } else if (val == 'LPG') {
              ChartsClass.fuelType = val.toString();
            } else if (val == 'Electric') {
              ChartsClass.fuelType = val.toString();
            } else if (val == 'Petrol') {
              ChartsClass.fuelType = val.toString();
            } else if (val == 'Diesel') {
              ChartsClass.fuelType = val.toString();
            }
            /********************Transmission*********************/
            if (val == 'Automatic') {
              ChartsClass.transmission = val.toString();
            } else if (val == 'Manual') {
              ChartsClass.transmission = val.toString();
            }
            /********************Owner Type*********************/
            if (val == 'First') {
              ChartsClass.ownerType = val.toString();
            } else if (val == 'Second') {
              ChartsClass.ownerType = val.toString();
            } else if (val == 'Third') {
              ChartsClass.ownerType = val.toString();
            } else if (val == 'Fourth & Above') {
              ChartsClass.ownerType = val.toString();
            }
            /********************Location*********************/
            if (val == 'Bangalore') {
              ChartsClass.location = val.toString();
            } else if (val == 'Chennai') {
              ChartsClass.location = val.toString();
            } else if (val == 'Coimbatore') {
              ChartsClass.location = val.toString();
            } else if (val == 'Delhi') {
              ChartsClass.location = val.toString();
            } else if (val == 'Hyderabad') {
              ChartsClass.location = val.toString();
            } else if (val == 'Jaipur') {
              ChartsClass.location = val.toString();
            } else if (val == 'Kochi') {
              ChartsClass.location = val.toString();
            } else if (val == 'Kolkata') {
              ChartsClass.location = val.toString();
            } else if (val == 'Mumbai') {
              ChartsClass.location = val.toString();
            } else if (val == 'Pune') {
              ChartsClass.location = val.toString();
            }
          });
        },
      ),
    );
  }
}
