import 'package:intl/intl.dart';

class LoginResponse {
  final String codigo;
  final String mensaje;
  final String idUsuario;
  final String descripcion;
  final bool siValido;
  final String tokenSession;
  final DateTime fechaExpiracionToken;
  //final bool esAcreedor;
  // final String cuit;
  // final String razonSocial;

  LoginResponse(
    this.codigo,
    this.mensaje,
    this.idUsuario,
    this.descripcion,
    this.siValido,
    this.tokenSession,
    this.fechaExpiracionToken,
    // , this.cuit, this.razonSocial,this.esAcreedor
  );

  LoginResponse.fromJson(Map<String, dynamic> json)
      : codigo = json['Codigo'],
        mensaje = json['Mensaje'],
        idUsuario = json['UsuarioID'],
        descripcion = json['Descripcion'],
        siValido = json['SiValido'] == 'true' ? true : false,
        tokenSession = json['TokenSession'],
        fechaExpiracionToken = json['FechaExpiracionTokenSession'] != null
            ? DateFormat("dd/MM/yyyy hh:mm:ss")
                .parse(json['FechaExpiracionTokenSession'])
            : null;
}
