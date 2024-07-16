
import 'package:diario/controllers/variedades_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Variedades.dart';
import 'package:diario/widgets/element_Variedad.dart';
import 'package:diario/widgets/principal_button.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../widgets/input_text.dart';

class GestionarVariedades extends StatefulWidget {
  final Experimento experimento;
  const GestionarVariedades({super.key, required this.experimento});

  @override
  State<GestionarVariedades> createState() => _GestionarVariedadesState();
}

class _GestionarVariedadesState extends State<GestionarVariedades> {
  TextEditingController tratamientoEditText = TextEditingController();
  TextEditingController faseEditText = TextEditingController();
  TextEditingController campoEditText = TextEditingController();
  final formKey = GlobalKey<FormState>();
  int selectedIndex = -1;
  Color currentColor = Colors.blue;
  List<Variedades> listaVariedades = [];
  bool isChecked = false;
  final bool _dataChanged = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_dataChanged) {
          // Mostrar la alerta de confirmación si hay datos sin guardar
          bool? confirm = await showDiscardConfirmationDialog(context);
          return confirm;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  VariedadController.saveConfirmDialog(
                      experimento: widget.experimento,
                      lista: listaVariedades,
                      context: context);
                },
                icon: const Icon(Icons.save))
          ],
          title: const Text('Gestion de variedades'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               Column(
                    children: [
                      InputText(
                        hintText: "Tratameinto",
                        label: "Tratamiento",
                        controller: tratamientoEditText,
                        icon: Icons.abc,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return "Este campo no puede ir vacio";
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InputText(
                              hintText: "Fase",
                              label: "Fase",
                              icon: Icons.abc,
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Este campo no puede ir vacio";
                                }
                                return null;
                              },
                              controller: faseEditText,
                            ),
                          ),
                          Expanded(
                            child: InputText(
                              hintText: "Campo",
                              label: "Campo",
                              validator: (p0) {
                                if (p0!.isEmpty) {
                                  return "Este campo no puede ir vacio";
                                }
                                return null;
                              },
                              icon: Icons.abc,
                              controller: campoEditText,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: const Row(
                          children: [
                            Text(
                              "Color:",
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        ColorPicker(
                            enableAlpha: false,
                            showLabel: false,
                            pickerAreaHeightPercent: 0.01,
                            portraitOnly: false,
                            pickerColor: currentColor,
                            displayThumbColor: false,
                            paletteType: PaletteType.rgb,
                            onColorChanged: (Color color) {
                              setState(() {
                                currentColor = color;
                              });
                            })
                      ]),
                      Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            const Text(
                              "Marcar como textigo:",
                            ),
                            Checkbox(
                                value: isChecked,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked = value!;
                                  });
                                }),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: PrincipalButton(
                              isload: false,
                                text: "Agregar",
                                onPressed: () {
                                  selectedIndex = -1;
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      Variedades variedad =
                                          VariedadController.createVariedad(
                                              tratamiento:
                                                  tratamientoEditText.text,
                                              fase: faseEditText.text,
                                              campo: campoEditText.text,
                                              color: currentColor,
                                              id: listaVariedades.length + 1);
                                      if (isChecked) {
                                        if (widget.experimento.variedadTestigo
                                            .isEmpty) {
                                          widget.experimento.variedadTestigo =
                                              variedad.id;
                                        } else {
                                          VariedadController.variedadAlready(
                                              context);
                                        }
                                      }

                                      listaVariedades.add(variedad);
                                    });
                                  }
                                }),
                          ),
                          Expanded(
                            child: PrincipalButton(
                              isload: false,
                                text: "Guardar",
                                color: const Color.fromARGB(255, 110, 255, 62),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    setState(() {
                                      if (selectedIndex >= 0) {
                                        listaVariedades[selectedIndex] =
                                            VariedadController.updateVariedad(
                                                tratamiento:
                                                    tratamientoEditText.text,
                                                fase: faseEditText.text,
                                                campo: campoEditText.text,
                                                color: currentColor,
                                                id: listaVariedades[
                                                        selectedIndex]
                                                    .id);
                                        if (isChecked) {
                                          if (widget.experimento.variedadTestigo
                                              .isEmpty) {
                                            widget.experimento.variedadTestigo =
                                                listaVariedades[selectedIndex]
                                                    .id;
                                          } else if (widget.experimento
                                                  .variedadTestigo ==
                                              listaVariedades[selectedIndex]
                                                  .id) {
                                          } else {
                                            VariedadController.variedadAlready(
                                                context);
                                          }
                                        } else {
                                          if (widget.experimento
                                                  .variedadTestigo ==
                                              listaVariedades[selectedIndex]
                                                  .id) {
                                            widget.experimento.variedadTestigo =
                                                "";
                                          }
                                        }
                                      }
                                      selectedIndex = -1;
                                    });
                                  }
                                }),
                          )
                        ],
                      )
                    ],
                  ),
                
                Expanded(
                    child: Card(
                
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: listaVariedades.length,
                      itemBuilder: (BuildContext context, index) {
                        //String formattedDate = DateFormat('dd/MM/yyyy').format(now);

                        return ElementVariedad(
                          title: listaVariedades[index].tratamiento,
                          index: index,
                          color: hexToColor(listaVariedades[index].color),
                          onPressed: () {
                            tratamientoEditText.text =
                                listaVariedades[index].tratamiento;
                            faseEditText.text = listaVariedades[index].fase;
                            campoEditText.text = listaVariedades[index].campo;
                            currentColor =
                                hexToColor(listaVariedades[index].color);
                            isChecked = VariedadController.isTestigo(
                                widget.experimento, listaVariedades[index]);

                            setState(() {
                              currentColor =
                                  hexToColor(listaVariedades[index].color);
                              selectedIndex = index;
                            });
                          },
                          onPressedDelete: (context) {
                            setState(() {
                              selectedIndex = -1;
                              if (VariedadController.isTestigo(
                                  widget.experimento, listaVariedades[index])) {
                                widget.experimento.variedadTestigo = "";
                              }
                              List<dynamic> result =
                                  VariedadController.deleteVariedad(
                                      listaVariedades,
                                      index,
                                      widget.experimento);
                              listaVariedades = result[0];
                              widget.experimento.variedadTestigo = result[1];
                            });
                          },
                          subtitle: listaVariedades[index].campo,
                          isTestigo: VariedadController.isTestigo(
                              widget.experimento, listaVariedades[index]),
                          isSelect: selectedIndex == index,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(
                        height: 1,
                      ),
                    ),
                  
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color hexToColor(String hexString) {
    String cleanHex = hexString.replaceAll("#", "");
    int colorInt = int.parse(cleanHex, radix: 16);
    return Color(colorInt).withOpacity(1.0);
  }

  Future<bool> showDiscardConfirmationDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('¿Descartar cambios?'),
          content: const Text('Hay datos sin guardar. ¿Desea descartar los cambios?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // No descartar cambios
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Descartar cambios
              },
              child: const Text('Descartar'),
            ),
          ],
        );
      },
    );
  }

}
