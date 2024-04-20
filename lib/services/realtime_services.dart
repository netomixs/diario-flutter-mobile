import 'dart:convert';
import 'package:diario/services/local_data_services.dart';
import 'package:firebase_database/firebase_database.dart';
// ignore: depend_on_referenced_packages

class RealTimeServices {
  static Future<bool> save(String route, Map<String, dynamic> jsonData) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(route);
      String jsonString = jsonEncode(jsonData);
      // print("guardando");

      await ref.set(jsonString);
      //  print("aa");
      return true;
    } catch (e) {
      //  print(e);
      return false;
    }
  }

  static Future<bool> crate(String route, Map<String, dynamic> jsonData) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(route);
      await ref.set(jsonData);
      return true;
    } catch (e) {
         print("----------------------");
      print(e);
      return false;
    }
  }

  static Future<bool> update(String route, Map<String, dynamic> jsonData) async {
    try {
      DatabaseReference ref = FirebaseDatabase.instance.ref(route);
      await ref.update(jsonData);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> load(String route) async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child(route).get();
      Map<String, dynamic> objecto;
      if (snapshot.exists) {
        objecto = jsonDecode(snapshot.value.toString());
        if (!route.contains("usuarios")) {
          await LocalDataServices.save(route, objecto);
        }

        return objecto;
      } else {
        // print('No data available.');
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  static Future<Map<dynamic, dynamic>?>? loadList(String route) async {
    Map<dynamic, dynamic> lista;

    try {
      DatabaseReference commentsRef = FirebaseDatabase.instance.ref(route);
      DatabaseEvent event = await commentsRef.once();
      lista = event.snapshot.value as Map<dynamic, dynamic>;

      return lista;
    } catch (e) {
      return null;
    }
  }

  static void removeData(String route) {
    DatabaseReference commentsRef =
        FirebaseDatabase.instance.ref().child(route);
    commentsRef.remove();
  }
}
