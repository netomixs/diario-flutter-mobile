import 'package:flutter/material.dart';

class TextButtonSimple extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final EdgeInsets margin;
  final MainAxisAlignment align;
  const TextButtonSimple({super.key,
  required this.text,
  required this.onPressed,
  required this.margin,
  required this.align});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:margin,
      child: Row(
        mainAxisAlignment: align,
      children: [TextButton(
      
      onPressed: onPressed,
      child:  Text(
        text,
        textAlign: TextAlign.right,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.blue,
          fontSize: 14.0,
        ),
      ),
    
    ),],
    
      
    ),);
  }
}