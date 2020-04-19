import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputBusquedaSolicitud extends StatelessWidget {
  const InputBusquedaSolicitud({
    @required this.prefixText,
    @required this.hintText,
    @required this.controller,
    Key key,
  }) : super(key: key);

  final String prefixText;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
              child: Text(
                'CUIT FIRMANTE:',
                style: GoogleFonts.encodeSans(
                    color: Theme.of(context).primaryColorDark,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            enabledBorder: InputBorder.none,
            hintText: 'ingrese el cuit del firmante'),
      ),
    );
  }
}