// ignore_for_file: non_constant_identifier_names, file_names

import 'package:json_annotation/json_annotation.dart';

import 'Tallo.dart';

part 'Surco.g.dart';

@JsonSerializable(explicitToJson: true)
class Surco {
  String id;
  int numero_surco;
  int cantidad_tallos;
  List<Tallo>? tallosLista;

  Surco({
    this.id = "",
    this.numero_surco = 0,
    this.cantidad_tallos = 0,
    this.tallosLista,
  });

  factory Surco.fromJson(Map<String, dynamic> json) => _$SurcoFromJson(json);

  Map<String, dynamic> toJson() => _$SurcoToJson(this);
}