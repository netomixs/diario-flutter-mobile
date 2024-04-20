// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Experimento.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Experimento _$ExperimentoFromJson(Map<String, dynamic> json) => Experimento(
      id: json['id'] as String? ?? "",
      nombre: json['nombre'] as String? ?? "",
      inicio: json['inicio'] == null
          ? null
          : DateTime.parse(json['inicio'] as String),
      fin: json['fin'] == null ? null : DateTime.parse(json['fin'] as String),
      variedadTestigo: json['variedadTestigo'] as String? ?? "",
      numeroVariedades: json['numeroVariedades'] as int? ?? 0,
      listaHojaMediciones: (json['listaHojaMediciones'] as List<dynamic>?)
          ?.map((e) => HojaMedicion.fromJson(e as Map<String, dynamic>))
          .toList(),
      listaParcelas: (json['listaParcelas'] as List<dynamic>?)
          ?.map((e) => Parcela.fromJson(e as Map<String, dynamic>))
          .toList(),
      listaVariedades: (json['listaVariedades'] as List<dynamic>?)
          ?.map((e) => Variedades.fromJson(e as Map<String, dynamic>))
          .toList(),
      usuario: json['usuario'] as String? ?? "",
      sincronizado: json['sincronizado'] as bool? ?? false,
      editableParcel: json['editableParcel'] as bool? ?? true,
      editableRegistro: json['editableRegistro'] as bool? ?? false,
    );

Map<String, dynamic> _$ExperimentoToJson(Experimento instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nombre': instance.nombre,
      'inicio': instance.inicio?.toIso8601String(),
      'fin': instance.fin?.toIso8601String(),
      'variedadTestigo': instance.variedadTestigo,
      'numeroVariedades': instance.numeroVariedades,
      'listaHojaMediciones':
          instance.listaHojaMediciones?.map((e) => e.toJson()).toList(),
      'listaParcelas': instance.listaParcelas?.map((e) => e.toJson()).toList(),
      'listaVariedades':
          instance.listaVariedades?.map((e) => e.toJson()).toList(),
      'usuario': instance.usuario,
      'sincronizado': instance.sincronizado,
      'editableParcel': instance.editableParcel,
      'editableRegistro': instance.editableRegistro,
    };
