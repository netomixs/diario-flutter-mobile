// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';
part 'Usuario.g.dart';
@JsonSerializable()
class Usuario {
  String? nombre = "";
  String? apellidoP = "";
  String? apellidoM = "";
  String? correo = "";
  String? id = "0";

   Usuario(this.nombre, this.apellidoP, this.apellidoM, this.correo,
     this.id);

  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);
}
