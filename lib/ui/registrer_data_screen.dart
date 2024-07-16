import 'package:diario/controllers/parcela_controller.dart';
import 'package:diario/controllers/registrar_data_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/models/Registro.dart';
import 'package:diario/widgets/principal_button.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import '../widgets/input_number.dart';

class RegistrosScreen extends StatefulWidget {
  final Experimento experimento;
  final Parcela parcela;
  final HojaMedicion hoja;
  const RegistrosScreen(
      {super.key,
      required this.experimento,
      required this.parcela,
      required this.hoja});

  @override
  State<RegistrosScreen> createState() => _RegistrosScreenState();
}

final formKey = GlobalKey<FormState>();

class _RegistrosScreenState extends State<RegistrosScreen> {
  bool _dataChanged = false;
  var focus = List<FocusNode>.filled(12, FocusNode());
  Registro registro = Registro();
  TextEditingController surco3Controller = TextEditingController();
  TextEditingController surco4Controller = TextEditingController();
  var talloController = List.filled(10, TextEditingController());
  late RegistrarDataContoller regsitroController;
  @override
  void initState() {
    for (var i = 0; i < talloController.length; i++) {
      talloController[i] = TextEditingController();
    }
    for (var i = 0; i < focus.length; i++) {
      focus[i] = FocusNode();
    }
    regsitroController = RegistrarDataContoller(
        hoja: widget.hoja,
        parcel: widget.parcela,
        experiment: widget.experimento);
    registro = regsitroController.getDataOld();
    // setDataOnText();
    if (registro.completado) {
      try {
        surco3Controller.text = "${registro.listaSurcos![0].cantidad_tallos}";
        surco4Controller.text = "${registro.listaSurcos![1].cantidad_tallos}";
        for (var i = 0; i < 5; i++) {
          talloController[i].text =
              "${registro.listaSurcos![0].tallosLista![i].medida}";
        }
        //   print(registro.listaSurcos![1].tallosLista!.length);
        for (var i = 0; i < 5; i++) {
          talloController[i + 5].text =
              "${registro.listaSurcos![1].tallosLista![i].medida}";
        }
      } catch (e) {
        // print(e);
      }
    }
    super.initState();
  }

