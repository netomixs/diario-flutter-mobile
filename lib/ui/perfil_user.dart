import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/pefilr_user_controller.dart';
import 'package:diario/controllers/registrer_user_controller.dart';
import 'package:diario/models/Usuario.dart';
import 'package:diario/widgets/input_text.dart';
import 'package:diario/widgets/principal_button.dart';
import 'package:flutter/material.dart';

import '../widgets/text_button_simple.dart';
import 'forgot_password.dart';

class PerfilUser extends StatefulWidget {
  const PerfilUser({super.key});

  @override
  State<PerfilUser> createState() => _PerfilUserState();
}

Usuario user = Usuario("", "", "", "", "");
var field = List.filled(3, TextEditingController());

class _PerfilUserState extends State<PerfilUser> {
  bool isLoad = false;
  var focus = List<FocusNode>.filled(3, FocusNode());
  @override
  void initState() {
    for (int i = 0; i < focus.length; i++) {
      focus[i] = FocusNode();
    }
    super.initState();
  }

  void setData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var infoErrorFiedl = List.filled(3, null);
    for (int i = 0; i < focus.length; i++) {
      field[i] = TextEditingController();
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        //  color: AppColors.primaryColor,
        //height: MediaQuery.of(context).size.height,
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
                        "Datos personales",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Form(
                        key: formKey,
                        child: FutureBuilder(
                            future: DataController.loadUser(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return const Text('Error al cargar los datos');
                              } else {
                                user = snapshot.data!;
                                field[0].text = user.nombre!;
                                field[1].text = user.apellidoP!;
                                field[2].text = user.apellidoM!;
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InputText(
                                      hintText: "Nombre",
                                      keyboardType: TextInputType.name,
                                      icon: Icons.person,
                                      focusNode: focus[0],
                                      onEditingComplete: () {
                                        InputText.nextFocus(
                                            focus, 0, 1, context);
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
                                        InputText.nextFocus(
                                            focus, 1, 2, context);
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
                                        InputText.nextFocus(
                                            focus, 2, 0, context);
                                      },
                                      validator: (value) {
                                        return RegistrerUserController
                                            .lastName2FieldValidation(value);
                                      },
                                      controller: field[2],
                                      erroText: infoErrorFiedl[2],
                                    ),
                                    //Campo correo
                                    // InputText(
                                    //   hintText: "Correo",
                                    //   keyboardType: TextInputType.emailAddress,
                                    //   icon: Icons.email,
                                    //   focusNode: focus[3],
                                    //   onEditingComplete: () {
                                    //     InputText.nextFocus(focus, 3, 4, context);
                                    //   },
                                    //   validator: (value) {
                                    //     return RegistrerController
                                    //         .emailFieldCValidation(value);
                                    //   },
                                    //   controller: field[3],
                                    //   erroText: infoErrorFiedl[3],
                                    // ),
                                    // // contrasea
                                    // InputPassword(
                                    //   hintText: "Contraseña",
                                    //   icon: Icons.password,
                                    //   keyboardType: TextInputType.visiblePassword,
                                    //   focusNode: focus[4],
                                    //   onEditingComplete: () {
                                    //     InputText.nextFocus(focus, 4, 5, context);
                                    //   },
                                    //   validator: (value) {
                                    //     return RegistrerController
                                    //         .passwordFieldValidation(value);
                                    //   },
                                    //   controller: field[4],
                                    //   errorText: infoErrorFiedl[4],
                                    // ),
                                    // //campo repite contrasea
                                    // InputPassword(
                                    //   hintText: "Confirma Contraseña",
                                    //   icon: Icons.password,
                                    //   keyboardType: TextInputType.visiblePassword,
                                    //   focusNode: focus[5],
                                    //   controller: field[5],
                                    //   validator: (value) {
                                    //     return RegistrerController
                                    //         .password2FieldValidation(
                                    //             value, field[4].text);
                                    //   },
                                    //   errorText: infoErrorFiedl[5],
                                    // ),

                                    //Boton registrar
                                    PrincipalButton(
                                        isload: isLoad,
                                        text: "Actualizar",
                                        onPressed: () async {
                                          if (formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              isLoad = true;
                                            });

                                            PErfilUserController.saveDataUser(
                                                    field, user)
                                                .then((value) {
                                              setState(() {
                                                isLoad = false;
                                              });

                                              // if (value) {
                                              //   PErfilUserController.messenge(
                                              //       context,
                                              //       "Completado",
                                              //       "Datos guardados");
                                              // }
                                              // if (value == false) {
                                              //   PErfilUserController.messenge(
                                              //       context,
                                              //       "Error",
                                              //       "Intentelo mas tarde");
                                              // }
                                            });
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text('Completado')),
                                            );
                                          }
                                        }),
                                    TextButtonSimple(
                                      text: "Olvide mi contraseña",
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ForgotPassword()),
                                        );
                                      },
                                      margin: const EdgeInsets.only(right: 10),
                                      align: MainAxisAlignment.end,
                                    ),
                                  ],
                                );
                              }
                            })),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
