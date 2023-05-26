import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_app/admin_page.dart';
import 'cadastro.dart';
import 'dart:convert';
import 'aluno_page.dart';


class MyHomePage extends StatelessWidget {
  
  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9, fontWeight: FontWeight.normal);

  TextStyle styleTitle = const TextStyle(fontFamily: 'Nunito', fontSize: 50.9);

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

    final buttonLogin = ButtonTheme(
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
          onPressed: () async{
            final url = Uri.parse('http://127.0.0.1:5000/login');

            final response = await http.post(url, body: {'email': email, 'password': password});

            final jsonData = response.body;
            final parsedJson = jsonDecode(jsonData);
            final verificado = parsedJson['acesso'];
            final userType = parsedJson['Tipo_aluno'];

            print(userType.runtimeType);

            if(verificado == "OK"){
              print("passou");

            if(userType[0] == "Administrador"){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdminPageCall(userType: userType[0])),
              );
            }
            if (userType[0] == "Aluno"){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StudentPageCall(userType: userType[0])),
              );
            }
            }
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyWidget()),
            );
          },
          child: Text(
            "Cadastrar",
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
        child: Center(
          child: SizedBox(
            width: 700,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints.expand(),
                  padding: const EdgeInsets.fromLTRB(30.0, 250.0, 30.0, 150.0),
                  child: Column(
                    children: [
                      Text('Login', style: styleTitle),
                      const SizedBox(height: 30.0),
                      emailField,
                      const SizedBox(height: 30.0),
                      passwordField,
                      const SizedBox(height: 30.0),
                      buttonLogin,
                      const SizedBox(height: 30.0),
                      buttonCadastro,
                      const SizedBox(height: 30.0)
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
