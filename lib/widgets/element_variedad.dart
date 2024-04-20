import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_slidable/flutter_slidable.dart';

class ElementVariedad extends StatelessWidget {
  final String title;
  final String subtitle;
  final int index;
  final Color? color;
  final bool isTestigo;
  final bool isSelect;
  final void Function()? onPressed;
  final void Function(BuildContext) onPressedDelete;
  const ElementVariedad({
    super.key,
    required this.title,
    required this.index,
    required this.onPressed,
    required this.onPressedDelete,
    required this.subtitle,
    required this.isTestigo,
    this.color,
    required this.isSelect,
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
      child: Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: isSelect
                ? const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2)
                : const Color.fromARGB(
                    255, 255, 255, 255), // Establece el color del borde aquí
            width: 2.0,
          ),
        )),
        child: Container(
          color: isSelect ? color?.withOpacity(0.6) : color,
          child: ListTile(
            title: Text(
              "Tratamiento: $title",
              style: const TextStyle(color: Colors.black),
            ),
            subtitle: Text("Campo:  $subtitle",
                style: const TextStyle(color: Colors.black)),
            trailing: Checkbox(value: isTestigo, onChanged: (bool? value) {}),
            onTap: onPressed,
          ),
        ),
      ),
    );
  }
}
