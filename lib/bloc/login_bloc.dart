import 'dart:async';
import 'interface/bloc.dart';
import '../repository/repository.dart';

//BLOC DE PRODUCTO
class LoginBloc implements Bloc {
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  Future<Object> signIn(String usuario, String password) async {
    try {
      if (usuario == '') {
        throw (Exception('Debe ingresar un nombre de usuario'));
      }
      if (password == '') {
        throw (Exception('Debe ingresar una contraseña'));
      }
      return await Repository.signIn(usuario, password);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
