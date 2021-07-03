import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenges/coffee/coffee_app_bar.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_size/coffee_size.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_size_picker.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_temperature_picker/coffee_temperature_picker.dart';
import 'package:ui_challenges/coffee/coffee_model.dart';

class CoffeeDetailsPage extends StatefulWidget {
  final Coffee coffee;

  const CoffeeDetailsPage({Key key, this.coffee}) : super(key: key);

  @override
  _CoffeeDetailsPageState createState() => _CoffeeDetailsPageState();
}

class _CoffeeDetailsPageState extends State<CoffeeDetailsPage>
    with SingleTickerProviderStateMixin {
  CoffeeSize _selectedCoffeeSize = CoffeeSize.MEDIUM;

  AnimationController _animationController;
  Animation<double> _priceAnimation;
  Animation<double> _addActionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 375),
      value: 0,
    );
    _priceAnimation = Tween(begin: 0.0, end: 64.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1),
      ),
    );

    _addActionAnimation = Tween(begin: 0.0, end: 56.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Interval(0, 1),
      ),
    );
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) => Column(
            children: [
              buildAppBar(),
              buildName(),
              Expanded(child: buildCoffeeDetails()),
              buildSizePicker(),
              buildTemperaturePicker(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return CoffeeAppBar();
  }

  Widget buildName() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        widget.coffee.name,
        style: GoogleFonts.sarala().copyWith(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildCoffeeDetails() {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 24.0),
      child: Stack(
        children: [
          buildCoffeeItem(),
          buildAddToCartAction(),
          buildPrice(),
        ],
      ),
    );
  }

  Widget buildCoffeeItem() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: LayoutBuilder(builder: (_, constraints) {
        double scalePercentage;
        switch (_selectedCoffeeSize) {
          case CoffeeSize.SMALL:
            scalePercentage = 0.6;
            break;
          case CoffeeSize.MEDIUM:
            scalePercentage = 0.8;
            break;
          case CoffeeSize.LARGE:
            scalePercentage = 1.0;
            break;
        }
        double height = constraints.maxHeight * scalePercentage;
        double width = constraints.maxWidth * scalePercentage;
        return AnimatedContainer(
          height: height,
          width: width,
          curve: Curves.easeInOutBack,
          duration: Duration(milliseconds: 500),
          alignment: Alignment.center,
          child: Hero(
            tag: widget.coffee.name,
            child: Image.asset(
              widget.coffee.imageAsset,
            ),
          ),
        );
      }),
    );
  }

  Widget buildSizePicker() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 32.0),
      child: CoffeeSizePicker(
        initialCoffeeSize: _selectedCoffeeSize,
        onCoffeeSizeChanged: (updatedCoffeeSize) =>
            setState(() => _selectedCoffeeSize = updatedCoffeeSize),
      ),
    );
  }

  Widget buildTemperaturePicker() {
    return CoffeeTemperaturePicker();
  }

  Widget buildAddToCartAction() {
    double addActionSize = 48.0;
    double addActionIconSize = 32.0;

    return Positioned(
      right: _addActionAnimation.value,
      top: 16.0,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            blurRadius: 24.0,
          ),
        ]),
        child: Material(
          color: Colors.white,
          shape: CircleBorder(),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: addActionSize,
              height: addActionSize,
              child: Icon(
                Icons.add,
                size: addActionIconSize,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPrice() {
    double priceDouble =
        double.tryParse(widget.coffee.price.replaceFirst("€", ""));
    String price = priceDouble % 1 == 0
        ? priceDouble.toInt().toString()
        : priceDouble.toStringAsFixed(1);
    price += "€";

    return Positioned(
      left: _priceAnimation.value,
      bottom: 0.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: -16.0,
              blurRadius: 36.0,
            ),
          ],
        ),
        child: Text(
          price,
          style: GoogleFonts.sarala().copyWith(
            fontSize: 56.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
