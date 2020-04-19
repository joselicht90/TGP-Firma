import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/bloc/provider/bloc_provider.dart';
import 'package:tgp_firma/ui/firmar_solicitud/firmar_solicitud.dart';
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
        _animatedContinuarChild = BotonContinuarBusquedaSolicitud();
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

class BotonContinuarBusquedaSolicitud extends StatelessWidget {
  const BotonContinuarBusquedaSolicitud({
    Key key,
  }) : super(key: key);

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
                child: FirmarSolicitud(), type: PageTransitionType.fade),
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

class ResultadoProvider extends StatelessWidget {
  const ResultadoProvider({
    Key key,
    @required BuscarSolicitudBloc bloc,
    @required bool isFetching,
  })  : _bloc = bloc,
        _isFetching = isFetching,
        super(key: key);

  final BuscarSolicitudBloc _bloc;
  final bool _isFetching;

  Column buildSearchResult(SolicitudFirmanteDTO solicitud) {
    return Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: Duration(milliseconds: 300),
        childAnimationBuilder: (widget) => SlideAnimation(
          verticalOffset: 50.0,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children: <Widget>[
          PropiedadSolicitud(
            propertyName: 'Firmante',
            propertyValue: solicitud.firmante,
          ),
          PropiedadSolicitud(
            propertyName: 'En nombre de',
            propertyValue: solicitud.ente,
          ),
          PropiedadSolicitud(
            propertyName: 'Documento',
            propertyValue: solicitud.documento,
          ),
          PropiedadSolicitud(
            propertyName: 'Identificación',
            propertyValue: solicitud.id.toString(),
          ),
          PropiedadSolicitud(
            propertyName: 'Aplicación',
            propertyValue: solicitud.app,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _bloc,
      child: StreamBuilder(
        stream: _bloc.stream,
        builder: (context, snapshot) {
          if (_isFetching) {
            return Container(
              margin: const EdgeInsets.only(top: 100),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            ResultadoBusquedaSolicitudDTO resultadoBusqueda = snapshot.data;
            if (resultadoBusqueda.hasResult) {
              return Container(
                margin: const EdgeInsets.only(bottom: 50),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildSearchResult(resultadoBusqueda.solicitud),
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(top: 50),
                child: Text(
                  'No existe la solicitud ingresada.',
                  textAlign: TextAlign.center,
                  style:
                      GoogleFonts.encodeSans(color: Colors.white, fontSize: 22),
                ),
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}

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
