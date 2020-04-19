import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/buscar_solicitud/boton_continuar.dart';
import 'package:tgp_firma/ui/buscar_solicitud/hero_busqueda.dart';
import 'package:tgp_firma/ui/buscar_solicitud/input_busqueda.dart';
import 'package:tgp_firma/ui/buscar_solicitud/resultado_busqueda.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';

class BuscarSolicitudPage extends StatefulWidget {
  @override
  _BuscarSolicitudPageState createState() => _BuscarSolicitudPageState();
}

class _BuscarSolicitudPageState extends State<BuscarSolicitudPage> {
  BuscarSolicitudBloc _bloc;
  bool _isFetching = false;
  Widget _animatedContinuarChild = Container();
  double _animatedContinuarOpacity = 0;
  TextEditingController _cuitController = TextEditingController();
  TextEditingController _claveController = TextEditingController();

  void allowContinue(bool hasResult) {
    setState(() {
      if (hasResult) {
        _animatedContinuarChild =
            BotonContinuarBusquedaSolicitud(solicitud: _bloc.solicitud);
        _animatedContinuarOpacity = 1;
      } else {
        _animatedContinuarChild = Container();
        _animatedContinuarOpacity = 0;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _bloc = BuscarSolicitudBloc(callback: allowContinue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          buildBusquedaBody(context),
          Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton.extended(
                heroTag: 'back_from_buscar_solicitud',
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
          AnimatedOpacity(
            duration: Duration(microseconds: 300),
            opacity: _animatedContinuarOpacity,
            child: _animatedContinuarChild,
          ),
        ],
      ),
    );
  }

  Widget buildBusquedaBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            HeroBuscarSolicitud(),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColorDark,
                    spreadRadius: 0,
                    blurRadius: 20),
              ], color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: <Widget>[
                  InputBusquedaSolicitud(
                    prefixText: 'CUIT FIRMANTE:',
                    hintText: 'ingrese el cuit del firmante',
                    controller: _cuitController,
                  ),
                  InputBusquedaSolicitud(
                    prefixText: 'CLAVE BUSQUEDA:',
                    hintText: 'ingrese la clave de busqueda',
                    controller: _claveController,
                  ),
                  buildBotoneraInputs(context),
                ],
              ),
            ),
            ResultadoProvider(bloc: _bloc, isFetching: _isFetching),
          ],
        ),
      ),
    );
  }

  Widget buildBotoneraInputs(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(2),
            child: FlatButton(
              color: Theme.of(context).primaryColorDark,
              onPressed: () {
                _bloc.borrarBusqueda();
              },
              child: Text(
                'Borrar',
                style: GoogleFonts.encodeSans(color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(2),
            child: FlatButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                setState(() {
                  _isFetching = true;
                });
                _bloc.buscarSolicitud().then((_) {
                  setState(() {
                    _isFetching = false;
                  });
                });
              },
              child: Text(
                'Buscar',
                style: GoogleFonts.encodeSans(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
