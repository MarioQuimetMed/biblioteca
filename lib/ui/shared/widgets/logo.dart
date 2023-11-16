import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(30),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/biblioteca.png',
            width: screenWidth * 0.135, //  5% del ancho de la pantalla
            height: screenWidth * 0.135, // 5% del ancho de la pantalla
          ),
          const SizedBox(width: 1),
          Text(
            'Dominica',
            style: GoogleFonts.montserratAlternates(
              fontSize: screenWidth * 0.04, // 4% del ancho de la pantalla
              fontWeight: FontWeight.w200,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}