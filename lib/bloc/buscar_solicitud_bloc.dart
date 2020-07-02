import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'interface/bloc.dart';
import '../repository/repository.dart';

//BLOC DE PRODUCTO
class BuscarSolicitudBloc implements Bloc {
  BuscarSolicitudBloc({
    @required this.callback,
  });

  final Function(bool) callback;
  SolicitudFirmanteDTO solicitud;
  bool hasResult = false;
  bool hasFetched = false;
  final _controller = StreamController<ResultadoBusquedaSolicitudDTO>();

  Stream<ResultadoBusquedaSolicitudDTO> get stream => _controller.stream;

  void borrarBusqueda() {
    _controller.sink.add(null);
    hasFetched = false;
    hasResult = false;
    callback(hasResult);
  }

  Future<ResultadoBusquedaSolicitudDTO> buscarSolicitud() async {
    try {
      ResultadoBusquedaSolicitudDTO resultadoBusqueda = await Future.delayed(
        Duration(milliseconds: 300),
        () => ResultadoBusquedaSolicitudDTO(
            solicitud: SolicitudFirmanteDTO(
                app: 'BCD - Portal Tesorería',
                id: 876,
                firmante: 'Roberto Sanchez',
                ente: 'SISTEMAS DIGITALES S.A.',
                documento: 'Contrato de Bonos 2020'),
            hasResult: true),
      );
      _controller.sink.add(resultadoBusqueda);
      hasResult = true;
      hasFetched = true;
      solicitud = resultadoBusqueda.solicitud;
      callback(hasResult);
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

class SolicitudFirmanteDTO {
  String firmante;
  String ente;
  String documento;
  int id;
  String app;
  Image firma;
  Uint8List bytearray;

  SolicitudFirmanteDTO({
    this.app,
    this.documento,
    this.ente,
    this.firmante,
    this.id,
    this.firma,
    this.bytearray,
  });
}

class ResultadoBusquedaSolicitudDTO {
  SolicitudFirmanteDTO solicitud;
  bool hasResult;

  ResultadoBusquedaSolicitudDTO({
    this.solicitud,
    this.hasResult,
  });
}
