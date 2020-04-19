import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/confirmar_firma/confirmar_firma.dart';
import 'package:tgp_firma/ui/firmar_solicitud/firmar_solicitud.dart';
import 'package:tgp_firma/ui/home/home.dart';
import 'package:tgp_firma/ui/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TGP Firma',
      initialRoute: '/login',
      routes: {
        '/login' : (context) => LogInPage(),
        '/home' : (context) => HomePage(),
        '/home/buscar_solicitud' : (context) => BuscarSolicitudPage(),
        '/home/buscar_solicitud/firmar_solicitud' : (context) => FirmarSolicitud(solicitud: SolicitudFirmanteDTO(),),
        '/home/buscar_solicitud/firmar_solicitud/confirmar_solicitud' : (context) => ConfirmarFirmaPage(solicitud: SolicitudFirmanteDTO(),),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF00b1c7),
        primaryColorDark: Color(0xFF242427),
        primaryTextTheme: TextTheme(
          body1: GoogleFonts.encodeSans(
            color: Colors.white
          ),
          title: GoogleFonts.encodeSans(
            color: Colors.white
          ),
          subtitle: GoogleFonts.encodeSans(
            color: Colors.black
          ),
        )
      ),
      // home: LogInPage(),
    );
  }
}
