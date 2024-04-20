import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';

class ElementRegistro extends StatelessWidget {
  final int mesCrecimiento;
  final String subtitle;
  final int index;
  final bool isComplet;
  final double complet;
  final void Function()? onPressed;
  final void Function(BuildContext) onPressedDelete;
  final void Function(BuildContext) onPressedEdit;

  const ElementRegistro({
    super.key,
    required this.index,
    required this.onPressed,
    required this.onPressedDelete,
    required this.subtitle,
    required this.onPressedEdit,
    required this.isComplet,
    required this.complet,
    required this.mesCrecimiento,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: ValueKey(index),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          children: [
            SlidableAction(
              onPressed: onPressedDelete,
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Eliminar',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onPressedEdit,
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit_document,
              label: 'Modificar datos',
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(
                    0, 3), // Cambia la dirección de la sombra (eje x, eje y)
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 80,
                  child: ListTile(
                    title: Text(
                      "Mes de crecimiento: $mesCrecimiento",
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text("Fecha de creacion: $subtitle"),
                    onTap: onPressed,
                  )),
              Expanded(
                flex: 20,
                child: Column(
                  children: [
                    if (isComplet)
                      const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    else
                      CircularProgressIndicator(
                        value:
                            complet, // Aquí puedes poner el porcentaje de completado (entre 0 y 1)
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                        backgroundColor: Colors.grey.shade200,
                      ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
