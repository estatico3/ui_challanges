import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_temperature_picker/coffee_temperature.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_temperature_picker/separator_path_clipper.dart';

class CoffeeTemperaturePicker extends StatefulWidget {
  @override
  _CoffeeTemperaturePickerState createState() =>
      _CoffeeTemperaturePickerState();
}

class _CoffeeTemperaturePickerState extends State<CoffeeTemperaturePicker> {
  CoffeeTemperature selectedTemperature = CoffeeTemperature.HOT;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16.0),
      margin: EdgeInsets.only(bottom: 32.0),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildTemperature(
                CoffeeTemperatureModel(CoffeeTemperature.HOT, "HOT / WARM")),
            buildSeparator(),
            buildTemperature(
                CoffeeTemperatureModel(CoffeeTemperature.COLD, "COLD / ICE")),
          ],
        ),
      ),
    );
  }

  Widget buildTemperature(CoffeeTemperatureModel temperature) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTemperature = temperature.temperature;
        });
      },
      child: AnimatedOpacity(
        opacity: temperature.temperature == selectedTemperature ? 1.0 : 0.3,
        duration: Duration(milliseconds: 250),
        child: Text(
          temperature.label,
          textAlign: TextAlign.center,
          style: GoogleFonts.sarala().copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }

  Widget buildSeparator() {
    return PhysicalShape(
      color: Colors.transparent,
      elevation: 8.5,
      clipper: SeparatorPathClipper(),
      child: Container(
        width: 12.0,
        height: 48.0,
        color: Colors.transparent,
      ),
    );
  }
}
