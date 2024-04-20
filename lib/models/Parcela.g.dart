// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Parcela.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parcela _$ParcelaFromJson(Map<String, dynamic> json) => Parcela(
      id: json['id'] as String? ?? "",
      variedad: json['variedad'] as String? ?? "",
      numero: json['numero'] as int? ?? 0,
      usuario: json['usuario'] as String? ?? "",
      posicion: json['posicion'] as int? ?? 0,
      repeticion: json['repeticion'] as int? ?? 0,
      editable: json['editable'] as bool? ?? true,
    );

Map<String, dynamic> _$ParcelaToJson(Parcela instance) => <String, dynamic>{
      'id': instance.id,
      'variedad': instance.variedad,
      'numero': instance.numero,
      'usuario': instance.usuario,
      'posicion': instance.posicion,
      'repeticion': instance.repeticion,
      'editable': instance.editable,
    };
