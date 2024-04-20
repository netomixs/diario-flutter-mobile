import 'package:diario/controllers/parcela_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/widgets/element_parcela.dart';
import 'package:flutter/material.dart';

class GestionarParcela extends StatefulWidget {
  final Experimento experimento;
  const GestionarParcela({super.key, required this.experimento});

  @override
  State<GestionarParcela> createState() => _GestionarParcelaState();
}

class _GestionarParcelaState extends State<GestionarParcela> {
  bool _dataChanged = false;
  bool isDataSaving = false;
  List<Parcela> listaParcela = [];
  List<Parcela> lista1 = [];
  List<Parcela> lista2 = [];
  List<Parcela> lista3 = [];
  List<Parcela> lista4 = [];
  List<int> itemsSelect = [];
  void selectItem({required int repeticion, required int index}) {
    if (itemsSelect.isEmpty) {
      itemsSelect.add(repeticion);
      itemsSelect.add(index);
    } else {
      if (itemsSelect[0] == repeticion) {
        if (itemsSelect[1] == index) {
          itemsSelect.clear();
        } else {
          itemsSelect.add(index);
          switch (repeticion) {
            case 1:
              Parcela parcelaAux1 = lista1[itemsSelect[1]];
              Parcela parcelaAux2 = lista1[itemsSelect[2]];
              parcelaAux1.posicion = itemsSelect[2];
              parcelaAux2.posicion = itemsSelect[1];
              lista1[itemsSelect[1]] = parcelaAux2;
              lista1[itemsSelect[2]] = parcelaAux1;
              break;
            case 2:
              Parcela parcelaAux1 = lista2[itemsSelect[1]];
              Parcela parcelaAux2 = lista2[itemsSelect[2]];
              parcelaAux1.posicion = itemsSelect[2];
              parcelaAux2.posicion = itemsSelect[1];
              lista2[itemsSelect[1]] = parcelaAux2;
              lista2[itemsSelect[2]] = parcelaAux1;
              break;
            case 3:
              Parcela parcelaAux1 = lista3[itemsSelect[1]];
              Parcela parcelaAux2 = lista3[itemsSelect[2]];
              parcelaAux1.posicion = itemsSelect[2];
              parcelaAux2.posicion = itemsSelect[1];
              lista3[itemsSelect[1]] = parcelaAux2;
              lista3[itemsSelect[2]] = parcelaAux1;
              break;
            case 4:
              Parcela parcelaAux1 = lista4[itemsSelect[1]];
              Parcela parcelaAux2 = lista4[itemsSelect[2]];
              parcelaAux1.posicion = itemsSelect[2];
              parcelaAux2.posicion = itemsSelect[1];
              lista4[itemsSelect[1]] = parcelaAux2;
              lista4[itemsSelect[2]] = parcelaAux1;
              break;
            default:
          }
          itemsSelect.clear();
        }
      } else {
        itemsSelect.clear();
        itemsSelect.add(repeticion);
        itemsSelect.add(index);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.experimento.listaParcelas!.isEmpty) {
      listaParcela = ParcelaController.createParcelaList(widget.experimento);
    } else {
      listaParcela = widget.experimento.listaParcelas!;
    }
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

    return WillPopScope(
        onWillPop: () async {
          if (_dataChanged) {
            // Mostrar la alerta de confirmación si hay datos sin guardar
            bool? confirm =
                await ParcelaController.showDiscardConfirmationDialog(
                    context);
              if (confirm==null) {
                  return false;
              }
            return confirm;
          }
          return true;
        },
        child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _dataChanged = false;
                        isDataSaving = true;
                        ParcelaController.saveParcela(
                                list1: lista1,
                                list2: lista2,
                                list3: lista3,
                                list4: lista4,
                                experimento: widget.experimento)
                            .whenComplete(() {
                          setState(() {
                            isDataSaving = false;
                          });
                        });
                      });
                    },
                    icon: const Icon(Icons.save)),
                if (isDataSaving)
                  const CircularProgressIndicator()
                else
                  const Icon(Icons.cloud)
              ],
              title: const Text("Parcelas"),
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
                                                  (BuildContext context,
                                                      index) {
                                                return ElementParcel(
                                                  isComplete: false,
                                                    isSelect: ParcelaController
                                                        .isSetect(
                                                            repeticion: 1,
                                                            itemsSelect:
                                                                itemsSelect,
                                                            index: index),
                                                    onPressed: () {
                                                      setState(() {
                                                        _dataChanged = true;
                                                        selectItem(
                                                            repeticion: 1,
                                                            index: index);
                                                      });
                                                    },
                                                    size: itemHeight,
                                                    color: ParcelaController
                                                        .hexToColor(widget
                                                            .experimento
                                                            .listaVariedades![
                                                                lista1[index]
                                                                    .numero-1]
                                                            .color),
                                                    text:
                                                        " ${lista1[index].numero}",
                                                    keyValue:
                                                        lista1[index].numero);
                                              },
                                              itemCount: widget.experimento
                                                  .numeroVariedades),
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
                                                  (BuildContext context,
                                                      index) {
                                                return ElementParcel(
                                                  isComplete: false,
                                                    isSelect: ParcelaController
                                                        .isSetect(
                                                            repeticion: 2,
                                                            itemsSelect:
                                                                itemsSelect,
                                                            index: index),
                                                    onPressed: () {
                                                      _dataChanged = true;

                                                      setState(() {
                                                        selectItem(
                                                            repeticion: 2,
                                                            index: index);
                                                      });
                                                    },
                                                    size: itemHeight,
                                                    color: ParcelaController
                                                        .hexToColor(widget
                                                            .experimento
                                                            .listaVariedades![
                                                                lista2[index]
                                                                    .numero-1]
                                                            .color),
                                                    text:
                                                        " ${lista2[index].numero}",
                                                    keyValue:
                                                        lista2[index].numero);
                                              },
                                              itemCount: widget.experimento
                                                  .numeroVariedades),
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
                                                  (BuildContext context,
                                                      index) {
                                                return ElementParcel(
                                                  isComplete: false,
                                                    isSelect: ParcelaController
                                                        .isSetect(
                                                            repeticion: 3,
                                                            itemsSelect:
                                                                itemsSelect,
                                                            index: index),
                                                    onPressed: () {
                                                      setState(() {
                                                        _dataChanged = true;

                                                        selectItem(
                                                            repeticion: 3,
                                                            index: index);
                                                      });
                                                    },
                                                    size: itemHeight,
                                                    color: ParcelaController
                                                        .hexToColor(widget
                                                            .experimento
                                                            .listaVariedades![
                                                                lista3[index]
                                                                    .numero-1]
                                                            .color),
                                                    text:
                                                        " ${lista3[index].numero}",
                                                    keyValue:
                                                        lista3[index].numero);
                                              },
                                              itemCount: widget.experimento
                                                  .numeroVariedades),
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
                                                  (BuildContext context,
                                                      index) {
                                                return ElementParcel(
                                                  isComplete: false,
                                                    isSelect: ParcelaController
                                                        .isSetect(
                                                            repeticion: 4,
                                                            itemsSelect:
                                                                itemsSelect,
                                                            index: index),
                                                    onPressed: () {
                                                      setState(() {
                                                        _dataChanged = true;

                                                        selectItem(
                                                            repeticion: 4,
                                                            index: index);
                                                      });
                                                    },
                                                    size: itemHeight,
                                                    color: ParcelaController
                                                        .hexToColor(widget
                                                            .experimento
                                                            .listaVariedades![
                                                                lista4[index]
                                                                    .numero-1]
                                                            .color),
                                                    text:
                                                        " ${lista4[index].numero}",
                                                    keyValue:
                                                        lista4[index].numero);
                                              },
                                              itemCount: widget.experimento
                                                  .numeroVariedades),
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
            })));
  }
}
