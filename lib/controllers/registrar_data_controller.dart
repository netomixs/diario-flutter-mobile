import 'package:diario/controllers/data_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/models/Registro.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class RegistrarDataContoller {
  double totalTallos = 0;
  double promedioTallos = 0;
  double promedioSurcos = 0;
  double totalSurcos = 0;
  int index = -1;
  List<Registro> listaRegistros = [];
  Registro registroActual = Registro();
  Experimento experimento = Experimento();
  HojaMedicion hojaMedicion = HojaMedicion();
  Parcela parcela = Parcela();
  RegistrarDataContoller(
      {required HojaMedicion hoja,
      required Parcela parcel,
      required Experimento experiment}) {
    parcela = parcel;
    experimento = experiment;
    hojaMedicion = hoja;
    listaRegistros = hojaMedicion.listaRegistros!;
    index = parcela.posicion +
        (experimento.numeroVariedades * (parcela.repeticion - 1));
    registroActual = listaRegistros[index];
  }
  void setRegistros(
      {required TextEditingController surco3Text,
      required TextEditingController surco4Text,
      required List<TextEditingController> list,
      required Registro registro}) {
    try {
      totalTallos = 0;
      registro.completado = true;
      registro.listaSurcos![0].cantidad_tallos = int.parse(surco3Text.text);
      registro.listaSurcos![1].cantidad_tallos = int.parse(surco4Text.text);
      registro.parcela = parcela.id;
      totalSurcos = (registro.listaSurcos![0].cantidad_tallos +
              registro.listaSurcos![1].cantidad_tallos)
          .toDouble();
      for (var i = 0; i < 5; i++) {
        registro.listaSurcos![0].tallosLista![i].medida =
            int.parse(list[i].text);
        totalTallos =
            totalTallos + registro.listaSurcos![0].tallosLista![i].medida;
      }
      for (var i = 0; i < 5; i++) {
        registro.listaSurcos![1].tallosLista![i].medida =
            int.parse(list[i + 5].text);
        totalTallos =
            totalTallos + registro.listaSurcos![1].tallosLista![i].medida;
      }
      promedioSurcos = totalSurcos / 2;
      promedioTallos = totalTallos / 10;
      registro.promedio = promedioTallos;
      hojaMedicion.listaRegistros![index] = registro;
    // ignore: empty_catches
    } catch (e) {}
  }

  Registro getDataOld() {
    return registroActual;
  }

  Future<void> saveHoja() async {
    String? idUser = experimento.usuario;
    String? idExperimento = experimento.id;
    String route = "$idUser/experimentos/$idExperimento";
    hojaMedicion.listaRegistros![index].completado = true;
    await DataController.saveHojaNedicion(hojaMedicion, route);
  }

  double getPromedio(int element, double total) {
    double promedio = total / element;
    return promedio;
  }

  static String formatNumber(double number) {
    String numeroFormateado = NumberFormat("#,##0.0#", "es").format(number);
    return numeroFormateado;
  }

  String getIdTallo(String id, int index) {
    String numeroFormateado = index.toString().padLeft(2, '0');
    id = id + numeroFormateado;
    return id;
  }
}
