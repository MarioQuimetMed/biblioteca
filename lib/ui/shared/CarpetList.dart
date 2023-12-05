import 'package:flutter/material.dart';

class CarpetList extends StatelessWidget {
  final List<String> buttonNames = [
    'Botón 1',
    'Botón 2',
    'Botón 3',
    'Botón 4',
    'Botón 5'
  ];

  CarpetList({Key? key}) : super(key: key);

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

class DialogoConTexto extends StatelessWidget {
  final List<String> nombres;
  final int index;

  const DialogoConTexto({Key? key, required this.nombres, required this.index})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return TextButton(
      onPressed: () {
        // Aquí puedes poner lo que quieres que haga el botón cuando se presiona
        //print('Has presionado el ${buttonNames[index]}');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Ingresa texto'),
              content: TextField(
                decoration: InputDecoration(hintText: "Ingresa tu texto aquí"),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    // Aquí puedes manejar lo que quieres hacer con el texto ingresado
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      child: Text(nombres[index]),
    );
  }
}
