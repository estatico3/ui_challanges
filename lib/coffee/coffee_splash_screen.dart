import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui_challenges/coffee/coffee_app_bar.dart';
import 'package:ui_challenges/coffee/coffee_list.dart';
import 'package:ui_challenges/coffee/coffee_model.dart';

class CoffeeSplashScreen extends StatefulWidget {
  final List<String> coffeeNames = [
    "Caramel Macchiato",
    "Caramel Cold Drink",
    "Iced Coffe Mocha",
    "Caramelized Pecan Latte",
    "Toffee Nut Latte",
    "Capuchino",
    "Toffee Nut Iced Latte",
    "Americano",
    "Vietnamese-Style Iced Coffee",
    "Black Tea Latte",
    "Classic Irish Coffee",
    "Toffee Nut Crunch Latte",
  ];

  @override
  _CoffeeSplashScreenState createState() => _CoffeeSplashScreenState();
}

class _CoffeeSplashScreenState extends State<CoffeeSplashScreen> {
  List<Coffee> coffeeList = [];

  @override
  void initState() {
    super.initState();

    initCoffeeList();
  }

  void initCoffeeList() {
    Random random = Random();
    for (int i = 0; i < widget.coffeeNames.length; i++) {
      var coffee = Coffee(
        "assets/coffee/${i + 1}.png",
        widget.coffeeNames[i],
        (3 + (random.nextDouble() * 2).floorToDouble()).toStringAsFixed(2) +
            "€",
      );
      coffeeList.add(coffee);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if(details.delta.dy > -20) return;
          Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => CoffeeList(
                coffeeList: coffeeList,
              ),
              transitionsBuilder: (_, transitionAnimation, __, child) =>
                  FadeTransition(
                opacity: transitionAnimation,
                child: child,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            buildBackground(),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.2,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Hero(
                tag: coffeeList[5].name,
                child: Image.asset(
                  coffeeList[5].imageAsset,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.27,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Hero(
                tag: coffeeList[6].name,
                child: Image.asset(
                  coffeeList[6].imageAsset,
                  alignment: Alignment.center,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.38,
              height: MediaQuery.of(context).size.height * 0.67,
              child: Hero(
                tag: coffeeList[7].name,
                child: Image.asset(
                  coffeeList[7].imageAsset,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.85,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Hero(
                tag: coffeeList[8].name,
                child: Image.asset(
                  coffeeList[8].imageAsset,
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              top: MediaQuery.of(context).size.height * 0.6,
              height: MediaQuery.of(context).size.height * 0.225,
              child: Image.asset(
                "assets/coffee/logo.png",
                alignment: Alignment.topCenter,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned buildBackground() {
    return Positioned.fill(
      child: Container(
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: AlignmentDirectional.bottomCenter,
            stops: [0.05, 0.5],
            colors: [
              Color(0xffaa8a6b),
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.0),
          child: CoffeeAppBar(
            actionsColor: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
