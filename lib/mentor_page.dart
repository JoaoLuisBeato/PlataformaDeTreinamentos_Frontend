import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MentorPageCall extends StatefulWidget {
  final String userType;
  final String emailUser;

  MentorPageCall({required this.userType, required this.emailUser});

  @override
  MentorPage createState() => MentorPage();
}

class MentorPage extends State<MentorPageCall> {
  String _emailUser = '';

  TextStyle style = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black12);

  TextStyle styleAltUpdate = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black);

  TextStyle styleTitle = const TextStyle(
      fontFamily: 'Nunito', fontSize: 25.9, fontWeight: FontWeight.bold);

  TextStyle styleComplement = const TextStyle(
      fontFamily: 'Nunito', fontSize: 20, fontWeight: FontWeight.bold);

  TextStyle styleSubtitle = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.grey);

  TextStyle styleSubtitleSmall = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 12,
      fontWeight: FontWeight.normal,
      color: Colors.grey);

  TextStyle styleMainTitle =
      const TextStyle(fontFamily: 'Nunito', fontSize: 50.9);

  @override
  void initState() {
    super.initState();
    fetchTodosUsuarios();
  }

  List<dynamic> usuariosParaEscolherFromDB = [];
  List<String> usuariosParaEscolher = [];

  List<dynamic> relatorioAlunoBD = [];

  int selectedIndex = 0;
  String usuarioEscolhido = 'Escolha o aluno';

  Future<void> fetchTodosUsuarios() async {
    final response = await http
        .post(Uri.parse('http://127.0.0.1:5000/Listar_usuarios_para_mentor'));

    setState(() {
      usuariosParaEscolherFromDB = json.decode(response.body);

      for (int i = 0; i < usuariosParaEscolherFromDB.length; i++) {
        usuariosParaEscolher.add(usuariosParaEscolherFromDB[i]['email']);
      }
    });
  }

  Future<void> fetchDadosDoAluno(email) async {
    final url = Uri.parse('http://127.0.0.1:5000/Historico_aluno');
    final response = await http.post(url, body: {'email': email});

    setState(() {
      relatorioAlunoBD = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    _emailUser = widget.emailUser;

    Padding listagemDeAtividadesDoAluno() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 50),
        child: Container(
          height: 500,
          child: ListView.builder(
            itemCount: min(relatorioAlunoBD.length, 10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Text('Email do aluno:  ', style: styleTitle),
                      Text(relatorioAlunoBD[index]['email'],
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('ID do curso:  ', style: styleTitle),
                      Text(relatorioAlunoBD[index]['Codigo do curso'].toString(),
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('Status:  ', style: styleTitle),
                      Text(relatorioAlunoBD[index]['Status'],
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('Nota:  ', style: styleTitle),
                      Text(relatorioAlunoBD[index]['Nota'].toString(),
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Divider(
                      color: Colors.amber,
                      height: 2.0,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    }

    Center dropDownButtonUsuarios() {
      return Center(
        child: DropdownButton<String>(
          icon: const Icon(Icons.arrow_downward),
          style: styleAltUpdate,
          underline: Container(
            height: 2,
            color: Colors.amber,
          ),
          items: usuariosParaEscolher.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? selectedValue) {
            setState(() {
              usuarioEscolhido = selectedValue!;
              selectedIndex = usuariosParaEscolher.indexOf(selectedValue);
              fetchDadosDoAluno(usuarioEscolhido);
              MentorPageCall(emailUser: widget.emailUser, userType: widget.userType);
            });
          },
          hint: Center(
            child: Text(usuarioEscolhido, style: styleAltUpdate),
          ),
          dropdownColor: Colors.amber[200],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Bem-vindo Mentor, $_emailUser'), //<-- colocar $nomedisplay
        titleTextStyle: styleAltUpdate,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
            child: Column(
              children: [
                Text('Selecione um aluno', style: styleMainTitle),
                const SizedBox(height: 30.0),
                dropDownButtonUsuarios(),
                const SizedBox(height: 50.0),
                listagemDeAtividadesDoAluno()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
