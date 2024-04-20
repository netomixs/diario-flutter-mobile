// ignore_for_file: depend_on_referenced_packages

import 'package:diario/controllers/data_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExperimentoController {
  static void creatExperimento(String nombre, DateTime fechaIncio) async {
    String? idUser = DataController.idUser();
    idUser ??= "";
    Experimento experimento = Experimento(
        id: getIdByDate(),
        inicio: DateTime.now(),
        usuario: idUser,
        nombre: nombre,
        listaHojaMediciones: [],
        listaParcelas: [],
        listaVariedades: []);
    await DataController.createExperimento(experimento);
  }

  static String getIdByDate() {
    //2022 12 04 13 34 20
    DateTime fechaHoraActual = DateTime.now();
    String idConFecha = "${fechaHoraActual.year}"
        "${_dosDigitos(fechaHoraActual.month)}"
        "${_dosDigitos(fechaHoraActual.day)}"
        "${_dosDigitos(fechaHoraActual.hour)}"
        "${_dosDigitos(fechaHoraActual.minute)}"
        "${_dosDigitos(fechaHoraActual.second)}";

    return idConFecha;
  }

  static String _dosDigitos(int numero) {
    return numero.toString().padLeft(2, '0');
  }

  static String dateFormat(DateTime? date) {
    String formattedDateTime = DateFormat('dd/MM/yyyy').format(date!);
    return formattedDateTime;
  }

  static Future<bool?> showConfirmationDeleteDialog(
      BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Eliminar elemento?'),
          content: const Text(
              'Al eliminar este elemento no se podra recuperar'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // No descartar cambios
              },
              child: const Text('Si'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Descartar cambios
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}
