import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingText extends StatelessWidget {
  final String headingText;
  const HeadingText({super.key, required this.headingText});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(0),
      child: Text(
        headingText,
        style: GoogleFonts.poppins(fontSize: size * 0.080),
      ),
    );
  }
}
