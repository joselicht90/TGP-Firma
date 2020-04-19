import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/confirmar_firma/propiedad_solicitud.dart';

class LandscapeBody extends StatelessWidget {
  const LandscapeBody({
    Key key,
    @required this.solicitud,
  }) : super(key: key);

  final SolicitudFirmanteDTO solicitud;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColorDark,
              spreadRadius: 0,
              blurRadius: 20),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                PropiedadSolicitudConfirmar(
                  propertyName: 'Firmante:',
                  propertyValue: solicitud.firmante,
                ),
                PropiedadSolicitudConfirmar(
                  propertyName: 'En nombre de:',
                  propertyValue: solicitud.ente,
                ),
                PropiedadSolicitudConfirmar(
                  propertyName: 'Documento:',
                  propertyValue: solicitud.documento,
                ),
                PropiedadSolicitudConfirmar(
                  propertyName: 'Identificación:',
                  propertyValue: solicitud.id.toString(),
                ),
                PropiedadSolicitudConfirmar(
                  propertyName: 'Aplicación:',
                  propertyValue: solicitud.app,
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: solicitud.firma,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Firma',
                    style: GoogleFonts.encodeSans(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
