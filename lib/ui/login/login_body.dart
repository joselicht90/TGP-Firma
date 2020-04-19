import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tgp_firma/bloc/login_bloc.dart';
import 'package:tgp_firma/ui/home/home.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({
    @required LoginBloc bloc,
    Key key,
  })  : _bloc = bloc,
        super(key: key);

  final LoginBloc _bloc;
  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  bool _isLoading = false;
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _passwordControlelr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: _isLoading == false
          ? buildBody(context)
          : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
    );
  }

  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25),
              child: Image.asset('assets/img/logo-web-2020b-c8dedabc.png'),
            ),
          ),
          buildInputs(),
          FlatButton(
            onPressed: () {},
            child: Text(
              'Olvidé mi contraseña',
              style: GoogleFonts.encodeSans(
                  color: Theme.of(context).primaryColorDark),
            ),
          ),
          buildBotonLogIn(context),
        ],
      ),
    );
  }

  Widget buildBotonLogIn(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: InkWell(
          onTap: () {
            setState(() {
              _isLoading = true;
            });
            widget._bloc
                .signIn(_usuarioController.value.text,
                    _passwordControlelr.value.text)
                .then(
              (_) {
                Navigator.of(context).pushReplacement(
                  PageTransition(
                      child: HomePage(), type: PageTransitionType.fade),
                );
              },
            );
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColorDark),
            child: Text(
              'Ingresar',
              textAlign: TextAlign.center,
              style: GoogleFonts.encodeSans(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInputs() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(5),
            child: TextField(
              controller: _usuarioController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  enabledBorder: InputBorder.none,
                  hintText: 'Usuario'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: TextField(
              controller: _passwordControlelr,
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  enabledBorder: InputBorder.none,
                  hintText: 'Contraseña'),
            ),
          ),
        ],
      ),
    );
  }
}
