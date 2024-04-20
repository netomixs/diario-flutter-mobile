import 'package:diario/services/regitrer_services.dart';

import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/alert_windows.dart';

///Controlador de elementos para el registro de usuarios
class RegistrerUserController {
  ///Validacion de campos vacios
  static bool isEmpatyField(String text) {
    if (text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  ///Controlador de validacion del campo nombre
  static String? nameFieldValidation(String? text) {
    final nameExp = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s'-]+$");
    if (isEmpatyField(text!)) {
      return "Completa este campo";
    }
    text = text.trim();
    if (!nameExp.hasMatch(text)) {
      return 'Ingresa un nombre válido';
    }
    return null;
  }

  ///Validacion del campo de apellido paterno
  static String? lastNameFieldValidation(String? text) {
    final nameExp = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s'-]+$");
    if (isEmpatyField(text!)) {
      return "Completa este campo";
    }
    text = text.trim();
    if (!nameExp.hasMatch(text)) {
      return 'Ingresa un nombre válido';
    }
    return null;
  }

  /// validacion del campo de apellido materno
  static String? lastName2FieldValidation(String? text) {
    final nameExp = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s'-]+$");

    text = text?.trim();
    if (text == "") {
      return null;
    }
    if (!nameExp.hasMatch(text!)) {
      return 'Ingresa un nombre válido';
    }
    return null;
  }

  ///validfacion del campo de correo
  static String? emailFieldCValidation(String? text) {
    if (isEmpatyField(text!)) {
      return "Completa este campo";
    }
    text = text.trim();
    final emailExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailExp.hasMatch(text)) {
      return 'Ingresa un correo electrónico válido';
    }

    return null;
  }

  static String? passwordFieldValidation(String? text) {
    if (isEmpatyField(text!)) {
      return "Completa este campo";
    }
    text = text.trim();
    if (text.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? password2FieldValidation(String? text, String? text2) {
    if (isEmpatyField(text!)) {
      return "Completa este campo";
    }
    if (text == text2) {
    } else {
      return "Las contraseñas no coinciden";
    }

    return null;
  }

  static void loginChanller(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  static Future<String> registreUser(String name, String lastName,
      String? matherName, String email, String password, context) async {
    String? result = await RegistrerServices.createUser(
        name, lastName, matherName, email, password);
    print(result);
    return result;
  }
}
