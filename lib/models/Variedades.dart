 
// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Variedades.g.dart';

@JsonSerializable(explicitToJson: true)
class Variedades {
  String id;
  String tratamiento;
  String fase;
  String campo;
  String color;
  bool editable;

  Variedades({
    this.id = "",
    this.tratamiento = "",
    this.fase = "",
    this.campo = "",
    this.color = "",
    this.editable = true,
  });

  factory Variedades.fromJson(Map<String, dynamic> json) =>
      _$VariedadesFromJson(json);

  Map<String, dynamic> toJson() => _$VariedadesToJson(this);
}