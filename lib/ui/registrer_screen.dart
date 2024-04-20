import 'package:flutter/material.dart';

import '../controllers/registrer_user_controller.dart';
import '../utils/app_color.dart';
import '../widgets/alert_windows.dart';
import '../widgets/input_password.dart';
import '../widgets/input_text.dart';
import '../widgets/principal_button.dart';
import '../widgets/text_button_simple.dart';

class Registre extends StatefulWidget {
  const Registre({super.key});

  @override
  State<Registre> createState() => _RegistreState();
}

class _RegistreState extends State<Registre> {
  var focus = List<FocusNode>.filled(6, FocusNode());
  final formKey = GlobalKey<FormState>();
  var infoErrorFiedl = List.filled(6, null);
  var field = List.filled(6, TextEditingController());
  bool isLoadRegistre = false;
  @override
  void initState() {
    for (int i = 0; i < focus.length; i++) {
      focus[i] = FocusNode();
    }
    for (int i = 0; i < focus.length; i++) {
      field[i] = TextEditingController();
    }
    super.initState();
  }

  @override
  void dispose() {
    for (var i in focus) {
      i.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 40, left: 40, right: 40, bottom: 5),
                //padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  //  color: AppColors.backColor,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Titulo
                      Container(
                        margin: const EdgeInsets.only(
                            top: 0, bottom: 10, right: 10, left: 10),
                        child: const Text(
                          "Nueva cuenta",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Form(
                          key: formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InputText(
                                hintText: "Nombre",
                                keyboardType: TextInputType.name,
                                icon: Icons.person,
                                focusNode: focus[0],
                                onEditingComplete: () {
                                  InputText.nextFocus(focus, 0, 1, context);
                                },
                                validator: (value) {
                                  return RegistrerUserController
                                      .nameFieldValidation(value);
                                },
                                controller: field[0],
                                erroText: infoErrorFiedl[0],
                              ),
                              //Campo apellido paterno
                              InputText(
                                hintText: "Apellido Paterno",
                                keyboardType: TextInputType.name,
                                icon: Icons.person,
                                focusNode: focus[1],
                                onEditingComplete: () {
                                  InputText.nextFocus(focus, 1, 2, context);
                                },
                                validator: (value) {
                                  return RegistrerUserController
                                      .lastNameFieldValidation(value);
                                },
                                controller: field[1],
                                erroText: infoErrorFiedl[1],
                              ),
                              //Campo apellido materno
                              InputText(
                                hintText: "Apellido Materno",
                                keyboardType: TextInputType.name,
                                icon: Icons.person,
                                focusNode: focus[2],
                                onEditingComplete: () {
                                  InputText.nextFocus(focus, 2, 3, context);
                                },
                                validator: (value) {
                                  return RegistrerUserController
                                      .lastName2FieldValidation(value);
                                },
                                controller: field[2],
                                erroText: infoErrorFiedl[2],
                              ),
                              //Campo correo
                              InputText(
                                hintText: "Correo",
                                keyboardType: TextInputType.emailAddress,
                                icon: Icons.email,
                                focusNode: focus[3],
                                onEditingComplete: () {
                                  InputText.nextFocus(focus, 3, 4, context);
                                },
                                validator: (value) {
                                  return RegistrerUserController
                                      .emailFieldCValidation(value);
                                },
                                controller: field[3],
                                erroText: infoErrorFiedl[3],
                              ),
                              // contrasea
                              InputPassword(
                                hintText: "Contraseña",
                                icon: Icons.password,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: focus[4],
                                onEditingComplete: () {
                                  InputText.nextFocus(focus, 4, 5, context);
                                },
                                validator: (value) {
                                  return RegistrerUserController
                                      .passwordFieldValidation(value);
                                },
                                controller: field[4],
                                errorText: infoErrorFiedl[4],
                              ),
                              //campo repite contrasea
                              InputPassword(
                                hintText: "Confirma Contraseña",
                                icon: Icons.password,
                                keyboardType: TextInputType.visiblePassword,
                                focusNode: focus[5],
                                controller: field[5],
                                validator: (value) {
                                  return RegistrerUserController
                                      .password2FieldValidation(
                                          value, field[4].text);
                                },
                                errorText: infoErrorFiedl[5],
                              ),

                              //Boton registrar
                              PrincipalButton(
                                  isload: isLoadRegistre,
                                  text: "Registrarse",
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      isLoadRegistre = true;
                                      /*  ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                      const SnackBar(
                                            content: Text('Procesando')),
                                      );*/
                                      var result = await RegistrerUserController
                                              .registreUser(
                                                  field[0].text,
                                                  field[1].text,
                                                  field[2].text,
                                                  field[3].text,
                                                  field[4].text,
                                                  context)
                                          .whenComplete(()=>
                                              isLoadRegistre = false);

                                      if (result == "OK") {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertWindow(
                                                title: 'Registro completo',
                                                message:
                                                    'Revise su correo para mas instrucciones',
                                                onConfirm: () {
                                                  print("Hola mundo");
                                                  RegistrerUserController
                                                      .loginChanller(context);
                                                },
                                              );
                                            });
                                      } else if (result == "user-exist") {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertWindow(
                                                title: 'Usuario ya existe',
                                                message:
                                                    'El usuario ya esta registrado',
                                                onConfirm: () {},
                                              );
                                            });
                                      } else if (result == "invalid-email") {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertWindow(
                                                title: 'Correo no valido',
                                                message:
                                                    'El correo no es valido intente otro',
                                                onConfirm: () {},
                                              );
                                            });
                                      } else {
                                        // ignore: use_build_context_synchronously
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertWindow(
                                                title: 'Ocurrió un error',
                                                message:
                                                    'No fue posible el registro.\nIntentelo mas tarde',
                                                onConfirm: () {},
                                              );
                                            });
                                      }
                                    }
                                  }),
                            ],
                          )),

                      TextButtonSimple(
                        text: "Ya tengo una cuenta",
                        onPressed: () {
                          RegistrerUserController.loginChanller(context);
                        },
                        margin: const EdgeInsets.only(right: 10),
                        align: MainAxisAlignment.center,
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
