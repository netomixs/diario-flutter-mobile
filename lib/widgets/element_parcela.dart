import 'package:flutter/material.dart';

class ElementParcel extends StatelessWidget {
  final Color color;
  final String text;
  final int keyValue;
  final bool isSelect;
  final void Function()? onPressed;
  final double size;
  final bool isComplete;
  const ElementParcel(
      {super.key,
      required this.color,
      required this.text,
      required this.keyValue,
      required this.size,
      this.onPressed,
      required this.isSelect,
      required this.isComplete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        key: key,
        width: size, // Tamaño horizontal deseado del Card
        height: size / 2,
        child: InkWell(
          key: key,
          onTap: onPressed,
          child: Card(
            key: ValueKey(keyValue),
            color: isSelect ? color.withOpacity(.5) : color,
            child: Stack(
              children: [
                Center(
                  key: ValueKey(keyValue),
                  child: Text(
                    key: ValueKey(keyValue),
                    text,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                if(isComplete) const Positioned(
                  child: Icon(
                    Icons.check,
                    color:  Colors.green ,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
