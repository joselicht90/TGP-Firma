import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';
import 'package:tgp_firma/ui/home/home_item.dart';
import 'package:tgp_firma/ui/login/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _logOutPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20, top: 20),
                        child: Image.asset(
                            'assets/img/logo-web-2020b-c8dedabc.png'),
                      ),
                    ),
                    Padding(
                      padding: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.20 -
                                  20)
                          : EdgeInsets.only(top: 0),
                      child: Column(
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
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton.extended(
                  heroTag: 'sing_out',
                  onPressed: () {
                    showDialog(
                      context: context,
                      child: LogOutDialog(),
                    );
                  },
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

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '¿Desea salir de la apliación?',
              textAlign: TextAlign.start,
              style: GoogleFonts.encodeSans(fontSize: 20),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      color: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Cancelar',
                        style: GoogleFonts.encodeSans(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          PageTransition(
                            child: LogInPage(),
                            type: PageTransitionType.fade,
                            settings: RouteSettings(name: '/login'),
                          ),
                        );
                      },
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        'Aceptar',
                        style: GoogleFonts.encodeSans(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
