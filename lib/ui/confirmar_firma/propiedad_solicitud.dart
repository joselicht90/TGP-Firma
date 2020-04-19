import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PropiedadSolicitudConfirmar extends StatelessWidget {
  const PropiedadSolicitudConfirmar({
    Key key,
    @required this.propertyName,
    @required this.propertyValue,
  }) : super(key: key);

  final String propertyName;
  final String propertyValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(
              propertyName,
              style: GoogleFonts.encodeSans(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              propertyValue,
              style: GoogleFonts.encodeSans(),
            ),
          ),
        ],
      ),
    );
  }
}