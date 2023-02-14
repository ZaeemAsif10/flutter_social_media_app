import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_media_app/views/colors/color.dart';

class CutomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CutomButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: MaterialButton(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 100),
        onPressed: onPressed,
        color: AppColor.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
        child: Text(
          text,
          style: GoogleFonts.poppins(
              fontSize: size * 0.040, color: AppColor.white),
        ),
      ),
    );
  }
}
