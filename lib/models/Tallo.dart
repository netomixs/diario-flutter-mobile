// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Tallo.g.dart'; // This points to the generated code file

@JsonSerializable(explicitToJson: true)
class Tallo {
  String id;
  // ignore: non_constant_identifier_names
  int numero_tallo;
  int medida;

  Tallo({
    this.id = "",
    // ignore: non_constant_identifier_names
    this.numero_tallo = 0,
    this.medida = 0,
  });

  // A factory constructor to create a Tallo instance from a JSON map
  factory Tallo.fromJson(Map<String, dynamic> json) => _$TalloFromJson(json);

  // A method to convert a Tallo instance to a JSON map
  Map<String, dynamic> toJson() => _$TalloToJson(this);
}
 

