import 'package:flutter/material.dart';

class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter({super.key});

  /*
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: buildBoxDecoration(),
        child: Container(
          constraints: BoxConstraints( maxWidth: 400 ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Image(
                image: AssetImage('biblioteca.png'),
                width: 400,
              ),
            ),
          ),
        ),
      )
    );
  }
  */
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: buildBoxDecoration(),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Image(
                    image: AssetImage('assets/biblioteca.png'),
                    width: 400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }





  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/biblioteca.jpg'),
          fit: BoxFit.cover
        )
    );
  }
}

