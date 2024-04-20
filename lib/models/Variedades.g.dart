// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Variedades.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Variedades _$VariedadesFromJson(Map<String, dynamic> json) => Variedades(
      id: json['id'] as String? ?? "",
      tratamiento: json['tratamiento'] as String? ?? "",
      fase: json['fase'] as String? ?? "",
      campo: json['campo'] as String? ?? "",
      color: json['color'] as String? ?? "",
      editable: json['editable'] as bool? ?? true,
    );

Map<String, dynamic> _$VariedadesToJson(Variedades instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tratamiento': instance.tratamiento,
      'fase': instance.fase,
      'campo': instance.campo,
      'color': instance.color,
      'editable': instance.editable,
    };
