import 'dart:convert';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Usuario.dart';
import 'package:diario/services/local_data_services.dart';
import 'package:diario/services/login_services.dart';
import 'package:diario/services/realtime_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataController {
  static Future<bool> saveUser(Usuario usuario) async {
    try {
      Map<String, dynamic> jsonData = usuario.toJson();
      String? id = usuario.id;
      if (await RealTimeServices.save("usuarios/$id", jsonData)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<Usuario> loadUser() async {
    try {
      String? id = DataController.idUser();

      Map<String, dynamic>? object =
          await RealTimeServices.load("usuarios/$id/");
      Usuario usuario = Usuario.fromJson(object!);

      return usuario;
    } catch (e) {
      return Usuario("", "", "", "", "");
    }
  }

  static Future<bool> createExperimento(Experimento experimento) async {
    try {
      String? idExperimento = experimento.id;
          String? idUser = experimento.usuario;
      String route = "data/$idUser/experimentos/$idExperimento";
      Map<String, dynamic> jsonData = experimento.toJson();
      var response = await RealTimeServices.crate(route, jsonData);
      if (response) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<bool> saveExperimento(Experimento experimento) async {
    try {
      List<HojaMedicion>? listaHojaMediciones = experimento.listaHojaMediciones;
      experimento.listaHojaMediciones = [];
      Map<String, dynamic> jsonData = experimento.toJson();
      String? idUser = experimento.usuario;
      String? idExperimento = experimento.id;
      String route = "$idUser/experimentos/$idExperimento";
      if (await RealTimeServices.save("$route/experimento", jsonData)) {
        for (var element in listaHojaMediciones!) {
          saveHojaNedicion(element, route);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<void> saveHojaNedicion(HojaMedicion hoja, String route) async {
    try {
      Map<String, dynamic> jsonData = hoja.toJson();
      String? idHoja = hoja.id;
      await RealTimeServices.save("$route/HojaRegistros/$idHoja", jsonData);
      // print("$route/HojaRegistros/$idHoja");
    } catch (e) {
      // print(e);
    }
  }

  static Future<bool> deleteExperimento(Experimento experimento) async {
    try {
      String? idUser = experimento.usuario;
      String? idExperimento = experimento.id;
      String route = "$idUser/experimentos/$idExperimento";
      RealTimeServices.removeData(route);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteHoajeregistro(
      Experimento experimento, HojaMedicion hoja) async {
    try {
      String? idUser = experimento.usuario;
      String? idExperimento = experimento.id;
      String? idHoja = hoja.id;
      String route =
          "$idUser/experimentos/$idExperimento/HojaRegistros/$idHoja";
      RealTimeServices.removeData(route);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<List<HojaMedicion>> getHojasMedicion(
      Experimento experimento) async {
    List<HojaMedicion> lista = [];
    try {
      String? userID = idUser();
      Map<dynamic, dynamic>? data = await RealTimeServices.loadList(
          "$userID/experimentos/${experimento.id}/HojaRegistros");

      if (data != null) {
        for (var registroElemento in data.keys) {
          HojaMedicion hojaMedicion =
              HojaMedicion.fromJson(json.decode(data[registroElemento]));
          lista.add(hojaMedicion);
        }
      }
    } catch (e) {
      // print(e);
    }
    if (lista.isNotEmpty) {
      lista = ordenarPorMesCrecimiento(lista);
    }

    return lista;
  }

  static saveLocal(List<Experimento> lista) {
    for (var experimento in lista) {
      List<HojaMedicion>? listaHojaMediciones = experimento.listaHojaMediciones;
      experimento.listaHojaMediciones = [];
      Map<String, dynamic> jsonData = experimento.toJson();
      String? idUser = experimento.usuario;
      String? idExperimento = experimento.id;
      String route = "$idUser/experimentos/$idExperimento";
      LocalDataServices.save(route, jsonData);
      for (var element in listaHojaMediciones!) {
        Map<String, dynamic> jsonDataHoja = element.toJson();
        String? idHoja = element.id;
        LocalDataServices.save("$route/HojaRegistros/$idHoja", jsonDataHoja);
      }
    }
  }

  static Future<List<Experimento>> getExperimentos() async {
    List<Experimento> listaExperimento = [];
    try {
      String? userID = idUser();
      Map<dynamic, dynamic>? data =
          await RealTimeServices.loadList("data/$userID/experimentos");
      for (var experimentoElement in data!.keys) {
        Map<dynamic, dynamic> jsonData = data[experimentoElement];
        Experimento experimento =
            Experimento.fromJson(json.decode(jsonData["experimento"]));
        List<HojaMedicion> listaHojaMediciones = [];

        if (jsonData["HojaRegistros"] != null) {
          Map<dynamic, dynamic> jsonRegistroData = jsonData["HojaRegistros"];
          for (var registroElemento in jsonRegistroData.keys) {
            HojaMedicion hojaMedicion = HojaMedicion.fromJson(
                json.decode(jsonRegistroData[registroElemento]));

            listaHojaMediciones.add(hojaMedicion);
          }
          listaHojaMediciones = ordenarPorMesCrecimiento(listaHojaMediciones);
          experimento.listaHojaMediciones = listaHojaMediciones;
        }
        // print(experimento.nombre);

        listaExperimento.add(experimento);
      }
      if (listaExperimento.isNotEmpty) {
        listaExperimento = ordenarPorId(listaExperimento);
      }
      // saveLocal(listaExperimento);
      return listaExperimento;
    } catch (e) {
      //  print("Lista");
      //   print(e);
      return listaExperimento;
    }
  }

  static List<HojaMedicion> ordenarPorMesCrecimiento(
      List<HojaMedicion> listaHojaMediciones) {
    listaHojaMediciones
        .sort((a, b) => a.mesCrecimiento.compareTo(b.mesCrecimiento));
    return listaHojaMediciones;
  }

  static List<Experimento> ordenarPorId(List<Experimento> listaExperimentos) {
    listaExperimentos.sort((a, b) => a.id.compareTo(b.id));
    return listaExperimentos;
  }

  static String? idUser() {
    User? user = LoginServices.getUser();
    String? email = user?.email;
    String? id = email?.replaceAll(".", "_");
    return id;
  }
}


  // static List<Experimento> loadExperimento(String iduser) async {
  //   try {
  //      List<Experimento> lista;

  //   } catch (e) {}
  // }

