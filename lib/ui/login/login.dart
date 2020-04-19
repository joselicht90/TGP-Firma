import 'package:flutter/material.dart';
import 'package:tgp_firma/bloc/login_bloc.dart';
import 'package:tgp_firma/ui/generics/background_image.dart';

import 'login_body.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LoginBloc _bloc = LoginBloc();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: <Widget>[
          BackgroundImage(),
          LoginBody(
            bloc: _bloc,
          ),
        ],
      ),
    );
  }
}




