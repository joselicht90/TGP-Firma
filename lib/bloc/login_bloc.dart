import 'dart:async';
import 'interface/bloc.dart';
import '../repository/repository.dart';

//BLOC DE PRODUCTO
class LoginBloc implements Bloc {
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  Future<String> signIn(String usuario, String password) async {
    try {
      return Repository.signIn(usuario, password);
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