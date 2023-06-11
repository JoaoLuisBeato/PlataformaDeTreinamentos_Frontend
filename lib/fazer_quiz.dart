import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'curso_introdutorio.dart';
import 'curso_avancado.dart';

class FazerQuizCall extends StatefulWidget {
  final int randId;
  final String emailUser;
  final int flag;

  const FazerQuizCall(
      {required this.randId, required this.emailUser, required this.flag});

  @override
  FazerQuiz createState() => FazerQuiz();
}

class FazerQuiz extends State<FazerQuizCall> {
  int randId = 0;
  String emailUser = '';
  String result = '';

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
    fetchDataFromAPI(widget.flag);
  }

  Future<void> fetchDataFromAPI(flag) async {
    final url;

    if (flag == 0) {
      url = Uri.parse(
          'http://127.0.0.1:5000/Listar_teste'); // mudar rota das questoes conforme flag
    } else if (flag == 1) {
      url = Uri.parse(
          'http://127.0.0.1:5000/Listar_teste_prova1'); //mudar rota para prova 1
    } else {
      url = Uri.parse(
          'http://127.0.0.1:5000/Listar_teste_prova2'); //mudar rota para prova 2
    }

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
    });
  }

  Future<void> corrigirTeste(flag, dataListRespostas) async {
    final url;

    if (flag == 0) {
      url = Uri.parse(
          'http://127.0.0.1:5000/Corrigir_teste_aptidao'); //mudar rota para teste de aptidao
    } else if (flag == 1) {
      url = Uri.parse(
          'http://127.0.0.1:5000/Corrigir_teste_prova1'); //mudar rota para prova 1
    } else {
      url = Uri.parse(
          'http://127.0.0.1:5000/Corrigir_teste_prova2'); //mudar rota para prova 2
    }

    var encodeListaRespostas = jsonEncode(dataListRespostas);

    final response = await http.post(url, body: {
      'id': widget.randId.toString(),
      'lista_respostas':
          encodeListaRespostas, //--> precisa filtrar para corrigir no backend
      'email': widget.emailUser.toString(),
    });

    var decodeResponse = json.decode(response.body);
    setState(() {
      result = decodeResponse['status'];
      print(result);
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
            child: Text('${dataListQuestoesBD[index]['questao']}',
                style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
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

    void dialogReprovado(BuildContext context) {

      final buttonOk = ButtonTheme(
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
            "Ok",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Você não acertou questões suficientes'),
              content: const Text('Decidimos não prosseguir com o curso.'),
              actions: [buttonOk],
            );
          });
    }

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
            Navigator.of(context).pop();

            if (widget.flag == 0) {
              await corrigirTeste(widget.flag, dataListRespostas);
              Navigator.pop(context);

              if (result == "Aprovado") {
                await Navigator.push(context, MaterialPageRoute( builder: (context) => CursoIntrodutorioCall( randId: widget.randId, emailUser: widget.emailUser, flag: widget.flag)));
              } else {
               dialogReprovado(context);
              }
            } else if (widget.flag == 1) {
              await corrigirTeste(widget.flag, dataListRespostas);
              Navigator.pop(context);
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CursoAvancadoCall(
                          randId: widget.randId,
                          emailUser: widget.emailUser,
                          flag: widget.flag)));
            } else {
              await corrigirTeste(widget.flag, dataListRespostas);
              Navigator.pop(context);
            }
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

    String changeTitleNameMaster(flag) {
      if (flag == 0) {
        return 'Teste de Aptidão';
      } else if (flag == 1) {
        return 'Teste do Case 1';
      } else {
        return 'Teste do Case 2';
      }
    }

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
                child: Text(changeTitleNameMaster(widget.flag),
                    style: styleMainTitle),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: dataListQuestoesBD.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text('${index + 1}-)', style: styleTitle),
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
