// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Surco.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surco _$SurcoFromJson(Map<String, dynamic> json) => Surco(
      id: json['id'] as String? ?? "",
      numero_surco: json['numero_surco'] as int? ?? 0,
      cantidad_tallos: json['cantidad_tallos'] as int? ?? 0,
      tallosLista: (json['tallosLista'] as List<dynamic>?)
          ?.map((e) => Tallo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurcoToJson(Surco instance) => <String, dynamic>{
      'id': instance.id,
      'numero_surco': instance.numero_surco,
      'cantidad_tallos': instance.cantidad_tallos,
      'tallosLista': instance.tallosLista?.map((e) => e.toJson()).toList(),
    };
