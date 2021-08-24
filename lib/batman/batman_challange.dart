import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui_challenges/batman/batman_welcome_page.dart';

class BatmanChallenge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light().copyWith(
        textTheme: GoogleFonts.vidalokaTextTheme(),
      ),
      child: BatmanWelcomePage(),
    );
  }
}