  void setDataOnText() {
    _dataChanged = true;
    /*  try {
      surco3Controller.text = "${registro.listaSurcos![0].cantidad_tallos}";
      surco4Controller.text = "${registro.listaSurcos![1].cantidad_tallos}";
      for (var i = 0; i < 5; i++) {
        talloController[i].text =
            "${registro.listaSurcos![0].tallosLista![i].medida}";
      }
      //   print(registro.listaSurcos![1].tallosLista!.length);
      for (var i = 0; i < 5; i++) {
        talloController[i + 5].text =
            "${registro.listaSurcos![1].tallosLista![i].medida}";
      }
    } catch (e) {
      // print(e);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    regsitroController.setRegistros(
        surco3Text: surco3Controller,
        surco4Text: surco4Controller,
        list: talloController,
        registro: registro);
    return WillPopScope(
      onWillPop: () async {
        if (_dataChanged) {
          // Mostrar la alerta de confirmación si hay datos sin guardar
          bool? confirm =
              await ParcelaController.showDiscardConfirmationDialog(context);
          if (confirm == null) {
            return false;
          }
          return confirm;
        }
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ParcelaController.hexToColor(widget
                .experimento.listaVariedades![widget.parcela.numero - 1].color),
            title: Row(
              children: [
                Text(widget.experimento
                    .listaVariedades![widget.parcela.numero - 1].tratamiento),
                Text(" ${widget.parcela.numero}")
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.only(right: 5, left: 10),
                padding: const EdgeInsets.all(10),
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  InputNumber(
                                    hintText: "Surco 3",
                                    controller: surco3Controller,
                                    focusNode: focus[0],
                                    icon: Icons.numbers,
                                    medida: "Tallos",
                                    onEditingComplete: () {
                                      InputNumber.nextFocus(
                                          focus, 0, 1, context);
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    },
                                  ),
                                  Container(
                                      alignment: Alignment.topLeft,
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Text(
                                          "Suma de tallos:${regsitroController.totalSurcos} ")),
                                  InputNumber(
                                    hintText: "Tallo 1",
                                    controller: talloController[0],
                                    focusNode: focus[1],
                                    icon: Icons.numbers,
                                    onEditingComplete: () {
                                      InputNumber.nextFocus(
                                          focus, 1, 2, context);
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    },
                                    medida: "cm.",
                                  ),
                                  InputNumber(
                                    hintText: "Tallo 2",
                                    controller: talloController[1],
                                    focusNode: focus[2],
                                    icon: Icons.numbers,
                                    onEditingComplete: () {
                                      InputNumber.nextFocus(
                                          focus, 2, 3, context);
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    },
                                    medida: "cm.",
                                  ),
                                  InputNumber(
                                    hintText: "Tallo 3",
                                    controller: talloController[2],
                                    focusNode: focus[3],
                                    icon: Icons.numbers,
                                    onEditingComplete: () {
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                      InputNumber.nextFocus(
                                          focus, 3, 4, context);
                                    },
                                    medida: "cm.",
                                  ),
                                  InputNumber(
                                    hintText: "Tallo 4",
                                    controller: talloController[3],
                                    focusNode: focus[4],
                                    icon: Icons.numbers,
                                    onEditingComplete: () {
                                      InputNumber.nextFocus(
                                          focus, 4, 5, context);
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    },
                                    medida: "cm.",
                                  ),
                                  InputNumber(
                                    hintText: "Tallo 5",
                                    controller: talloController[4],
                                    focusNode: focus[5],
                                    icon: Icons.numbers,
                                    onEditingComplete: () {
                                      InputNumber.nextFocus(
                                          focus, 5, 6, context);
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    },
                                    medida: "cm.",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                InputNumber(
                                  hintText: "Surco 4",
                                  controller: surco4Controller,
                                  focusNode: focus[6],
                                  icon: Icons.numbers,
                                  onEditingComplete: () {
                                    InputNumber.nextFocus(focus, 6, 7, context);
                                    regsitroController.setRegistros(
                                        surco3Text: surco3Controller,
                                        surco4Text: surco4Controller,
                                        list: talloController,
                                        registro: registro);
                                    setState(() {
                                      setDataOnText();
                                    });
                                  },
                                  medida: "cm.",
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      "Promedio de tallos:${regsitroController.promedioSurcos}"),
                                ),
                                InputNumber(
                                  hintText: "Tallo 1",
                                  controller: talloController[5],
                                  focusNode: focus[7],
                                  icon: Icons.numbers,
                                  onEditingComplete: () {
                                    InputNumber.nextFocus(focus, 7, 8, context);
                                    regsitroController.setRegistros(
                                        surco3Text: surco3Controller,
                                        surco4Text: surco4Controller,
                                        list: talloController,
                                        registro: registro);
                                    setState(() {
                                      setDataOnText();
                                    });
                                  },
                                  medida: "cm.",
                                ),
                                InputNumber(
                                  hintText: "Tallo 2",
                                  controller: talloController[6],
                                  focusNode: focus[8],
                                  icon: Icons.numbers,
                                  onEditingComplete: () {
                                    InputNumber.nextFocus(focus, 8, 9, context);
                                    regsitroController.setRegistros(
                                        surco3Text: surco3Controller,
                                        surco4Text: surco4Controller,
                                        list: talloController,
                                        registro: registro);
                                    setState(() {
                                      setDataOnText();
                                    });
                                  },
                                  medida: "cm.",
                                ),
                                InputNumber(
                                  hintText: "Tallo 3",
                                  controller: talloController[7],
                                  focusNode: focus[9],
                                  icon: Icons.numbers,
                                  onEditingComplete: () {
                                    InputNumber.nextFocus(
                                        focus, 9, 10, context);
                                    regsitroController.setRegistros(
                                        surco3Text: surco3Controller,
                                        surco4Text: surco4Controller,
                                        list: talloController,
                                        registro: registro);
                                    setState(() {
                                      setDataOnText();
                                    });
                                  },
                                  medida: "cm.",
                                ),
                                InputNumber(
                                  hintText: "Tallo 4",
                                  controller: talloController[8],
                                  focusNode: focus[10],
                                  icon: Icons.numbers,
                                  onEditingComplete: () {
                                    InputNumber.nextFocus(
                                        focus, 10, 11, context);
                                    regsitroController.setRegistros(
                                        surco3Text: surco3Controller,
                                        surco4Text: surco4Controller,
                                        list: talloController,
                                        registro: registro);
                                    setState(() {
                                      setDataOnText();
                                    });
                                  },
                                  medida: "cm.",
                                ),
                                InputNumber(
                                    hintText: "Tallo 5",
                                    controller: talloController[9],
                                    focusNode: focus[11],
                                    icon: Icons.numbers,
                                    medida: "cm.",
                                    onEditingComplete: () {
                                      regsitroController.setRegistros(
                                          surco3Text: surco3Controller,
                                          surco4Text: surco4Controller,
                                          list: talloController,
                                          registro: registro);
                                      setState(() {
                                        setDataOnText();
                                      });
                                    }),
                              ],
                            ))
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "Suma total:${regsitroController.totalTallos} "),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                    "Promedio:${regsitroController.promedioTallos}"),
                              ),
                            ),
                          ],
                        ),
                        PrincipalButton(
                          isload: isload,
                          text: "Confirmar",
                          onPressed: () async {
                            bool isConnect = false;
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isload = true;
                              });
                              try {
                                // Establecer un tiempo de espera máximo (por ejemplo, 30 segundos)

                                if (await checkInternetConnection()) {
                                  isConnect = true;
                                } else {
                                  showCompleteAsyncDialog();
                                  isload = false;
                                }
                                await regsitroController.saveHoja();

                                setState(() {
                                  _dataChanged = false;
                                  isload = false;
                                });

                                // ignore: use_build_context_synchronously
                              } catch (e) {
                                errorDialog(context);
                                setState(() {
                                  isload = false;
                                });
                              } finally {
                                if (isConnect) {
                                  showCompleteDialog(context);
                                }
                              }
                            }
                          },
                        )
                      ],
                    ))),
          )),
    );
  }

  bool isload = false;
  String? validateEmapty(String? text) {
    if (text!.isEmpty) {
      return "Completa este campo";
    }
    return null;
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return (connectivityResult != ConnectivityResult.none);
  }

  static Future<bool?> showCompleteDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Completado'),
          content: const Text('Datos guardados con exito'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                Navigator.of(context).pop(false);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<bool> showCompleteAsyncDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pendiente'),
          content: const Text(
              'Los datos se sincronizaran cuando se encuentre conexion'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No descartar cambios
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static Future<bool> errorDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content:
              const Text('Ocurrio un error inesperado. Intentalo nuevamente'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No descartar cambios
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
