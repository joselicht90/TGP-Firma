import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/bloc/confirmar_bloc.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/confirmar_firma/landscape_body.dart';
import 'package:tgp_firma/ui/confirmar_firma/portrait_body.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';
import 'dart:convert';
import 'dart:io';

class ConfirmarFirmaPage extends StatefulWidget {
  ConfirmarFirmaPage({
    @required this.solicitud,
  });

  final SolicitudFirmanteDTO solicitud;

  @override
  _ConfirmarFirmaPageState createState() => _ConfirmarFirmaPageState();
}

class _ConfirmarFirmaPageState extends State<ConfirmarFirmaPage> {
  bool _isLoading = false;
  ConfirmarBloc _bloc = ConfirmarBloc();
  Widget switcherWidget = Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            child: _isLoading == false
                ? buildBody(context)
                : FutureBuilder(
                    future: _bloc.confirmarFirma(widget.solicitud),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var message = ConfirmarMessage(
                          app: widget.solicitud.app,
                          id: widget.solicitud.id.toString(),
                          documento: widget.solicitud.documento,
                        );
                        switcherWidget = message;
                      }
                      return AnimatedSwitcher(
                        transitionBuilder:
                            (Widget child, Animation<double> opacity) {
                          return FadeTransition(
                            opacity: opacity,
                            child: child,
                          );
                        },
                        duration: Duration(milliseconds: 300),
                        child: switcherWidget,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? PortraitBody(solicitud: widget.solicitud)
                      : LandscapeBody(solicitud: widget.solicitud),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: 'back_from_confirmar_solicitud',
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
        Container(
          margin: const EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton.extended(
              heroTag: 'confirmar_solicitud',
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
              },
              backgroundColor: Theme.of(context).primaryColorDark,
              icon: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                'Confirmar',
                style: GoogleFonts.encodeSans(
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConfirmarMessage extends StatelessWidget {
  const ConfirmarMessage({
    Key key,
    @required this.app,
    @required this.documento,
    @required this.id,
  }) : super(key: key);

  final String app;
  final String documento;
  final String id;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    text: 'Se ha firmado el documento ',
                    style: GoogleFonts.encodeSans(
                        fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(
                        text: documento,
                        style:
                            GoogleFonts.encodeSans(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' Nro ',
                      ),
                      TextSpan(
                        text: '$id.\n',
                        style:
                            GoogleFonts.encodeSans(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Ingrese con CLave Fiscal en la Aplicación ',
                    style: GoogleFonts.encodeSans(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: app,
                        style:
                            GoogleFonts.encodeSans(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' para confirmar el proceso de Firma realizado.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  PageTransition(
                      child: BuscarSolicitudPage(),
                      type: PageTransitionType.leftToRightWithFade),
                  ModalRoute.withName('/home'),
                );
              },
              backgroundColor: Colors.white,
              heroTag: 'finalizar_proceso',
              child: Icon(
                Icons.check,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        )
      ],
    );
  }
}
