// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'Parcela.g.dart';

@JsonSerializable(explicitToJson: true)
class Parcela {
  String id;
  String variedad;
  int numero;
  String usuario;
  int posicion;
  int repeticion;
  bool editable;

  Parcela({
   this.id = "",
    this.variedad = "",
    this.numero = 0,
    this.usuario = "",
    this.posicion = 0,
    this.repeticion = 0,
    this.editable = true,
  });

  factory Parcela.fromJson(Map<String, dynamic> json) =>
      _$ParcelaFromJson(json);

  Map<String, dynamic> toJson() => _$ParcelaToJson(this);
}
