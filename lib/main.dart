import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tgp_firma/ui/buscar_solicitud/buscar_solicitud.dart';
import 'package:tgp_firma/ui/home/home.dart';
import 'package:tgp_firma/ui/login/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TGP Firma',
      initialRoute: 'login',
      routes: {
        'login' : (context) => LogInPage(),
        'home' : (context) => HomePage(),
        'buscar_solicitud' : (context) => BuscarSolicitudPage(),
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
