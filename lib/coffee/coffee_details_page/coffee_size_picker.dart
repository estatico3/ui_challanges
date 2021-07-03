import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_size/coffee_size.dart';

class CoffeeSizePicker extends StatefulWidget {
  final Function(CoffeeSize) onCoffeeSizeChanged;
  final CoffeeSize initialCoffeeSize;

  const CoffeeSizePicker(
      {Key key, this.onCoffeeSizeChanged, this.initialCoffeeSize})
      : super(key: key);

  @override
  _CoffeeSizePickerState createState() => _CoffeeSizePickerState();
}

class _CoffeeSizePickerState extends State<CoffeeSizePicker> {
  final List<CoffeeSizeModel> coffeeSizes = [
    CoffeeSizeModel(
      CoffeeSize.SMALL,
      "S",
      "assets/coffee/taza_s.png",
    ),
    CoffeeSizeModel(
      CoffeeSize.MEDIUM,
      "M",
      "assets/coffee/taza_m.png",
    ),
    CoffeeSizeModel(
      CoffeeSize.LARGE,
      "L",
      "assets/coffee/taza_l.png",
    ),
  ];

  CoffeeSize _selectedCoffeeSize;

  @override
  void initState() {
    super.initState();
    _selectedCoffeeSize = widget.initialCoffeeSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: coffeeSizes
            .map((coffeeSize) => buildCoffeeSize(coffeeSize))
            .toList(),
      ),
    );
  }

  Widget buildCoffeeSize(CoffeeSizeModel coffeeSize) {
    Color color = coffeeSize.size == _selectedCoffeeSize
        ? Color(0xFF663300)
        : Colors.brown.shade400;
    double opacity = coffeeSize.size == _selectedCoffeeSize ? 1.0 : 0.3;
    double imageSize = 56.0;
    return GestureDetector(
      onTap: () => setState(() {
        _selectedCoffeeSize = coffeeSize.size;
        widget.onCoffeeSizeChanged(_selectedCoffeeSize);
      }),
      child: AnimatedOpacity(
        opacity: opacity,
        duration: Duration(milliseconds: 300),
        child: Container(
          color: Colors.transparent,
          key: ValueKey(coffeeSize.size),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                coffeeSize.imageAsset,
                width: imageSize,
                height: imageSize,
                color: color,
              ),
              Transform(
                transform: Matrix4.translationValues(-4.0, 0.0, 0.0),
                child: Text(
                  coffeeSize.label,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sarala().copyWith(
                    fontSize: 24.0,
                    color: color,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
