import 'package:diario/controllers/data_controller.dart';

import 'package:diario/models/Usuario.dart';

import 'package:flutter/material.dart';

class PErfilUserController {
  static Future<bool> saveDataUser(
      List<TextEditingController> lista, Usuario usuario) async {
    usuario.nombre = lista[0].text;
    usuario.apellidoP = lista[1].text;
    usuario.apellidoM = lista[2].text;
    bool isComplete = await DataController.saveUser(usuario);
    return isComplete;
  }

  static void messenge(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title:  Text(title),
            content:  Text(content),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        });
  }
}
