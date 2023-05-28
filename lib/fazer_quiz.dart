import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:core';

class FazerQuizCall extends StatefulWidget {
  final int randId;

  FazerQuizCall({required this.randId});

  @override
  FazerQuiz createState() => FazerQuiz();
}

class FazerQuiz extends State<FazerQuizCall> {
  int randId = 0;
  List<dynamic> dataListQuestoesBD = [];
  List<String> dataListRespostas = [];

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
      fontFamily: 'Nunito', fontSize: 30.9, fontWeight: FontWeight.bold);

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

  Future<void> fetchDataFromAPI() async {
    final url = Uri.parse('http://127.0.0.1:5000/Listar_teste');
    final response =
        await http.post(url, body: {'id': widget.randId.toString()});

    setState(() {
      dataListQuestoesBD = json.decode(response.body);

      for (int i = 0; i < dataListQuestoesBD.length; i++) {
    
      dataListQuestoesBD[i]['alternativa_a'] = false;
      dataListQuestoesBD[i]['alternativa_b'] = false;
      dataListQuestoesBD[i]['alternativa_c'] = false;
    }
    });
  }

  bool checkAlternativaA = false;
  bool checkAlternativaB = false;
  bool checkAlternativaC = false;

  @override
  Widget build(BuildContext context) {
    randId = widget.randId;

    checkAlternativaA = false;
    checkAlternativaB = false;
    checkAlternativaC = false;

    Column returnAnswers(index, listAnswers, listAnswersToAPI) {

      print(listAnswers[index]['alternativa_a']);
      
      return Column(
        children: [
          SizedBox(
            width: 800,
            height: 50,
            child: Text(
                '${index + 1}-) ${dataListQuestoesBD[index]['questao']}',
                style: styleAltUpdate),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_a'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_a';
                listAnswers[index]['alternativa_a'] = value!;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_a'], style: styleAltUpdate),
            ),
          ),


          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_b'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_b';
                listAnswers[index]['alternativa_b'] = value!;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_b'], style: styleAltUpdate),
            ),
          ),


          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 220, vertical: 5),
            value: listAnswers[index]['alternativa_c'],
            onChanged: (bool? value) {
              setState(() {
                listAnswersToAPI[index] = 'alternativa_c';
                listAnswers[index]['alternativa_c'] = value!;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_c'], style: styleAltUpdate),
            ),
          ),
        ],
      );
      /*
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 420, vertical: 5),
            value: listAnswers[index].alternativaB,
            onChanged: (bool? value) {
              setState(() {
                listAnswers[index].alternativaB = value!;
                checkAlternativaB = listAnswers[index].alternativaB;
                listAnswers[index].alternativaA = false;
                listAnswers[index].alternativaC = false;
              });
            },
            title: SizedBox(
              child: TextField(
                onChanged: (text) {
                  listAnswers[index].respostaDaAlternativaB = text;
                  respostaB = listAnswers[index].respostaDaAlternativaB;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  labelText: "Resposta da alternativa B",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 420, vertical: 5),
            value: listAnswers[index].alternativaC,
            onChanged: (bool? value) {
              setState(() {
                listAnswers[index].alternativaC = value!;
                checkAlternativaC = listAnswers[index].alternativaC;
                listAnswers[index].alternativaA = false;
                listAnswers[index].alternativaB = false;
              });
            },
            title: SizedBox(
              child: TextField(
                onChanged: (text) {
                  listAnswers[index].respostaDaAlternativaC = text;
                  respostaC = listAnswers[index].respostaDaAlternativaC;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  labelText: "Resposta da alternativa C",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
        ],
      );*/
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text('Fazer QUIZ'),
          titleTextStyle: styleAltUpdate,
          automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 200.0),
        child: ListView.builder(
          itemCount: dataListQuestoesBD.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  title: Text(dataListQuestoesBD[index]['numero_questao'],
                      style: styleTitle),
                ),
                returnAnswers(index, dataListQuestoesBD, dataListRespostas),
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
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FloatingActionButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          title: Text('Enviar QUIZ?'),
                          content: Text('As alternativas foram assinaladas?'),
                          actions: [/*submit e cancel*/],
                        );
                      });
                },
                child: const Text('Enviar'),
              ),
              const SizedBox(width: 30),
            ]),
          ]),
    );
  }
}
