

import 'package:flutter/material.dart';

class CarpetList extends StatelessWidget {

  final List<String> buttonNames = ['Botón 1', 'Botón 2', 'Botón 3', 'Botón 4', 'Botón 5']; 

   CarpetList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: buttonNames.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 20,
          color: Colors.transparent,
          child: TextButton(
            onPressed: () {
              // Aquí puedes poner lo que quieres que haga el botón cuando se presiona
              print('Has presionado el ${buttonNames[index]}');
            },
            child: Text(buttonNames[index]),
          ),
        );
      },
    );
  }
}