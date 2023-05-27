import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'package:http/http.dart' as http;

class Cadastro extends State<MyWidget> {
  
  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);

  TextStyle styleTitle = const TextStyle(fontFamily: 'Nunito', fontSize: 50.9);
  
  String emailCadastro = '';
  String passwordCadastro = '';
  String nomeCadastro = '';

  bool checkValueAdministrador = false;
  bool checkValueMentores = false;
  bool checkValueEmpresas = false;
  bool checkValueAluno = false;

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
          onPressed: () async{
            //Enviar para API --> Email, senha, nome e tipo de usuário
           final url = Uri.parse('http://127.0.0.1:5000/cadastro');

            if(checkValueAdministrador){
              final resquest = await http.post(url, body: {'email': emailCadastro, 'password': passwordCadastro, 'tipo_usuario': 'Administrador', 'nome': nomeCadastro});
              
            } else if(checkValueAluno){
              final resquest = await http.post(url, body: {'email': emailCadastro, 'password': passwordCadastro, 'tipo_usuario': 'Aluno', 'nome': nomeCadastro});
              
            } else if(checkValueEmpresas){
              final resquest = await http.post(url, body: {'email': emailCadastro, 'password': passwordCadastro, 'tipo_usuario': 'Empresa', 'nome': nomeCadastro});
              
            } else if(checkValueMentores){
              final resquest = await http.post(url, body: {'email': emailCadastro, 'password': passwordCadastro, 'tipo_usuario': 'Mentor', 'nome': nomeCadastro});
            }

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(nome: nomeCadastro)),
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

    final checkboxMentores = CheckboxListTile(
      contentPadding: const EdgeInsets.only(
          left: 60.0, top: 60.0, bottom: 0.0, right: 60.0),
      value: checkValueMentores,
      onChanged: (bool? value) {
        setState(() {
          checkValueMentores = value!;
          checkValueAdministrador = false;
          checkValueAluno = false;
          checkValueEmpresas = false;
        });
      },
      title: const Text('Mentor'),
      subtitle: const Text('Caso você seja um MENTOR, selecione essa opção'),
    );

    final checkboxEmpresa = CheckboxListTile(
      contentPadding: const EdgeInsets.only(
          left: 60.0, top: 60.0, bottom: 0.0, right: 60.0),
      value: checkValueEmpresas,
      onChanged: (bool? value) {
        setState(() {
          checkValueEmpresas = value!;
          checkValueAdministrador = false;
          checkValueAluno = false;
          checkValueMentores = false;
        });
      },
      title: const Text('Empresa'),
      subtitle: const Text('Caso você seja o responsável da EMPRESA, selecione essa opção'),
    );

    final checkboxAdministrador = CheckboxListTile(
      contentPadding: const EdgeInsets.only(
          left: 60.0, top: 60.0, bottom: 0.0, right: 60.0),
      value: checkValueAdministrador,
      onChanged: (bool? value) {
        setState(() {
          checkValueAdministrador = value!;
          checkValueMentores = false;
          checkValueAluno = false;
          checkValueEmpresas = false;
        });
      },
      title: const Text('Administrador'),
      subtitle:
          const Text('Caso você seja um ADMINISTRADOR, selecione essa opção'),
    );

    final checkboxAluno = CheckboxListTile(
      contentPadding: const EdgeInsets.only(
          left: 60.0, top: 60.0, bottom: 0.0, right: 60.0),
      value: checkValueAluno,
      onChanged: (bool? value) {
        setState(() {
          checkValueAluno = value!;
          checkValueAdministrador = false;
          checkValueMentores = false;
          checkValueEmpresas = false;
        });
      },
      title: const Text('Aluno'),
      subtitle: const Text('Caso você seja um ALUNO, selecione essa opção'),
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
                    padding:
                        const EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 150.0),
                    child: Column(
                      children: [
                        Text('Cadastro', style: styleTitle),
                        const SizedBox(height: 30.0),
                        nameField,
                        const SizedBox(height: 30.0),
                        emailField,
                        const SizedBox(height: 30.0),
                        passwordField,
                        const SizedBox(height: 30.0),
                        checkboxAluno,
                        checkboxMentores,
                        checkboxEmpresa,
                        checkboxAdministrador,
                        const SizedBox(height: 30.0),
                        buttonCadastro,
                        const SizedBox(height: 30.0),
                      ],
                    ),
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
