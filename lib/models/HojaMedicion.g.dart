// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HojaMedicion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HojaMedicion _$HojaMedicionFromJson(Map<String, dynamic> json) => HojaMedicion(
      id: json['id'] as String? ?? "",
      fechaCreacion: json['fechaCreacion'] == null
          ? null
          : DateTime.parse(json['fechaCreacion'] as String),
      mesCrecimiento: json['mesCrecimiento'] as int? ?? 0,
      experimento: json['experimento'] as String? ?? "",
      sincronizado: json['sincronizado'] as bool? ?? false,
      listaRegistros: (json['listaRegistros'] as List<dynamic>?)
          ?.map((e) => Registro.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HojaMedicionToJson(HojaMedicion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fechaCreacion': instance.fechaCreacion?.toIso8601String(),
      'mesCrecimiento': instance.mesCrecimiento,
      'experimento': instance.experimento,
      'sincronizado': instance.sincronizado,
      'listaRegistros':
          instance.listaRegistros?.map((e) => e.toJson()).toList(),
    };
