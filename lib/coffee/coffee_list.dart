import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenges/coffee/coffee_app_bar.dart';
import 'package:ui_challenges/coffee/coffee_details_page/coffee_details.dart';
import 'package:ui_challenges/coffee/coffee_model.dart';

class CoffeeList extends StatefulWidget {
  final List<Coffee> coffeeList;

  const CoffeeList({Key key, this.coffeeList}) : super(key: key);

  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  PageController coffeePagesController;
  PageController coffeeNamesController;

  double currentCoffeePage = 8.0;

  @override
  void initState() {
    super.initState();
    coffeePagesController = PageController(
      initialPage: 8,
      viewportFraction: 0.3,
    );
    coffeeNamesController = PageController(
      initialPage: 8,
    );

    coffeePagesController.addListener(listenCoffeePages);
  }

  void listenCoffeePages() {
    setState(() {
      currentCoffeePage = coffeePagesController.page;

      coffeeNamesController.jumpTo(
          (coffeePagesController.page + 1) * MediaQuery.of(context).size.width);
    });
    if (coffeePagesController.page >= widget.coffeeList.length-1) {
      coffeePagesController.animateToPage(
          widget.coffeeList.length - 1,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.18;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CoffeeAppBar(),
            Expanded(
              child: Stack(
                children: [
                  buildHeader(headerHeight),
                  buildShadow(),
                  buildCoffeePages(headerHeight),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(double headerHeight) {
    String price = currentCoffeePage < widget.coffeeList.length
        ? widget.coffeeList[currentCoffeePage.toInt()].price
        : "";
    double opacity = 1.0;
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: 0.0,
      child: Container(
        height: headerHeight,
        child: Column(
          children: [
            Flexible(
              child: PageView.builder(
                  controller: coffeeNamesController,
                  itemCount: widget.coffeeList.length + 2,
                  allowImplicitScrolling: false,
                  physics: NeverScrollableScrollPhysics(),
                  pageSnapping: false,
                  itemBuilder: (_, index) {
                    if (index == 0 || index == widget.coffeeList.length + 1)
                      return SizedBox();
                    var coffeeName = widget.coffeeList[index - 1].name;
                    opacity = 1.0 -
                        min(max((currentCoffeePage - index - 1), 0.0), 1.0);
                    return Opacity(
                      opacity: opacity,
                      child: Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        key: ValueKey(index),
                        child: FittedBox(
                          child: Text(
                            coffeeName,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: GoogleFonts.sarala().copyWith(
                              fontSize: 32.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Opacity(
              opacity: opacity,
              child: AnimatedSwitcher(
                duration: Duration(
                  milliseconds: 250,
                ),
                child: Container(
                  key: ValueKey(currentCoffeePage.toInt()),
                  child: Text(
                    price,
                    style: GoogleFonts.sarala(
                        fontSize: 28.0, color: Colors.black.withOpacity(0.5)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCoffeePages(double headerHeight) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      top: headerHeight,
      bottom: 0.0,
      child: Container(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CoffeeDetailsPage(
                coffee: widget.coffeeList[currentCoffeePage.round()],
              ),
            ),
          ),
          child: PageView.builder(
            controller: coffeePagesController,
            scrollDirection: Axis.vertical,
            itemCount: widget.coffeeList.length + 1,
            itemBuilder: (_, index) {
              if (index == 0) return SizedBox();
              var coffee = widget.coffeeList[index - 1];
              var x = currentCoffeePage + 1 - index;
              var scaleEffectValue = 1.2 - (x * 0.38);
              var opacity = max(min(1 - 0.51 * (x - 1), 1.0), 0.0);
              double translationValue;
              if (x < 0) {
                translationValue = -x * 280;
              } else {
                translationValue = pow(4.3 * x, 2);
              }
              translationValue -= 100;
              return Opacity(
                opacity: opacity,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..translate(
                      0.0,
                      translationValue,
                    )
                    ..scale(max(2 * scaleEffectValue, 0.0))
                    ..setEntry(3, 2, 0.002),
                  child: buildCoffeeItem(coffee),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCoffeeItem(Coffee coffee) {
    return Hero(
      tag: coffee.name,
      child: Image.asset(
        coffee.imageAsset,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    coffeePagesController.removeListener(listenCoffeePages);
  }

  Widget buildShadow() {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    MediaQuery.of(context).size.height * 0.2),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 50),
                    spreadRadius: 18.0,
                    blurRadius: 80.0,
                    color: Colors.brown,
                  ),
                  BoxShadow(
                    spreadRadius: MediaQuery.of(context).size.height * 0.07,
                    offset:
                        Offset(0, -MediaQuery.of(context).size.height * 0.105),
                    blurRadius: 35.0,
                    color: Colors.white,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
