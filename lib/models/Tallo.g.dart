// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Tallo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tallo _$TalloFromJson(Map<String, dynamic> json) => Tallo(
      id: json['id'] as String? ?? "",
      numero_tallo: json['numero_tallo'] as int? ?? 0,
      medida: json['medida'] as int? ?? 0,
    );

Map<String, dynamic> _$TalloToJson(Tallo instance) => <String, dynamic>{
      'id': instance.id,
      'numero_tallo': instance.numero_tallo,
      'medida': instance.medida,
    };
