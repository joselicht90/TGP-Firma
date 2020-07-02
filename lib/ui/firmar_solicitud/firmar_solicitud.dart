import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/confirmar_firma/confirmar_firma.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';
import 'package:flutter/services.dart';

class FirmarSolicitud extends StatefulWidget {
  FirmarSolicitud({
    @required this.solicitud,
  });
  final SolicitudFirmanteDTO solicitud;
  @override
  _FirmarSolicitudState createState() => _FirmarSolicitudState();
}

class _FirmarSolicitudState extends State<FirmarSolicitud> {
  final _sign = GlobalKey<SignatureState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          buildFirmaBody(context),
        ],
      ),
    );
  }

  SafeArea buildFirmaBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                'Firme dentro del cuadro blanco',
                style:
                    GoogleFonts.encodeSans(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
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
              child: Signature(
                key: _sign,
                color: Colors.black,
                strokeWidth: 5.0,
              ),
            ),
          ),
          buildBotonera(context),
        ],
      ),
    );
  }

  Container buildBotonera(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                heroTag: 'back_from_firmar_solicitud',
                onPressed: () => Navigator.of(context).pop(),
                backgroundColor: Theme.of(context).primaryColorDark,
                icon: Icon(Icons.arrow_back),
                label: Text(
                  'Atras',
                  style: GoogleFonts.encodeSans(color: Colors.white),
                ),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    heroTag: 'limpiar_signature_pad',
                    onPressed: () async {
                      setState(() {
                        final sign = _sign.currentState;
                        sign.clear();
                      });
                    },
                    backgroundColor: Theme.of(context).primaryColorDark,
                    icon: Icon(Icons.clear),
                    label: Text(
                      'Borrar',
                      style: GoogleFonts.encodeSans(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FloatingActionButton.extended(
                    heroTag: 'confirmar_firma',
                    onPressed: () async {
                      final sign = _sign.currentState;
                      if (sign.hasPoints) {
                        ByteData _byteData = await sign.getData().then(
                              (onValue) => onValue.toByteData(
                                  format: ui.ImageByteFormat.png),
                            );
                        Image _image =
                            Image.memory(_byteData.buffer.asUint8List());
                        widget.solicitud.firma = _image;
                        widget.solicitud.bytearray =
                            _byteData.buffer.asUint8List();
                        var simplified = sign.points
                            .map((e) =>
                                [e != null ? e.dx : 0, e != null ? e.dy : 0])
                            .toList();
                        String j = json.encode(simplified);
                        Navigator.of(context).push(
                          PageTransition(
                              settings: RouteSettings(
                                  name:
                                      '/home/buscar_solicitud/firmar_solicitud/confirmar_solicitud'),
                              child: ConfirmarFirmaPage(
                                solicitud: widget.solicitud,
                              ),
                              type: PageTransitionType.fade),
                        );
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColorDark,
                    icon: Icon(
                      Icons.check,
                      color: Theme.of(context).primaryColor,
                    ),
                    label: Text(
                      'Aceptar',
                      style: GoogleFonts.encodeSans(
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
