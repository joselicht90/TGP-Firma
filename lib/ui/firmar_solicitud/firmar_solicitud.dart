import 'package:flutter/material.dart';
import 'package:flutter_signature_pad/flutter_signature_pad.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';
import 'package:flutter/services.dart';

class FirmarSolicitud extends StatefulWidget {
  @override
  _FirmarSolicitudState createState() => _FirmarSolicitudState();
}

class _FirmarSolicitudState extends State<FirmarSolicitud> {
  ByteData _img = ByteData(0);
  final _sign = GlobalKey<SignatureState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Signature(
                      key: _sign,
                      color: Colors.black,
                      strokeWidth: 5.0,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      FlatButton(
                        onPressed: () async {
                          setState(() {
                            final sign = _sign.currentState;
                            sign.clear();
                          });
                        },
                        child: Text('Borrar'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
