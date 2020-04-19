import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropiedadSolicitud extends StatelessWidget {
  PropiedadSolicitud({
    @required this.propertyName,
    @required this.propertyValue,
  });
  final String propertyName;
  final String propertyValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          propertyName,
          textAlign: TextAlign.center,
          style: GoogleFonts.encodeSans(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            propertyValue,
            textAlign: TextAlign.center,
            style: GoogleFonts.encodeSans(fontSize: 15),
          ),
        ),
      ],
    );
  }
}