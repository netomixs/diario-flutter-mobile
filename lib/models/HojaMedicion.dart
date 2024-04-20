// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

import 'Registro.dart';

part 'HojaMedicion.g.dart';

@JsonSerializable(explicitToJson: true)
class HojaMedicion {
  String id;
  DateTime? fechaCreacion;
  int mesCrecimiento;
  String experimento;
  bool sincronizado;
  List<Registro>? listaRegistros;

  HojaMedicion({
    this.id = "",
    this.fechaCreacion,
    this.mesCrecimiento = 0,
    this.experimento = "",
    this.sincronizado = false,
    this.listaRegistros ,
  });

  factory HojaMedicion.fromJson(Map<String, dynamic> json) =>
      _$HojaMedicionFromJson(json);

  Map<String, dynamic> toJson() => _$HojaMedicionToJson(this);
}