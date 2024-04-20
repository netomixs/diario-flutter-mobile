// ignore_for_file: depend_on_referenced_packages

import 'package:sembast/sembast.dart';

import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class LocalDataServices {
  ///Guardar datos localmente
  ///Obtiene ruta de store String  y Map<String, dynamic> del objeto a guardar
  static Future<bool> save(
    String ruta,
    Map<String, dynamic> jsonData,
  ) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String rutaCompleta = '${appDocDir.path}/$ruta';
     // String nombreArchivo = path.basename(rutaCompleta);
      String directorioPadre = path.dirname(rutaCompleta);

      Directory(directorioPadre)
          .createSync(recursive: true); // Crea las carpetas si no existen

      final dbFactory = databaseFactoryIo;
      final db = await dbFactory.openDatabase(rutaCompleta);

      final store = stringMapStoreFactory.store("data");
      await store
          .record("0")
          .put(db, jsonData); // Guardar el registro en el almacén

      await db.close(); // Cerrar la base de datos cuando hayas terminado

      return true;
    } catch (e) {
     // print(e);
      return false;
    }
  }

  static Future<Map<String, dynamic>?> load(String ruta) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      // ignore: prefer_interpolation_to_compose_strings
      String dbPath = appDocDir.path + '/' + ruta + ".db";

      final dbFactory = databaseFactoryIo;
      final db = await dbFactory.openDatabase(dbPath);

      // Obtener la tienda
      final store = stringMapStoreFactory.store("data");

      // Cargar los datos y decodificarlos
      final record = await store.record("0").get(db);
      if (record == null) {
        return null;
      } else {
        Map<String, dynamic> jsonObject = record;
        return jsonObject;
      }
    } catch (e) {
    //  print(e);
      return null;
    }
  }

  static Future<Map<dynamic, dynamic>?> loadList(String ruta) async {
    try {
    //  Directory appDocDir = await getApplicationDocumentsDirectory();
      //String dbPath = '${appDocDir.path}/$ruta';

      //final dbFactory = databaseFactoryIo;
      //final db = await dbFactory.openDatabase(dbPath);
      var listString = await findDbFiles(ruta);
      List<Map<dynamic, dynamic>> result = [];
      for (var element in listString) {
        var i = await load(element.path);
        result.add(i!);
      }
      var recordsMap = convertListToMap(result);
      return recordsMap;
    } catch (e) {
     // print(e);
      return null;
    }
  }

  static Future<void> removeData(String tabla, String id) async {
    try {
      final dbFactory = databaseFactoryIo;
      final db = await dbFactory.openDatabase('database.db');
      // Obtener la tienda
      final store = stringMapStoreFactory.store(tabla);
      // Eliminar el registro
      await store.record(id).delete(db);
    } catch (e) {
      // Manejar el error si es necesario
    }
  }

  static Future<void> deleteDatabaseFile() async {
    final dbFactory = databaseFactoryIo;

    // Eliminar la base de datos
    await dbFactory.deleteDatabase('database.db');
  }

  static Map<dynamic, dynamic> convertListToMap(
      List<Map<dynamic, dynamic>> list) {
    final resultMap = <dynamic, dynamic>{};

    for (var map in list) {
      resultMap.addAll(map);
    }
    return resultMap;
  }

  static Future<List<File>> findDbFiles(String ruta) async {
    final directory = Directory(ruta);
    final allFiles = directory.listSync(recursive: true);
    List<File> dbFiles = [];
    for (final file in allFiles) {
      if (file is File && file.path.endsWith('.db')) {
        final containingFolder = file.parent.uri.pathSegments.last;
        if (containingFolder != 'HojasRegistros') {
          dbFiles.add(file);
        }
      }
    }
    return dbFiles;
  }
}
