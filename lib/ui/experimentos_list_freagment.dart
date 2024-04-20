import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/experimento_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/ui/gestionar_variedades_screen.dart';
import 'package:diario/ui/registros_list_screen.dart';
import 'package:diario/widgets/element_experimento.dart';
import 'package:flutter/material.dart';

import 'gestionar_parcelas_screen.dart';

class ExperimentoListFragment extends StatefulWidget {
  const ExperimentoListFragment({super.key});

  @override
  State<ExperimentoListFragment> createState() =>
      _ExperimentoListFragmentState();
}

List<Experimento>? listaExperimento = [];
TextEditingController textEditingController = TextEditingController();
TextEditingController dateController = TextEditingController();
bool isLoad = false;

class _ExperimentoListFragmentState extends State<ExperimentoListFragment> {
  @override
  Widget build(BuildContext context) {
    return isLoad
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: (() {
                    _actualizarListaExperimentos();
                    return DataController.getExperimentos();
                  }),
                  child: FutureBuilder(
                      future: DataController.getExperimentos(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error al obtener la lista'));
                        } else {
                          listaExperimento = snapshot.data!;
                          return ListView.separated(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            itemCount: listaExperimento!.length,
                            itemBuilder: (BuildContext context, index) {
                              return ElementExperimento(
                                  title: listaExperimento![index].nombre,
                                  index: index,
                                  onPressedEdit: (p0) async {
                                    if (listaExperimento![index]
                                                .listaParcelas !=
                                            null &&
                                        listaExperimento![index]
                                            .listaParcelas!
                                            .isNotEmpty) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GestionarParcela(
                                                    experimento:
                                                        listaExperimento![
                                                            index])),
                                      );
                                      _actualizarListaExperimentos();
                                    }
                                  },
                                  onPressed: () async {
                                    if (listaExperimento![index]
                                                .listaVariedades !=
                                            null &&
                                        listaExperimento![index]
                                            .listaVariedades!
                                            .isEmpty) {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                GestionarVariedades(
                                                    experimento:
                                                        listaExperimento![
                                                            index])),
                                      );
                                    } else {
                                      if (listaExperimento![index]
                                          .listaParcelas!
                                          .isEmpty) {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GestionarParcela(
                                                      experimento:
                                                          listaExperimento![
                                                              index])),
                                        );
                                        _actualizarListaExperimentos();
                                      } else {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RegistrosListScreen(
                                                      experimento:
                                                          listaExperimento![
                                                              index])),
                                        );
                                      }
                                    }
                                  },
                                  onPressedDelete: (context) async {
                                    try {
                                      bool? isConfirm =
                                          await ExperimentoController
                                              .showConfirmationDeleteDialog(
                                                  context);
                                      isConfirm ??= false;
                                      if (isConfirm) {
                                        await DataController.deleteExperimento(
                                            listaExperimento![index]);
                                        _actualizarListaExperimentos();
                                      }
                                    } catch (e) {
                                      //  print(e);
                                    }
                                  },
                                  subtitle: ExperimentoController.dateFormat(
                                      listaExperimento![index].inicio));
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              height: 8,
                            ),
                          );
                        }
                      }),
                ),
              )
            ],
          );
  }

  Future<void> _actualizarListaExperimentos() async {
    setState(() {
      isLoad = true;
    });

    try {
      setState(() async {
        listaExperimento = await DataController.getExperimentos()
            .whenComplete(() => setState(() {
                  isLoad = false;
                }));
      });
    } catch (error) {
      setState(() {
        isLoad = false;
      });
    }
  }
}
