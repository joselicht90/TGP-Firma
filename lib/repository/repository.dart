//CLASE PARA EL MANEJO DE OPERACIONES CRUD CONTRA API
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tgp_firma/bloc/shared_preferences/shared_preferences_bloc.dart';
import 'dart:convert';
import 'package:tgp_firma/repository/responses/login_response.dart';

class Repository {
  static Future<Object> signIn(String usuario, String password) async {
    var client = http.Client();
    try {
      var url =
          'http://192.168.128.21/TGP.API.Seguridad_desa/api/mobile/loginmobile';
      dynamic responseJson = await client.post(url, body: {
        "NombreUsuario": usuario.trim(),
        "Contrasena": password.trim(),
        "CodigoEstructuraFuncional": "BON"
      });
      LoginResponse response =
          LoginResponse.fromJson(json.decode(responseJson.body));
      if (response.siValido) {
        SharedPreferencesBloc.setToken(
          response.tokenSession,
          DateFormat('dd/MM/yyyy hh:mm:ss')
              .format(response.fechaExpiracionToken),
        );
        return response;
      } else {
        throw (new Exception(
            "Codigo: ${response.codigo}.\r\n${response.mensaje}"));
      }
    } catch (e) {
      throw (e);
    }
  }
}
