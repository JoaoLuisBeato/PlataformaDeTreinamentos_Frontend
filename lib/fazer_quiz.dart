import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class FazerQuizCall extends StatefulWidget {
  final int randId;
  final String emailUser;

  const FazerQuizCall({required this.randId, required this.emailUser});

  @override
  FazerQuiz createState() => FazerQuiz();
}

class FazerQuiz extends State<FazerQuizCall> {
  int randId = 0;
  String emailUser = '';

  List<dynamic> dataListQuestoesBD = [];
  List<String> dataListRespostas = [];
  List<dynamic> dataListTesteDeAptidao = [];
  List<dynamic> dataListCase1 =[];
  List<dynamic> dataListCase2 =[];

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
        dataListRespostas.add('alternativa_a');
      }

      int tamanhoParte1 = (dataListQuestoesBD.length / 3).ceil();
      int tamanhoParte2 = (dataListQuestoesBD.length / 3).floor();

      dataListTesteDeAptidao = dataListQuestoesBD.sublist(0, tamanhoParte1);
      dataListCase1 = dataListQuestoesBD.sublist(tamanhoParte1, tamanhoParte1 + tamanhoParte2);
      dataListCase2 = dataListQuestoesBD.sublist(tamanhoParte1 + tamanhoParte2);
    });
  }

  @override
  Widget build(BuildContext context) {
    randId = widget.randId;
    emailUser = widget.emailUser;

    Column returnAnswers(index, listAnswers, listAnswersToAPI) {
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
                listAnswers[index]['alternativa_b'] = false;
                listAnswers[index]['alternativa_c'] = false;
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
                listAnswers[index]['alternativa_a'] = false;
                listAnswers[index]['alternativa_c'] = false;
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
                listAnswers[index]['alternativa_b'] = false;
                listAnswers[index]['alternativa_a'] = false;
              });
            },
            title: SizedBox(
              child:
                  Text(listAnswers[index]['resposta_c'], style: styleAltUpdate),
            ),
          ),
        ],
      );
    }

    final buttonCancel = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      child: ButtonTheme(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "Voltar",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

    final buttonSendAnswers = ButtonTheme(
      minWidth: MediaQuery.of(context).size.width,
      child: ButtonTheme(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
          onPressed: () async {
            final url = Uri.parse('http://127.0.0.1:5000/Corrigir_teste');

            var encodeListaRespostas = jsonEncode(dataListRespostas);

            await http.post(url, body: {
              'id': widget.randId.toString(),
              'lista_respostas': encodeListaRespostas,
              'email': widget.emailUser.toString()
            });

            Navigator.of(context).pop();

            //if nota do mano for paia
          },
          child: Text(
            "Enviar",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
          title: const Text('Fazer CURSO'),
          titleTextStyle: styleAltUpdate,
          automaticallyImplyLeading: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50),
          child: Column(
            children: [
              Center(
                child: Text('Teste de aptidão', style: styleMainTitle),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataListQuestoesBD.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                              dataListQuestoesBD[index]['numero_questao'],
                              style: styleTitle),
                        ),
                        returnAnswers(
                            index, dataListQuestoesBD, dataListRespostas),
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
            ],
          )),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
                label: const Text('Próximo'),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Enviar QUIZ?'),
                          content:
                              const Text('As alternativas foram assinaladas?'),
                          actions: [buttonSendAnswers, buttonCancel],
                        );
                      });
                },
              ),
              const SizedBox(width: 30),
            ]),
          ]),
    );
  }
}
