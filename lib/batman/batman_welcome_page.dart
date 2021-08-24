import 'package:flutter/material.dart';
import 'package:ui_challenges/batman/widget/action_button.dart';

class BatmanWelcomePage extends StatefulWidget {
  @override
  _BatmanWelcomePageState createState() => _BatmanWelcomePageState();
}

class _BatmanWelcomePageState extends State<BatmanWelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _showUpAnimationController;
  Animation<double> _logoScaleDownAnimation;
  Animation<double> _logoTransitionAnimation;
  Animation<double> _batmanScaleDownAnimation;
  Animation<double> _backgroundImageOpacityAnimation;
  Animation<double> _welcomeTextOpacityAnimation;
  Animation<double> _actionsOpacityAnimation;
  Animation<double> _actionsTransitionAnimation;

  @override
  void initState() {
    super.initState();
    _showUpAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    );
    _logoScaleDownAnimation = Tween<double>(begin: 17.5, end: 1).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0, 0.25),
      ),
    );
    _logoTransitionAnimation = Tween<double>(begin: 0, end: -88.0).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.3, 0.5),
      ),
    );
    _welcomeTextOpacityAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.35, 0.5),
      ),
    );
    _batmanScaleDownAnimation = Tween<double>(begin: 5, end: 1.1).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.55, 1),
      ),
    );
    _backgroundImageOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.55, 0.8),
      ),
    );
    _actionsOpacityAnimation = Tween<double>(begin: 0, end: 1.0).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.55, 0.75),
      ),
    );
    _actionsTransitionAnimation = Tween<double>(begin: 64, end: 0.0).animate(
      CurvedAnimation(
        parent: _showUpAnimationController,
        curve: Interval(0.55, 1),
      ),
    );
    _showUpAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _showUpAnimationController,
        builder: (_, __) {
          return Stack(children: [
            buildBatmanBackgroundImage(),
            buildBatmanImage(),
            buildBottomPart(),
            buildBatmanLogo(),
          ]);
        },
      ),
    );
  }

  Widget buildBottomPart() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.4,
      left: 0.0,
      right: 0.0,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Expanded(child: buildWelcomeText()),
            SizedBox(height: 16.0),
            Expanded(
              child: buildActionButtons(),
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  Widget buildBatmanBackgroundImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Opacity(
        opacity: _backgroundImageOpacityAnimation.value,
        child: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: Image.asset(
            "assets/batman/batman_background.png",
          ),
        ),
      ),
    );
  }

  Widget buildBatmanImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(_batmanScaleDownAnimation.value),
        child: Container(
          child: Image.asset(
            "assets/batman/batman_alone.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildBatmanLogo() {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.45,
      left: 0,
      right: 0,
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..scale(_logoScaleDownAnimation.value)
          ..translate(
            0.0,
            _logoTransitionAnimation.value,
          ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.08,
          child: Image.asset("assets/batman/batman_logo.png"),
        ),
      ),
    );
  }

  Widget buildWelcomeText() {
    return Opacity(
      opacity: _welcomeTextOpacityAnimation.value,
      child: Container(
        alignment: Alignment.center,
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(children: [
            TextSpan(
              text: "WELCOME TO\n",
              style: Theme.of(context).textTheme.headline5.copyWith(
                    color: Colors.white,
                  ),
            ),
            TextSpan(
              text: "GOTHAM CITY\n",
              style: Theme.of(context).textTheme.headline3.copyWith(
                    fontSize: 32,
                    color: Colors.white,
                    letterSpacing: 1.5,
                  ),
            ),
            TextSpan(
              text: "YOU NEED ACCESS TO ENTER THE CITY",
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 8,
                    color: Colors.white.withOpacity(0.25),
                    letterSpacing: 1.0,
                  ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildActionButtons() {
    return Transform(
      transform: Matrix4.identity()
        ..translate(0.0, _actionsTransitionAnimation.value),
      child: Opacity(
        opacity: _actionsOpacityAnimation.value,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BatmanActionButton(
                actionTitle: "LOGIN",
                batPosition: BatPosition.bottomRight,
              ),
              SizedBox(height: 16.0),
              BatmanActionButton(
                actionTitle: "SIGN UP",
                batPosition: BatPosition.bottomLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
