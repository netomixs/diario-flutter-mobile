import 'package:diario/services/login_services.dart';

import 'package:diario/widgets/alert_windows.dart';
import 'package:flutter/material.dart';

class LoginController {
  ///Realiza el procedimiento de login
  ///Envia diferentes mensajes dependiendo del error
  ///Si el login es exitoso cambia a la pantalla de menu principal
  static Future<AlertWindow?> loginUser(
      String email, String password, BuildContext context) async {
    String result = await LoginServices.loginWhithEmailPassword(
        email: email, password: password);
    switch (result) {
      case "OK":
        return null;

      case "non-verification":
        //print("No validado");
        return AlertWindow(
          title: 'Verificaión',
          message: 'Usuario no verificado.',
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );
      case "user-not-found":
        //print("No encontrado");
        return AlertWindow(
          title: 'Usuario no registrado',
          message:
              'Las credenciales usadas no pertenecen a ningun usuario registrado',
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );
      case "invalid-email":
        return AlertWindow(
          title: 'Correo no valido',
          message:
              'El correo proporcionado no tiene un formato valido',
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );
      case "error":
        // print("Error de conexion");
        return AlertWindow(
          title: 'Error',
          message: 'Ocurrió un error en la conexión con las base de datos',
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );

      case "wrong-password":
        return AlertWindow(
          title: 'Contraseña',
          message: 'La contraseñá no coincide con la cuenta actual',
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );

      default:
        return AlertWindow(
          title: 'Error',
          message: "Ocurrió un error inesperado",
          onConfirm: () {
            // Lógica para confirmar la acción
          },
        );
    }
  }

  ///Control de accion al dar enter sobre el campo email
  ///Pasa inmediatamente al campo password
  static void enterEmailFocus(
      FocusNode email, FocusNode password, BuildContext context) {
    email.unfocus();
    FocusScope.of(context).requestFocus(password);
  }

  ///LLama al metodo que cambia al menu principal si esta logueado
  static void isLogged(BuildContext context) {
    LoginServices.isLogged(context);
  }

  ///Consulta al servicion de login si hay un usuario logueado
  static bool isLogIn(BuildContext context) {
    return LoginServices.isLogIn(context);
  }

  ///Termina la sesion acutal llamando al servcio de Login
  static void logOut(BuildContext context) {
    LoginServices.logOut(context);
  }
static Future<void> setRecoveryPasswordNotification(String email){
  return LoginServices.setRecoveryPasswordNotification(email);
}
  static void registrerChanller(context) {}
}
