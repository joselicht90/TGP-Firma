//CLASE PARA EL MANEJO DE OPERACIONES CRUD CONTRA FIRESTORE
class Repository {
  static Future<String> signIn(String email, String password) async {
    try {
      return Future.delayed(Duration(seconds: 3), () => "jlicht");
    } catch (e) {
      
      throw (e);
    }
  }
}