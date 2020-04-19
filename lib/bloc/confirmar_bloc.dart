import 'dart:async';
import 'package:tgp_firma/bloc/buscar_solicitud_bloc.dart';

import 'interface/bloc.dart';
import '../repository/repository.dart';

//BLOC DE PRODUCTO
class ConfirmarBloc implements Bloc {
  final _controller = StreamController<int>();

  Stream<int> get stream => _controller.stream;

  Future<bool> confirmarFirma(SolicitudFirmanteDTO solicitud) async {
    try {
      return Future.delayed(Duration(seconds: 3), () => true);
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