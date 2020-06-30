import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesBloc {
  static void setToken(String token, String fechaExpiracion) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    await prefs.setString('fechaExpiracion', fechaExpiracion);
  }

  static Future<String> getToken() {
    return SharedPreferences.getInstance().then((prefs) async {
      if (prefs.containsKey('token') && prefs.containsKey('fechaExpiracion')) {
        DateTime fechaExpiracion = DateFormat("dd/MM/yyyy hh:mm:ss").parse(
          prefs.getString('fechaExpiracion'),
        );
        if (fechaExpiracion.isBefore(DateTime.now())) {
          await SharedPreferences.getInstance().then((prefs) {
            prefs.clear();
          });
          return null;
        }
        return prefs.getString('token');
      }
      return null;
    });
  }

  static Future<void> logOut() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.clear();
    });
  }
}
