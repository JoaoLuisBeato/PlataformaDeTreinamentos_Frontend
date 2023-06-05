import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class QuizCall extends StatefulWidget {
  final int randId;

  const QuizCall({required this.randId});

  @override
  Quiz createState() => Quiz();
}

class Quiz extends State<QuizCall> {
  List<Answers> itemsRespostas = [];

  void addResposta() {
    setState(() {
      int questionCount = itemsRespostas.length + 1;
      itemsRespostas.add(Answers(
        idTreinamentoQuiz: widget.randId,
        questao: 'Questão $questionCount',
        pergunta: pergunta,
        respostaDaAlternativaA: respostaA,
        alternativaA: checkAlternativaA,
        respostaDaAlternativaB: respostaB,
        alternativaB: checkAlternativaB,
        respostaDaAlternativaC: respostaC,
        alternativaC: checkAlternativaC,
      ));
    });
  }

  TextStyle style = const TextStyle(
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

  String pergunta = '';

  String respostaA = '';
  String respostaB = '';
  String respostaC = '';

  bool checkAlternativaA = false;
  bool checkAlternativaB = false;
  bool checkAlternativaC = false;

  bool checkFirstEntranceAlert = true;

  int transferIndex = 0;

  int questionCounter = 0;

  Future<void> enviaQuestao(itemsRespostas, transferIndex) async {
    final url = Uri.parse('http://127.0.0.1:5000/criar_questao');

    await http.post(url, body: {
      'id_treinamento_quiz':
          itemsRespostas[transferIndex].idTreinamentoQuiz.toString(),
      'questao': itemsRespostas[transferIndex]
          .questao
          .toString(), // na criação da nova tabela, isso tem que ser a pk
      'pergunta': itemsRespostas[transferIndex].pergunta,
      'respostaDaAlternativaA':
          itemsRespostas[transferIndex].respostaDaAlternativaA,
      'alternativaA': itemsRespostas[transferIndex].alternativaA.toString(),
      'respostaDaAlternativaB':
          itemsRespostas[transferIndex].respostaDaAlternativaB,
      'alternativaB': itemsRespostas[transferIndex].alternativaB.toString(),
      'respostaDaAlternativaC':
          itemsRespostas[transferIndex].respostaDaAlternativaC,
      'alternativaC': itemsRespostas[transferIndex].alternativaC.toString()
    });
  }

  @override
  Widget build(BuildContext context) {
    
    Column returnCheckbox(index, listAnswers) {
      checkAlternativaA = false;
      checkAlternativaB = false;
      checkAlternativaC = false;

      checkFirstEntranceAlert = false;

      respostaA = '';
      respostaB = '';
      respostaC = '';

      return Column(
        children: [
          SizedBox(
            width: 600,
            child: TextField(
              onChanged: (text) {
                listAnswers[index].pergunta = text;
                pergunta = listAnswers[index].pergunta;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              obscureText: false,
              style: style,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Pergunta da questão",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 320, vertical: 5),
            value: listAnswers[index].alternativaA,
            onChanged: (bool? value) {
              setState(() {
                listAnswers[index].alternativaA = value!;
                checkAlternativaA = listAnswers[index].alternativaA;
                listAnswers[index].alternativaB = false;
                listAnswers[index].alternativaC = false;
              });
            },
            title: SizedBox(
              child: TextField(
                onChanged: (text) {
                  listAnswers[index].respostaDaAlternativaA = text;
                  respostaA = listAnswers[index].respostaDaAlternativaA;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                obscureText: false,
                style: style,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  labelText: "Resposta da alternativa A",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 320, vertical: 5),
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
                const EdgeInsets.symmetric(horizontal: 320, vertical: 5),
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
      );
    }

    final buttonConfirm = ButtonTheme(
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
            addResposta();
            questionCounter++;
            enviaQuestao(itemsRespostas, transferIndex);
            Navigator.of(context).pop();
          },
          child: Text(
            "Continuar",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );

    final buttonConfirmSubmit = Container(
      height: 58,
      child: ButtonTheme(
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
              enviaQuestao(itemsRespostas, transferIndex);
              Navigator.of(context).pop();
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
      ),
    );

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

    return Scaffold(
      appBar: AppBar(
          title: const Text('Criar QUIZ'),
          titleTextStyle: style,
          automaticallyImplyLeading: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 50),
          child: Column(
            children: [
              Center(
                child: Text('Crie o quiz', style: styleMainTitle),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemsRespostas.length,
                  itemBuilder: (context, index) {
          	  transferIndex = index;
                    return Column(
                      children: [
                        ListTile(
                  		title: Text(itemsRespostas[index].questao, style: style),
                	),
                        returnCheckbox(index, itemsRespostas),
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
              FloatingActionButton(
                onPressed: () {
                  if (checkFirstEntranceAlert) {
                    addResposta();
                    questionCounter++;
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Continuar?'),
                            content: const Text(
                                'Os campos foram preenchidos e a alternativa certa foi assinalada?'),
                            actions: [buttonConfirm, buttonCancel],
                          );
                        });
                  }
                  checkFirstEntranceAlert = false;
                },
                child: const Icon(Icons.add, color: Colors.white),
              ),
              const SizedBox(width: 30),
              buttonConfirmSubmit
            ]),
          ]),
    );
  }
}

class Answers {
  String questao;
  String pergunta;

  String respostaDaAlternativaA;
  String respostaDaAlternativaB;
  String respostaDaAlternativaC;

  bool alternativaA;
  bool alternativaB;
  bool alternativaC;

  int idTreinamentoQuiz;

  Answers({
    required this.idTreinamentoQuiz,
    required this.questao,
    required this.pergunta,
    required this.respostaDaAlternativaA,
    required this.alternativaA,
    required this.respostaDaAlternativaB,
    required this.alternativaB,
    required this.respostaDaAlternativaC,
    required this.alternativaC,
  });
}
