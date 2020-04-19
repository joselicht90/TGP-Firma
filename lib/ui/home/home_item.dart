import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

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
              settings: RouteSettings(name: '/home/buscar_solicitud'),
              child: destination,
              type: PageTransitionType.fade),
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
                child: Image(image: AssetImage(imagePath), fit: BoxFit.cover),
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
