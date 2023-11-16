import 'package:flutter/material.dart';

/*
class NavbarAvatar extends StatelessWidget {
  const NavbarAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        width: 30,
        height: 30,
        child: Image.network('https://dl.airtable.com/DH4ROlhgSVG6TpXY0xrI_large_Joel-Monegro-pic-458x458.jpg'),
      ),
    );
  }
}*/

class NavbarAvatar extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NavbarAvatar({Key? key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.network(
          'https://i.pinimg.com/474x/b4/f4/93/b4f4936ef70a1a6968950d1c6706aab9.jpg',
          errorBuilder: (context, error, stackTrace) {
            return const Text('Error al cargar la imagen');
          },
        ),
      ),
    );
  }
}