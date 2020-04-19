import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 100),
              child: Image.asset('assets/img/logo-web-2020b-c8dedabc.png'),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                HomeItem(
                  destination: BuscarSolicitudPage(),
                  tag: 'hero_gestionar_solicitud_firma',
                  text: 'Gestionar solicitud de firma',
                  imagePath: 'assets/img/gestionar_solicitud.png',
                  left: MediaQuery.of(context).size.width * 0.35,
                  top: -30,
                  textAlignment: Alignment.centerLeft,
                ),
                HomeItem(
                  destination: BuscarSolicitudPage(),
                  tag: 'hero_buscar_solicitud_firma',
                  text: 'Buscar solicitud de firma',
                  imagePath: 'assets/img/buscar_solicitud.png',
                  right: MediaQuery.of(context).size.width * 0.50,
                  bottom: -30,
                  textAlignment: Alignment.centerRight,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                  heroTag: 'sing_out',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(
                    'Salir',
                    style: GoogleFonts.encodeSans(
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({
    @required this.imagePath,
    @required this.text,
    @required this.tag,
    @required this.destination,
    this.top,
    this.bottom,
    this.left,
    this.right,
    @required this.textAlignment,
    Key key,
  }) : super(key: key);

  final String imagePath;
  final String text;
  final String tag;
  final double top;
  final double bottom;
  final double right;
  final double left;
  final Widget destination;
  final Alignment textAlignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageTransition(
              child: destination, type: PageTransitionType.fade),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Hero(
        tag: tag,
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
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
                right: right ?? 0,
                top: top ?? 0,
                bottom: bottom ?? 0,
                left: left ?? 0,
                child: Image(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover),
              ),
              Align(
                alignment: textAlignment,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.33,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.encodeSans(
                        color: Theme.of(context).primaryColorDark,
                        fontSize: 22),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
