import 'package:diario/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../ui/dashboard_screen.dart';

class LoginServices {
  static Future<String> loginWhithEmailPassword({
    required String email,
    required String password,
    // ignore: avoid_types_as_parameter_names
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      //  print(userCredential.user);
      user = userCredential.user;
      if (user != null) {
        if (user.emailVerified) {
          return "OK";
        } else {
          return "non-verification";
        }
      } else {
        return "error";
      }
    } on FirebaseAuthException catch (e) {
     //("Code errororjmewin "+ e.code);
      return e.code;
    }
  }

  static void isLogged(BuildContext context) {
    
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    }
  }

  static bool isLogIn(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> logOut(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut().then((value) => {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()))
        });
  }

  static User? getUser(){
       FirebaseAuth auth = FirebaseAuth.instance;
       return auth.currentUser;
  }
  static Future<void> setRecoveryPasswordNotification(String email)async {
       FirebaseAuth auth = FirebaseAuth.instance;
      return auth.sendPasswordResetEmail(email: email);
  }
}
