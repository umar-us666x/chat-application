import 'package:chat_application/widget/form_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  void submitForm(
      String username, String email, String password, bool isLogin) async {
    // UNTUK MENJALANKAN LOGIN
    try {
      if (isLogin) {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        final result = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        FirebaseFirestore.instance
            .collection('users')
            .doc(result.user!.uid)
            .set({
          'username': username,
          'email': email,
        });
      }
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: FormAuth(submitForm: submitForm),
    );
  }
}
