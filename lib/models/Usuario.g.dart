// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Usuario _$UsuarioFromJson(Map<String, dynamic> json) => Usuario(
      json['nombre'] as String?,
      json['apellidoP'] as String?,
      json['apellidoM'] as String?,
      json['correo'] as String?,
      json['id'] as String?,
    );

Map<String, dynamic> _$UsuarioToJson(Usuario instance) => <String, dynamic>{
      'nombre': instance.nombre,
      'apellidoP': instance.apellidoP,
      'apellidoM': instance.apellidoM,
      'correo': instance.correo,
      'id': instance.id,
    };
