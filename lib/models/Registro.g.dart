// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Registro.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Registro _$RegistroFromJson(Map<String, dynamic> json) => Registro(
      sincronizado: json['sincronizado'] as bool? ?? false,
      id: json['id'] as String? ?? "",
      promedio: (json['promedio'] as num?)?.toDouble() ?? 0.0,
      parcela: json['parcela'] as String? ?? "",
      completado: json['completado'] as bool? ?? false,
      listaSurcos: (json['listaSurcos'] as List<dynamic>?)
          ?.map((e) => Surco.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RegistroToJson(Registro instance) => <String, dynamic>{
      'sincronizado': instance.sincronizado,
      'id': instance.id,
      'promedio': instance.promedio,
      'parcela': instance.parcela,
      'completado': instance.completado,
      'listaSurcos': instance.listaSurcos?.map((e) => e.toJson()).toList(),
    };
