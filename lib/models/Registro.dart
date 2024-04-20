// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Surco.dart';

part 'Registro.g.dart';

@JsonSerializable(explicitToJson: true)
class Registro {
  bool sincronizado;
  String id;
  double promedio;
  String parcela;
  bool completado;
  List<Surco>? listaSurcos;

  Registro({
    this.sincronizado = false,
    this.id = "",
    this.promedio = 0.0,
    this.parcela = "",
    this.completado = false,
    this.listaSurcos ,
  });

  factory Registro.fromJson(Map<String, dynamic> json) =>
      _$RegistroFromJson(json);

  Map<String, dynamic> toJson() => _$RegistroToJson(this);
}
