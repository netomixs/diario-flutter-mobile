import 'package:diario/controllers/data_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Usuario.dart';
import 'package:flutter/foundation.dart';

class DataUser extends ChangeNotifier {
  List<Experimento>? listaExperimentos = [];
  Usuario? user;
  List<Experimento>? get experimento => listaExperimentos;
  Usuario? get usuario => user;
  void updateData(
      List<Experimento>? updtalistaExperimentos, Usuario? userData) {
    listaExperimentos = updtalistaExperimentos;
    user = userData;
    notifyListeners();
  }

  Future<void> updateExperimentos(String id) async {
    listaExperimentos = await DataController.getExperimentos();
    notifyListeners();
  }
}
