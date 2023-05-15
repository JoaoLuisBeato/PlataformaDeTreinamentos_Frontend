import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MyHomePage extends StatelessWidget {

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.9);

  String email = '';
  String password = '';

  

  @override
  Widget build(BuildContext context) {
     
    final emailField = TextField(
        onChanged: (text){
          email = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
        ), 
    );

    final passwordField = TextField(
        onChanged: (text){
          password = text;
        },
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
        ), 
    );

    final buttonCadastro = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Container(
        child: ElevatedButton(
          child: Text("Cadastrar", textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          onPressed: ((){
            final url = Uri.parse('http://127.0.0.1:5000/cadastro');
            http.post(url, body: {'email': email, 'password': password});

          }),
        ),
      ),
         
    );

    final buttonLogin = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: Container(
        child: ElevatedButton(
          child: Text("Login", textAlign: TextAlign.center,
          style: style.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold
          )),
          onPressed: ((){
            final url = Uri.parse('http://127.0.0.1:5000/login');
            http.post(url, body: {'email': email, 'password': password});
          
          }),
        ),
      ),
         
    );
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Login")
      ),

      body: Center(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              SizedBox(height: 30.0),emailField,
              SizedBox(height: 30.0),passwordField,
              SizedBox(height: 30.0),buttonCadastro,
              SizedBox(height: 30.0),buttonLogin,

              Text('')
            ],
          ),

        ),
      )

      

    );
  }
}
