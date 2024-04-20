import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/controllers/registro_hojas_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/ui/registrar_parcelas_screen.dart';
import 'package:diario/widgets/element_registro.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';
import '../controllers/data_controller.dart';

class RegistrosListScreen extends StatefulWidget {
  final Experimento experimento;
  const RegistrosListScreen({super.key, required this.experimento});

  @override
  State<RegistrosListScreen> createState() => _RegistrosListScreenState();
}

// ignore: unused_element
late Future<void> _actualizarListaFuture;
bool isLoad = false;
List<HojaMedicion> listaHojas = [];

class _RegistrosListScreenState extends State<RegistrosListScreen> {
  @override
  void initState() {
    isLoad = false;
    listaHojas = widget.experimento.listaHojaMediciones!;
    super.initState();
  }

  @override
  void dispose() {
    isLoad = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hojas de registro"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (await RegistroHojasController.showInputDialog(
              context, widget.experimento)) {
            _actualizarListaExperimentos();
          }
        },
        tooltip: 'Agregar registro',
        child: const Icon(Icons.add),
      ),
      body: isLoad
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                      onRefresh: (() =>
                          DataController.getHojasMedicion(widget.experimento)),
                      child: ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(10),
                        itemCount: listaHojas.length,
                        itemBuilder: (BuildContext context, index) {
                          double porcentaje =
                              RegistroHojasController.getCompletPArcelas(
                                  listaHojas[index],
                                  widget.experimento.numeroVariedades);
                          if (porcentaje == 1) {
                            listaHojas[index].sincronizado = true;
                            String? idUser = widget.experimento.usuario;
                            String? idExperimento = widget.experimento.id;
                            String route =
                                "$idUser/experimentos/$idExperimento";
                            DataController.saveHojaNedicion(
                                listaHojas[index], route);
                          }
                          //    print(porcentaje);
                          return ElementRegistro(
                              mesCrecimiento: listaHojas[index].mesCrecimiento,
                              index: index,
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegistrarParcelas(
                                            experimento: widget.experimento,
                                            hoja: listaHojas[index],
                                          )),
                                );
                              },
                              onPressedDelete: (p0) async {
                                if (await checkInternetConnection()) {
                                  try {
                                    bool? isConfirm =
                                        // ignore: use_build_context_synchronously
                                        await ExperimentoController
                                            .showConfirmationDeleteDialog(
                                                context);
                                    isConfirm ??= false;
                                    if (isConfirm) {
                                      await DataController.deleteHoajeregistro(
                                          widget.experimento,
                                          listaHojas[index]);

                                      await _actualizarListaExperimentos();
                                    }
                                  } catch (e) {
                                    _actualizarListaFuture =
                                        _actualizarListaExperimentos();
                                  }
                                } else {
                                  // ignore: use_build_context_synchronously
                                  notConnection(context);
                                }
                              },
                              subtitle: ExperimentoController.dateFormat(
                                  listaHojas[index].fechaCreacion),
                              onPressedEdit: (p0) {},
                              isComplet: listaHojas[index].sincronizado,
                              complet: porcentaje);
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          height: 8,
                        ),
                      )),
                )
              ],
            ),
    );
  }

  Future<void> _actualizarListaExperimentos() async {
    try {
      setState(() {
        isLoad = true;
      });

      listaHojas = await DataController.getHojasMedicion(widget.experimento);
      widget.experimento.listaHojaMediciones = listaHojas;
      if (isLoad) {
        setState(() {
          widget.experimento.listaHojaMediciones = listaHojas;
          isLoad = false;
        });
      }
    } catch (error) {
      // print("Error el catch");
      // print(error);
    } finally {
      try {} catch (e) {
        //  print("-----------------------------");
        //  print(e);
      }
    }
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return (connectivityResult != ConnectivityResult.none);
  }

  static Future<bool> notConnection(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Esta acción requiere conexión a internet'),
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
