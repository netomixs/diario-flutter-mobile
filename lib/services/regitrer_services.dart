import 'package:diario/controllers/data_controller.dart';
import 'package:diario/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
 

class RegistrerServices {
  static Future<String?> sigInnWhithEmailPassword({
    required String email,
    required String password,
    // ignore: avoid_types_as_parameter_names
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      List<String> signInMethods = await auth.fetchSignInMethodsForEmail(email);

      if (signInMethods.isNotEmpty) {
        auth.signOut();
        return "user-exist";
      }
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;

      String? id = user?.uid;

      auth.signOut();
      return id;
    } on FirebaseAuthException catch (e) {
      // print("Code errororjmewin "+ e.code);
      return "ERROR${e.code}";
    }
  }

  static Future<String> createUser(String name, String lastName,
      String? matherName, String email, String password) async {
    String? result =
        await sigInnWhithEmailPassword(email: email, password: password);

    try {
      if (result == "user-exist") {
        return "user-exist";
      } else if (result!.startsWith("ERROR")) {
        return "ERROR";
      } else {
        //print("Creando usuario otra vez");
        String id = email.replaceAll(".", "_");

        Usuario usuario = Usuario(name, lastName, lastName, email, id);
        DataController.saveUser(usuario);
        // await ref.set(usuario);
        return "OK";
      }
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }
}
