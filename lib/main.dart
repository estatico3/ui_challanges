import 'package:flutter/material.dart';
import 'package:ui_challenges/batman/batman_challange.dart';
import 'package:ui_challenges/challenges.dart';
import 'package:ui_challenges/coffee/coffee_splash_screen.dart';

void main() {
  runApp(UIChallengesList());
}

class UIChallengesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("UI Challenges"),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.all(16.0),
            child: ListView.builder(
                itemCount: Challenge.values.length,
                itemBuilder: (context, index) {
                  var challenge = Challenge.values[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => openChallenge(context, challenge),
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.all(16.0))),
                      child: Text(
                        challenge.stringValue,
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }

  void openChallenge(BuildContext context, Challenge challenge) {
    Widget target;
    switch (challenge) {
      case Challenge.COFFEE:
        target = CoffeeSplashScreen();
        break;
      case Challenge.BATMAN:
        target = BatmanChallenge();
        break;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => target),
    );
  }
}
