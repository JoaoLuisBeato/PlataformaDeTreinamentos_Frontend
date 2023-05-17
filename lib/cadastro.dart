import 'package:flutter/material.dart';
import 'myhomepage.dart';

class Cadastro extends State<MyWidget> {
  TextStyle style = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.9);
  String emailCadastro = '';
  String passwordCadastro = '';
  String nomeCadastro = '';

  @override
  Widget build(BuildContext context) {
    final nameField = SizedBox(
      width: 500,
      child: TextField(
        onChanged: (text) {
          nomeCadastro = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome do usuário",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final emailField = SizedBox(
      width: 500,
      child: TextField(
        onChanged: (text) {
          emailCadastro = text;
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
          passwordCadastro = text;
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

    final buttonCadastro = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: ButtonTheme(
        minWidth: 200.0,
        height: 150.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            //Enviar para API --> Email, senha, nome e tipo de usuário
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePage(nome: nomeCadastro)),
            );
          },
          child: Text(
            "Completar Cadastro",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 700,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 150.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 30.0),
                      nameField,
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
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  Cadastro createState() => Cadastro();
}
