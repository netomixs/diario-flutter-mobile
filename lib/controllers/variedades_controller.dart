import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Variedades.dart';
import 'package:flutter/material.dart';

class VariedadController {
  static Variedades createVariedad(
      {required String tratamiento,
      required String fase,
      required String campo,
      required Color color,
      required int id}) {
    //2022 12 04 13 44 22 11

    String idVeriedad = VariedadController.getIdVariedad(id);
    String colorHex =
        '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';

    Variedades variedad = Variedades(
        id: idVeriedad,
        fase: fase,
        campo: campo,
        color: colorHex,
        tratamiento: tratamiento);
    return variedad;
  }

  static List<dynamic> deleteVariedad(
      List<Variedades> list, int index, Experimento experimento) {
    list.removeAt(index);
    for (var i = 0; i < list.length; i++) {
      if (list[i].id == experimento.variedadTestigo) {
        list[i].id = getIdVariedad(i+1);
        experimento.variedadTestigo = list[i].id;
      } else {
        list[i].id = getIdVariedad(i+1);
      }
    }
    List<dynamic> result = [list, experimento.variedadTestigo];

    return result;
  }

  static String getIdVariedad(int index) {
    String numeroFormateado = index.toString().padLeft(2, '0');
    String idVeriedad = ExperimentoController.getIdByDate() + numeroFormateado;
    return idVeriedad;
  }

  static Variedades updateVariedad(
      {required String tratamiento,
      required String fase,
      required String campo,
      required Color color,
      required String id}) {
    //2022 12 04 13 44 22 11

    String colorHex =
        '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase().substring(2)}';

    Variedades variedad = Variedades(
        tratamiento: tratamiento,
        fase: fase,
        campo: campo,
        color: colorHex,
        id: id);
    return variedad;
  }

  static Experimento setTestigo(String idTestigo, Experimento experimento) {
    if (experimento.variedadTestigo.isEmpty) {
      experimento.variedadTestigo = idTestigo;
    } else {}
    return experimento;
  }

  static Experimento deleteTestigo(Experimento experimento) {
    experimento.variedadTestigo = "";
    return experimento;
  }

  static int identifyTestigo(List<Variedades> lista, Experimento experimento) {
    for (var i = 0; i < lista.length; i++) {
      if (lista[i].id == experimento.variedadTestigo) {
        return i;
      }
    }
    return -1;
  }

  static bool isTestigo(Experimento experimento, Variedades variedades) {
    if (experimento.variedadTestigo == variedades.id) {
      return true;
    }
    return false;
  }

  static void variedadAlready(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ya existe una variedad testigo'),
          content: const Text(
              'Para cambiar la variedad testigo actual elimine la anterior'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  static void saveConfirmDialog(
      {required Experimento experimento,
      required List<Variedades> lista,
      required BuildContext context}) {
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
                VariedadController.saveExperimento(
                    experimento: experimento, lista: lista);
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(experimento); // Cierra el cuadro de diálogo
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el cuadro de diálogo
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  static saveExperimento(
      {required Experimento experimento, required List<Variedades> lista}) {
    experimento.listaVariedades = lista;
    experimento.numeroVariedades = lista.length;

    DataController.saveExperimento(experimento);
  }
}
