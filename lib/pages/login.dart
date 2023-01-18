// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytext.dart';
import 'SignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;
  String keyd = '';
  String formated = '';
  login() async {
    isLoading = true;
    setState(() {});
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      keyd = auth.currentUser?.email ?? '';
      formated = keyd.substring(0, keyd.indexOf('@'));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text("Welcome")));
      email.clear();
      password.clear();
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text("wrong email or password")));
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20, top: 30, right: 20),
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Email",
                  border: OutlineInputBorder()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  hintText: "Password",
                  border: OutlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                login();
                // print(email.text);
                // print(password.text);
              },
              child: Text("Login"))
        ],
      ),
    );
  }
}
