import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatelessWidget {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.9);
  String email = '';
  String password = '';
  String nome = '';

  MyHomePage({required this.nome});

  @override
  Widget build(BuildContext context) {
    final emailField = SizedBox(
      width: 500,
      child: TextField(
        onChanged: (text) {
          email = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final passwordField = SizedBox(
      width: 500,
      child: TextField(
        onChanged: (text) {
          password = text;
        },
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.yellow[200]!,
              Colors.white,
            ],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 700,
            child: Center(
              child: Container(
                constraints: const BoxConstraints.expand(),
                padding: const EdgeInsets.fromLTRB(30.0, 250.0, 30.0, 150.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30.0),
                    emailField,
                    const SizedBox(height: 30.0),
                    passwordField,
                    const SizedBox(height: 30.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
