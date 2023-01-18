import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../utility/TextfieldWidget.dart';
import '../utility/buttonWidget.dart';
import '../utility/imagewidget.dart';
import '../utility/mytext.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  void registrate() async {
    isLoading = true;
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      print(password.text);
      email.clear();
      password.clear();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(title: Text('Registration')),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, top: 30, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter your email';
                    }
                  },
                  controller: email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                      border: OutlineInputBorder()),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10, right: 20),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'please enter your password';
                    }
                  },
                  obscureText: true,
                  controller: password,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      hintText: "Password",
                      border: OutlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    registrate();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Successfully registered')),
                    );
                  }
                },
                child: const Text('Registrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
