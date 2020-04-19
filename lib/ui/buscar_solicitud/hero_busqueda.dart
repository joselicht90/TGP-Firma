import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroBuscarSolicitud extends StatelessWidget {
  const HeroBuscarSolicitud({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'hero_buscar_solicitud_firma',
      child: Container(
        margin: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).primaryColorDark,
                spreadRadius: 0,
                blurRadius: 20),
          ],
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: MediaQuery.of(context).size.width * 0.35,
              top: -30,
              child: Image(
                  image: AssetImage('assets/img/buscar_solicitud.png'),
                  fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.33,
                child: Text(
                  'Buscar solicitud de firma',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.encodeSans(
                      color: Theme.of(context).primaryColorDark, fontSize: 22),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}