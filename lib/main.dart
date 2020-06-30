import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/bloc/shared_preferences/shared_preferences_bloc.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/confirmar_firma/confirmar_firma.dart';
import 'package:tgp_firma/ui/firmar_solicitud/firmar_solicitud.dart';
import 'package:tgp_firma/ui/home/home.dart';
import 'package:tgp_firma/ui/login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var token = await SharedPreferencesBloc.getToken();
  runApp(MyApp(
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  final String token;

  MyApp({this.token});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TGP Firma',
      initialRoute: token != null ? '/home' : '/login',
      routes: {
        '/login': (context) => LogInPage(),
        '/home': (context) => HomePage(),
        '/home/buscar_solicitud': (context) => BuscarSolicitudPage(),
        '/home/buscar_solicitud/firmar_solicitud': (context) => FirmarSolicitud(
              solicitud: SolicitudFirmanteDTO(),
            ),
        '/home/buscar_solicitud/firmar_solicitud/confirmar_solicitud':
            (context) => ConfirmarFirmaPage(
                  solicitud: SolicitudFirmanteDTO(),
                ),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF00b1c7),
          primaryColorDark: Color(0xFF242427),
          primaryTextTheme: TextTheme(
            bodyText2: GoogleFonts.encodeSans(color: Colors.white),
            headline6: GoogleFonts.encodeSans(color: Colors.white),
            subtitle2: GoogleFonts.encodeSans(color: Colors.black),
          )),
      // home: LogInPage(),
    );
  }
}
