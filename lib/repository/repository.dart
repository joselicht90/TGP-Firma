//CLASE PARA EL MANEJO DE OPERACIONES CRUD CONTRA API
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tgp_firma/repository/responses/login_response.dart';

class Repository {
  static String _token;

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
        _token = response.tokenSession;
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
