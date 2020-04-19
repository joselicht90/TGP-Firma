import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/confirmar_firma/propiedad_solicitud.dart';

class PortraitBody extends StatelessWidget {
  const PortraitBody({
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
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
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
    );
  }
}