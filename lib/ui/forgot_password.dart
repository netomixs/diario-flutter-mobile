import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../utils/app_color.dart';
import '../widgets/alert_windows.dart';
import '../widgets/input_text.dart';
import '../widgets/principal_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late FocusNode _focusNode1;
  @override
  void initState() {
    super.initState();
    _focusNode1 = FocusNode();
  }

  @override
  void dispose() {
    _focusNode1.dispose();

    super.dispose();
  }

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      FractionallySizedBox(
                        child: InputText(
                          controller: emailController,
                          hintText: "Correo",
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email,
                          focusNode: _focusNode1,
                          onEditingComplete: () {},
                        ),
                      ),
                      PrincipalButton(
                          isload: false,
                          text: "Recuperar contraseña",
                          onPressed: () async {
                            LoginController.setRecoveryPasswordNotification(
                                    emailController.text.trim())
                                .then((value) => {
                                      AlertWindow.showSimpleDialog(
                                          context,
                                          "Reseteo de contraseña",
                                          "Hemos enviado un correo electronico de restablecimiento")
                                    })
                                .onError((error, stackTrace) => {
                                      AlertWindow.showSimpleDialog(
                                          context,
                                          "Error",
                                          "Ocurrio un error en la operación")
                                    });
                          })
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
