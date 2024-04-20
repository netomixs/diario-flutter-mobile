import 'package:diario/controllers/data_controller.dart';
import 'package:diario/controllers/login_controller.dart';
import 'package:diario/models/Experimento.dart';
import 'package:diario/models/Usuario.dart';
import 'package:diario/ui/experimentos_list_freagment.dart';
import 'package:diario/ui/new_experimento.dart';
import 'package:diario/ui/perfil_user.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:connectivity_plus/connectivity_plus.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

String currelyText = "Experimentos";
Widget scrennCuncurry = const ExperimentoListFragment();
List<Experimento>? listaExperimento = [];
TextEditingController textEditingController = TextEditingController();
TextEditingController dateController = TextEditingController();
Usuario user = Usuario("", "", "", "", "");
bool isLoad = false;
bool showFab = true;
bool hasInternetConnection = true; // Estado inicial asumiendo que hay conexión

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      hasInternetConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(currelyText),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewExperimento(),
                    ),
                  );
                  _actualizarScrenn();
                },
                tooltip: 'Agregar experimento',
                child: const Icon(Icons.add),
              )
            : null,
        drawer: Drawer(
          
          child: ListView(
            children: <Widget>[
              FutureBuilder<Usuario>(
                  future: DataController.loadUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const DrawerHeader(
                        decoration: BoxDecoration(color: Colors.white),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return const UserAccountsDrawerHeader(
                          currentAccountPicture: CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                AssetImage("assets/img/avatar_logo.png"),
                          ),
                          accountName: Text(
                            "Error al cargar nombre",
                            style: TextStyle(color: Colors.black),
                          ),
                          accountEmail: Text("Error al cargar correo",
                              style: TextStyle(color: Colors.black)));
                    } else {
                      user = snapshot.data!;
                      return UserAccountsDrawerHeader(
                        accountName: Text(
                            "${user.nombre} ${user.apellidoP} ${user.apellidoM}",
                            style: const TextStyle(color: Colors.black)),
                        accountEmail: Text("${""}",
                            style: const TextStyle(color: Colors.black)),
                        currentAccountPicture: ClipRRect(
                          borderRadius: BorderRadius.circular(110),
                          child: Image.asset(
                            "assets/img/avatar_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }
                  }),
              ListTile(
                leading: const Icon(Icons.assessment),
                title: const Text("Experimentos"),
                onTap: () {
                  if (currelyText != "Experimentos") {
                    setState(() {
                      showFab = true;
                      currelyText = "Experimentos";
                      scrennCuncurry = const ExperimentoListFragment();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Perfil"),
                onTap: () {
                  if (currelyText != "Perfil") {
                    setState(() {
                      showFab = false;
                      currelyText = "Perfil";
                      scrennCuncurry = const PerfilUser();
                    });

                    Navigator.pop(context);
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Cerrar sesión"),
                onTap: () {
                  if (currelyText != "Cerrar sesión") {
                    currelyText = "Cerrar sesión";
                    LoginController.logOut(context);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
        body: scrennCuncurry);
  }

  Future<void> _actualizarScrenn() async {
    setState(() {
      Key experimentoListKey = UniqueKey();
      scrennCuncurry = const Column();
      showFab = true;
      currelyText = "Experimentos";
      scrennCuncurry = ExperimentoListFragment(key: experimentoListKey);
    });
  }
}
