import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class CompletedPageCall extends StatefulWidget {
  String emailUser;

  CompletedPageCall({required this.emailUser});

  @override
  CompletedPage createState() => CompletedPage();
}

class CompletedPage extends State<CompletedPageCall> {
  String emailUser = '';

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
    fetchDataFromAPI();
  }

  List<dynamic> relatorioAlunoBD = [];

  Future<void> fetchDataFromAPI() async {
    final url = Uri.parse('http://127.0.0.1:5000/Historico_aluno');
    final response = await http.post(url, body: {'email': widget.emailUser});

    setState(() {
      relatorioAlunoBD = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    emailUser = widget.emailUser;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 50),
      child: ListView.builder(
        itemCount: relatorioAlunoBD.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Text('Email do aluno:  ', style: styleTitle),
                  Text(relatorioAlunoBD[index]['email'], style: styleAltUpdate),
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
    );
  }
}
