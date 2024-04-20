import 'package:diario/controllers/login_controller.dart';
import 'package:diario/ui/forgot_password.dart';
import 'package:diario/ui/registrer_screen.dart';
import 'package:diario/utils/app_color.dart';
import 'package:diario/widgets/alert_windows.dart';
import 'package:diario/widgets/input_password.dart';
import 'package:diario/widgets/input_text.dart';
import 'package:diario/widgets/principal_button.dart';
import 'package:flutter/material.dart';
import '../widgets/text_button_simple.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //Control de focus de los campos
  bool isLoad = false;
  late FocusNode _focusNode1;
  late FocusNode _focusNode2;
  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
    _focusNode2 = FocusNode();
  }

  @override
  void dispose() {
    _focusNode1.dispose();
    _focusNode2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    // LoginController.isLogged(context);
    return SingleChildScrollView(
      child: Container(
        color: AppColors.primaryColor,
        height: MediaQuery.of(context).size.height,
        child: Container(
          //color: AppColors.primaryColor,
          margin: const EdgeInsets.only(top: 60),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FractionallySizedBox(
                widthFactor: 3 / 8, // Ocupa 1/3 del ancho disponible

                child: Image.asset("assets/img/Logo.jpeg"),
              ),
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
                      InputText(
                        controller: emailController,
                        hintText: "Correo",
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email,
                        focusNode: _focusNode1,
                        onEditingComplete: () {
                          LoginController.enterEmailFocus(
                              _focusNode1, _focusNode2, context);
                        },
                      ),
                      InputPassword(
                        controller: passwordController,
                        hintText: "Contraseña",
                        focusNode: _focusNode2,
                        icon: Icons.password,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      TextButtonSimple(
                        text: "Olvide mi contraseña",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        margin: const EdgeInsets.only(right: 10),
                        align: MainAxisAlignment.end,
                      ),
                      PrincipalButton(
                          isload: isLoad,
                          text: "Iniciar sesión",
                          onPressed: () async {
                            if (emailController.text.isNotEmpty &&
                                passwordController.text.isNotEmpty) {
                              setState(() {
                                isLoad = true;
                              });

                              LoginController.loginUser(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                      context)
                                  .then((result) {
                                    setState(() {
                                      isLoad = false;
                                    });

                                    ///muestra el resultado en caso de algun error
                                    if (result == null) {
                                      LoginController.isLogged(context);
                                    } else {
                                      result.show(context);
                                    }
                                  })
                                  .catchError((e) {})
                                  .whenComplete(() => () {
                                        setState(() {
                                          isLoad = false;
                                        });
                                      });

                              ///Lama al controlador de incio de sesion
                            } else {
                              AlertWindow.showSimpleDialog(context, "Alerta",
                                  "Completa todos los campos");
                            }
                          }),
                      TextButtonSimple(
                        text: "No tengo cuenta",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Registre()),
                          );
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
