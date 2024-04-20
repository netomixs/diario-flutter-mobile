import 'package:diario/controllers/parcela_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/ui/registrer_data_screen.dart';
import 'package:diario/widgets/element_parcela.dart';
import 'package:flutter/material.dart';

class RegistrarParcelas extends StatefulWidget {
  final Experimento experimento;
  final HojaMedicion hoja;
  const RegistrarParcelas(
      {super.key, required this.experimento, required this.hoja});

  @override
  State<RegistrarParcelas> createState() => _RegistrarParcelasState();
}

class _RegistrarParcelasState extends State<RegistrarParcelas> {
  bool isDataSaving = false;
  List<Parcela> listaParcela = [];
  List<Parcela> lista1 = [];
  List<Parcela> lista2 = [];
  List<Parcela> lista3 = [];
  List<Parcela> lista4 = [];
  List<int> itemsSelect = [];
  int variedades = 0;
  @override
  void initState() {
    super.initState();
    variedades = widget.experimento.numeroVariedades;
    listaParcela = widget.experimento.listaParcelas!;

    lista1 = listaParcela.sublist(0, widget.experimento.numeroVariedades);
    lista2 = listaParcela.sublist(widget.experimento.numeroVariedades,
        widget.experimento.numeroVariedades * 2);
    lista3 = listaParcela.sublist(widget.experimento.numeroVariedades * 2,
        widget.experimento.numeroVariedades * 3);
    lista4 = listaParcela.sublist(widget.experimento.numeroVariedades * 3,
        widget.experimento.numeroVariedades * 4);
  }

  void reload() {
    variedades = widget.experimento.numeroVariedades;
    listaParcela = widget.experimento.listaParcelas!;

    lista1 = listaParcela.sublist(0, widget.experimento.numeroVariedades);
    lista2 = listaParcela.sublist(widget.experimento.numeroVariedades,
        widget.experimento.numeroVariedades * 2);
    lista3 = listaParcela.sublist(widget.experimento.numeroVariedades * 2,
        widget.experimento.numeroVariedades * 3);
    lista4 = listaParcela.sublist(widget.experimento.numeroVariedades * 3,
        widget.experimento.numeroVariedades * 4);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Parcelas "),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          final itemHeight = orientation == Orientation.portrait
              ? (screenHeight * .4) / 4
              : (screenHeight * .8) / 4;

          return Row(
            children: [
              Expanded(
                child: CustomScrollView(
                  scrollDirection: Axis.horizontal,
                  slivers: [
                    SliverToBoxAdapter(
                        child: SizedBox(
                            height: 20,
                            width: (widget.experimento.numeroVariedades *
                                    itemHeight) +
                                200,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Text("Repetición 4:"),
                                    SizedBox(
                                      height: itemHeight,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return ElementParcel(
                                                isComplete: widget
                                                    .hoja
                                                    .listaRegistros![index]
                                                    .completado,
                                                isSelect:
                                                    ParcelaController.isSetect(
                                                        repeticion: 1,
                                                        itemsSelect:
                                                            itemsSelect,
                                                        index: index),
                                                onPressed: () async {
                                                  try {
                                                    await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              RegistrosScreen(
                                                                  experimento:
                                                                      widget
                                                                          .experimento,
                                                                  parcela:
                                                                      lista1[
                                                                          index],
                                                                  hoja: widget
                                                                      .hoja)),
                                                    ).whenComplete(
                                                        () => reload());
                                                  } catch (e) {
                                                    //  print(e);
                                                  }
                                                },
                                                size: itemHeight,
                                                color: ParcelaController
                                                    .hexToColor(widget
                                                        .experimento
                                                        .listaVariedades![
                                                            lista1[index]
                                                                    .numero -
                                                                1]
                                                        .color),
                                                text:
                                                    " ${lista1[index].numero}",
                                                keyValue: lista1[index].numero);
                                          },
                                          itemCount: widget
                                              .experimento.numeroVariedades),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Repetición 3:"),
                                    SizedBox(
                                      height: itemHeight,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return ElementParcel(
                                                isComplete: widget
                                                    .hoja
                                                    .listaRegistros![
                                                        index + variedades]
                                                    .completado,
                                                isSelect:
                                                    ParcelaController.isSetect(
                                                        repeticion: 2,
                                                        itemsSelect:
                                                            itemsSelect,
                                                        index: index),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrosScreen(
                                                                experimento: widget
                                                                    .experimento,
                                                                parcela: lista2[
                                                                    index],
                                                                hoja: widget
                                                                    .hoja)),
                                                  );
                                                },
                                                size: itemHeight,
                                                color: ParcelaController
                                                    .hexToColor(widget
                                                        .experimento
                                                        .listaVariedades![
                                                            lista2[index]
                                                                    .numero -
                                                                1]
                                                        .color),
                                                text:
                                                    " ${lista2[index].numero}",
                                                keyValue: lista2[index].numero);
                                          },
                                          itemCount: widget
                                              .experimento.numeroVariedades),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Repetición 2:"),
                                    SizedBox(
                                      height: itemHeight,
                                      child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return ElementParcel(
                                                isComplete: widget
                                                    .hoja
                                                    .listaRegistros![index +
                                                        (2 * variedades)]
                                                    .completado,
                                                isSelect:
                                                    ParcelaController.isSetect(
                                                        repeticion: 3,
                                                        itemsSelect:
                                                            itemsSelect,
                                                        index: index),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrosScreen(
                                                                experimento: widget
                                                                    .experimento,
                                                                parcela: lista3[
                                                                    index],
                                                                hoja: widget
                                                                    .hoja)),
                                                  );
                                                },
                                                size: itemHeight,
                                                color: ParcelaController
                                                    .hexToColor(widget
                                                        .experimento
                                                        .listaVariedades![
                                                            lista3[index]
                                                                    .numero -
                                                                1]
                                                        .color),
                                                text:
                                                    " ${lista3[index].numero}",
                                                keyValue: lista3[index].numero);
                                          },
                                          itemCount: widget
                                              .experimento.numeroVariedades),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text("Repetición 1:"),
                                    SizedBox(
                                      height: itemHeight,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder:
                                              (BuildContext context, index) {
                                            return ElementParcel(
                                                isComplete: widget
                                                    .hoja
                                                    .listaRegistros![index +
                                                        (3 * variedades)]
                                                    .completado,
                                                isSelect:
                                                    ParcelaController.isSetect(
                                                        repeticion: 4,
                                                        itemsSelect:
                                                            itemsSelect,
                                                        index: index),
                                                onPressed: () async {
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RegistrosScreen(
                                                                experimento: widget
                                                                    .experimento,
                                                                parcela: lista4[
                                                                    index],
                                                                hoja: widget
                                                                    .hoja)),
                                                  );
                                                },
                                                size: itemHeight,
                                                color: ParcelaController
                                                    .hexToColor(widget
                                                        .experimento
                                                        .listaVariedades![
                                                            lista4[index]
                                                                    .numero -
                                                                1]
                                                        .color),
                                                text:
                                                    " ${lista4[index].numero}",
                                                keyValue: lista4[index].numero);
                                          },
                                          itemCount: widget
                                              .experimento.numeroVariedades),
                                    ),
                                  ],
                                ),
                              ],
                            )))
                  ],
                ),
              ),
            ],
          );
        }));
  }
}
