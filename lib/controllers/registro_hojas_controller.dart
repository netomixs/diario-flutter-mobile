import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/models/Registro.dart';
import 'package:diario/models/Surco.dart';
import 'package:diario/models/Tallo.dart';
import 'package:diario/widgets/input_text.dart';
import 'package:flutter/material.dart';

class RegistroHojasController {
   
  int index = -1;
  List<Registro> listaRegistros = [];
  Registro registroActual = Registro();
  Experimento experimento = Experimento();
  Parcela parcela = Parcela();
  // ignore: non_constant_identifier_names
  RegistroController(
      List<Registro> lista, Parcela parcel, Experimento experiment) {
    parcela = parcel;
    experimento = experiment;
    listaRegistros = lista;
    index = parcela.posicion +
        (experimento.numeroVariedades * (parcela.repeticion - 1));
    registroActual = listaRegistros[index];
  }
  static createHojaRegistro(Experimento experimento, int mes) {
    //2022 12 05 11 33 26
    String idHoja = ExperimentoController.getIdByDate();
 
    List<Registro> registrosList = [];
    HojaMedicion hoja = HojaMedicion(
        id: idHoja,
        fechaCreacion: DateTime.now(),
        mesCrecimiento: mes,
        experimento: experimento.id,
        sincronizado: false,
        listaRegistros: registrosList);
    hoja.listaRegistros = RegistroHojasController.createRegistro(experimento);
    experimento.listaHojaMediciones?.add(hoja);

    DataController.saveExperimento(experimento);
  }

  static List<Registro> createRegistro(Experimento experimento) {
    List<Registro> lista = [];
    for (var i = 0; i < (4 * experimento.numeroVariedades); i++) {
      Registro registro = Registro();
      List<Surco> surco = [];
      String idSurco3 = ExperimentoController.getIdByDate();

      idSurco3 = "${idSurco3}3";
      Surco surco3 = Surco(
          id: idSurco3, numero_surco: 3, cantidad_tallos: 0, tallosLista: []);
      for (var i = 0; i < 5; i++) {
        Tallo tallo = Tallo(
            id: getIdTallo(idSurco3, i + 1), numero_tallo: i + 1, medida: 0);
        surco3.tallosLista!.add(tallo);
      }
      String idSurco4 = ExperimentoController.getIdByDate();

      idSurco4 = "${idSurco4}4";
      Surco surco4 = Surco(
          id: idSurco4, numero_surco: 4, cantidad_tallos: 0, tallosLista: []);
      for (var i = 0; i < 5; i++) {
        Tallo tallo = Tallo(
            id: getIdTallo(idSurco3, i + 1), numero_tallo: i + 1, medida: 0);
        surco4.tallosLista!.add(tallo);
      }
      surco.add(surco3);
      surco.add(surco4);
      registro.listaSurcos = surco;
      lista.add(registro);
    }
    return lista;
  }

 static String getIdTallo(String id, int index) {
    String numeroFormateado = index.toString().padLeft(2, '0');
    id = id + numeroFormateado;
    return id;
  }

  static Future<bool> showInputDialog(
      BuildContext context, Experimento experimento) async {
    // ignore: no_leading_underscores_for_local_identifiers
    TextEditingController _textEditingController = TextEditingController();
    bool completado = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Nueva Hoja de registro'),
          content: InputText(
            hintText: "Mes de crecimiento",
            controller: _textEditingController,
            label: "Mes de crecimiento",
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (_textEditingController.text.isNotEmpty) {
                  int mes = int.parse(_textEditingController.text);
                  RegistroHojasController.createHojaRegistro(experimento, mes);

                  completado = true;
                }
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
    return completado;
  }

  static double getCompletPArcelas(HojaMedicion hoja, int variedades) {
    int totalParcelas = variedades * 4;
    int completado = 0;
    if (hoja.listaRegistros != null) {
      for (var i = 0; i < hoja.listaRegistros!.length; i++) {
        if (hoja.listaRegistros![completado].completado) {
          completado++;
        }
      }
    }

    double result = completado / totalParcelas;
    return result;
  }
}
