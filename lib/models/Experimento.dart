// ignore_for_file: file_names

import 'package:diario/models/HojaMedicion.dart';
import 'package:diario/models/Parcela.dart';
import 'package:diario/models/Variedades.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Experimento.g.dart';

@JsonSerializable(explicitToJson: true)
class Experimento {
  String id;
  String nombre;
  DateTime? inicio;
  DateTime? fin;
  String variedadTestigo;
  int numeroVariedades;
  List<HojaMedicion>? listaHojaMediciones=[];
  List<Parcela>? listaParcelas=[];
  List<Variedades>? listaVariedades=[];
  String usuario;
  bool sincronizado;
  bool editableParcel;
  bool editableRegistro;

  Experimento({
    this.id = "",
    this.nombre = "",
    this.inicio,
    this.fin,
    this.variedadTestigo = "",
    this.numeroVariedades = 0,
    this.listaHojaMediciones,
    this.listaParcelas,
    this.listaVariedades,
    this.usuario = "",
    this.sincronizado = false,
    this.editableParcel = true,
    this.editableRegistro = false,
  });

  factory Experimento.fromJson(Map<String, dynamic> json) =>
      _$ExperimentoFromJson(json);

  Map<String, dynamic> toJson() => _$ExperimentoToJson(this);
}
