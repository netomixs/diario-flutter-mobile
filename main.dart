import 'package:diario/controllers/login_controller.dart';
import 'package:diario/firebase_options.dart';
import 'package:diario/ui/dashboard_screen.dart';
import 'package:diario/ui/login_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
 
 
Future<void> main() async {
  // Habilitar la persistencia
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

Future<FirebaseApp> inicializateFirebase() async {
  FirebaseApp firebaseApp = (await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ));
  FirebaseDatabase.instance
      .setPersistenceEnabled(true); // Habilitar la persistencia

  return firebaseApp;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  body: LoginScreen(),

      body: FutureBuilder(
        future: inicializateFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (LoginController.isLogIn(context)) {
              return const DashBoardScreen();
            } else {
              return const LoginScreen();
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
