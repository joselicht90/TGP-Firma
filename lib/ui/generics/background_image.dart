import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Opacity(
        opacity: 0.1,
        child: Image(
          image: AssetImage('assets/img/845-bn-contrastless.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}