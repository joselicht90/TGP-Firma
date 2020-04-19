import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/firmar_solicitud/firmar_solicitud.dart';

class BotonContinuarBusquedaSolicitud extends StatelessWidget {
  const BotonContinuarBusquedaSolicitud({
    @required this.solicitud,
    Key key,
  }) : super(key: key);

  final SolicitudFirmanteDTO solicitud;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: FloatingActionButton.extended(
          heroTag: 'foward_from_buscar_solicitud',
          onPressed: () => Navigator.of(context).push(
            PageTransition(
              settings: RouteSettings(name: '/home/buscar_solicitud/firmar_solicitud'),
                child: FirmarSolicitud(
                  solicitud: solicitud,
                ),
                type: PageTransitionType.fade),
          ),
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Icon(
            Icons.arrow_forward,
            color: Theme.of(context).primaryColor,
          ),
          label: Text(
            'Siguiente',
            style:
                GoogleFonts.encodeSans(color: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
