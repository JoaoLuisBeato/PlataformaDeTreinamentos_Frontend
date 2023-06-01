import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ResultsSearchCall extends StatefulWidget {
  final String userType;
  final String emailUser;

  const ResultsSearchCall({required this.userType, required this.emailUser});

  @override
  ResultsSearchPage createState() => ResultsSearchPage();
}

class ResultsSearchPage extends State<ResultsSearchCall> {
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
    fetchTodasEmpresas();
  }

  List<dynamic> treinamentosParaEscolherFromDB = [];
  List<String> treinamentosParaEscolher = [];

  List<dynamic> relatorioTreinamentoBD = [];

  int selectedIndex = 0;
  String treinamentoEscolhido = 'Escolha o treinamento';

  Future<void> fetchTodasEmpresas() async {
    final url = Uri.parse('http://127.0.0.1:5000/vaga_empresa_listar');

    final response =
        await http.post(url, body: {'email_empresa': widget.emailUser});

    setState(() {
      treinamentosParaEscolherFromDB = json.decode(response.body);

      for (int i = 0; i < treinamentosParaEscolherFromDB.length; i++) {
        treinamentosParaEscolher
            .add(treinamentosParaEscolherFromDB[i]['Codigo do curso']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    Padding listagemDeAtividadesDoAluno() {

      final atividadesFiltradas = treinamentosParaEscolherFromDB.where((atividade) =>
      atividade['Codigo do curso'] == treinamentoEscolhido);

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 50),
        child: Container(
          height: 500,
          child: ListView.builder(
            itemCount: atividadesFiltradas.length,
            itemBuilder: (context, index) {
              if(treinamentosParaEscolherFromDB[index]['Codigo do curso'] == treinamentoEscolhido){
              return Column(
                children: [
                  Row(
                    children: [
                      Text('Email do aluno:  ', style: styleTitle),
                      Text(treinamentosParaEscolherFromDB[index]['email'],
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('ID do curso:  ', style: styleTitle),
                      Text(
                          treinamentosParaEscolherFromDB[index]['Codigo do curso']
                              .toString(),
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('Status:  ', style: styleTitle),
                      Text(treinamentosParaEscolherFromDB[index]['Status'],
                          style: styleAltUpdate),
                      const SizedBox(width: 30),
                      Text('Nota:  ', style: styleTitle),
                      Text(treinamentosParaEscolherFromDB[index]['Nota'].toString(),
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
              }
            },
          ),
        ),
      );
    }

    Center dropDownButtonTreinamentos() {
      return Center(
        child: DropdownButton<String>(
          icon: const Icon(Icons.arrow_downward),
          style: styleAltUpdate,
          underline: Container(
            height: 2,
            color: Colors.amber,
          ),
          items: treinamentosParaEscolher.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? selectedValue) {
            setState(() {
              treinamentoEscolhido = selectedValue!;
              selectedIndex = treinamentosParaEscolher.indexOf(selectedValue);
              fetchTodasEmpresas();
              ResultsSearchCall(
                  emailUser: widget.emailUser, userType: widget.userType);
            });
          },
          hint: Center(
            child: Text(treinamentoEscolhido, style: styleAltUpdate),
          ),
          dropdownColor: Colors.amber[200],
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
          child: Column(
            children: [
              Text('Selecione um treinamento', style: styleMainTitle),
              const SizedBox(height: 30.0),
              dropDownButtonTreinamentos(),
              const SizedBox(height: 50.0),
              listagemDeAtividadesDoAluno()
            ],
          ),
        ),
      ),
    );
  }
}
