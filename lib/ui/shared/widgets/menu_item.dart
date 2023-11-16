import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MenuItem extends StatefulWidget {

  final String text;
  final IconData icon;
  bool isActive;
  final Function onPressed;

   MenuItem({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isActive = false,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuItemState createState() => _MenuItemState();

}

class _MenuItemState extends State<MenuItem> {

  bool isHovered = false;

  void cambiarActivo( ) {
    setState(() {
      widget.isActive = !widget.isActive;
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration( milliseconds: 250 ),
      decoration: BoxDecoration(
      color: isHovered
        ? Colors.orange
        : widget.isActive ? const Color.fromARGB(255, 237, 112, 59) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              if (!widget.isActive) {
                widget.onPressed();
              }
              cambiarActivo();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric( horizontal: 30, vertical: 10),
              child: MouseRegion(
                onEnter: ( _ ) => setState( () => isHovered = true ),
                onExit: ( _ ) => setState( () => isHovered = false ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon( widget.icon, color: Colors.white),
                    const SizedBox( width: 10 ),
                    Text(
                      widget.text,
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        //color: Colors.white.withOpacity(0.8)
                        color : Colors.white
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
