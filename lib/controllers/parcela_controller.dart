// ignore_for_file: file_names


import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Parcela.dart';
import 'package:flutter/material.dart';

class ParcelaController {
  static List<Parcela> createParcelaList(Experimento experimento) {
    // /2022 12 04 13 45 R107
    int numRepeticiones = 4;
    
    List<Parcela> listaParcelas = [];
    for (var i = 0; i < numRepeticiones; i++) {
      for (var j = 0; j < experimento.listaVariedades!.length; j++) {
        Parcela parcela = Parcela(
            id: _getIdParcela(index: j, repeticion: i + 1),
            variedad: experimento.listaVariedades![j].id,
            numero: j+1,
            usuario: experimento.usuario,
            posicion: j,
            repeticion: i + 1,
            editable: true);
        listaParcelas.add(parcela);
      }
    }
    return listaParcelas;
  }

  static String _getIdParcela({required int repeticion, required int index}) {
    String idParcela = "";
     String numeroFormateado = index.toString().padLeft(2, '0');
    String idDate = ExperimentoController.getIdByDate();
    idParcela = "$idDate${"R"}$repeticion$numeroFormateado";
    return idParcela;
  }

  static Future<void> saveParcela(
      {required List<Parcela> list1,
      required List<Parcela> list2,
      required List<Parcela> list3,
      required List<Parcela> list4,
      required Experimento experimento}) async {
    List<Parcela> list = list1 + list2 + list3 + list4;
    experimento.listaParcelas = list;
    await DataController.saveExperimento(experimento);
  }

  static Color hexToColor(String hexString) {
    String cleanHex = hexString.replaceAll("#", "");
    int colorInt = int.parse(cleanHex, radix: 16);
    return Color(colorInt).withOpacity(1.0);
  }

  static Future<bool?> showDiscardConfirmationDialog(
      BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Descartar cambios?'),
          content: const Text(
              'Hay datos sin guardar. ¿Desea descartar los cambios?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No descartar cambios
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Descartar cambios
              },
              child: const Text('Descartar'),
            ),
          ],
          
        );
      },
      
    );
  }
  

  static bool saveConfirmDialog({required BuildContext context}) {
    bool confirm =false;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Desea guardar?'),
          content:
              const Text('Al guardar ya no podra modificar las variedades'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                confirm=true;
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
                confirm=false;
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
    return confirm;
  }

  static bool isSetect(
      {required int repeticion,
      required int index,
      required List<int> itemsSelect}) {
    if (itemsSelect.isEmpty) {
      return false;
    } else {
      if (repeticion == itemsSelect[0]) {
        if (itemsSelect[1] == index) {
          return true;
        }
        if (itemsSelect.length == 3) {
          if (itemsSelect[2] == index) {
            return true;
          } else {
            return false;
          }
        } else {
          return false;
        }
      } else {
        return false;
      }
    }
  }
}
