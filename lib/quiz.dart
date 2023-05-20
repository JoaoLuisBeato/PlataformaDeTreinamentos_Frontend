import 'package:flutter/material.dart';

class QuizCall extends StatefulWidget {
  @override
  Quiz createState() => Quiz();
}

class Quiz extends State<QuizCall> {
  List<Questions> itemsQuestoes = [];
  List<Answers> itemsRespostas = [];

  void addItemQuestao() {
    setState(() {
      int questionCount = itemsQuestoes.length + 1;
      itemsQuestoes.add(
          Questions(questao: 'Questão $questionCount', pergunta: pergunta));
    });
  }

  void addResposta() {
    setState(() {
      int answerCount = itemsRespostas.length + 1; //talvez use
      itemsRespostas.add(Answers(
        respostaDaAlternativaA: respostaA,
        alternativaA: checkAlternativaA,
      ));
    });
  }

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);

  String pergunta = '';

  String respostaA = '';

  bool checkAlternativaA = false;

  int questionCounter = 0;

  @override
  Widget build(BuildContext context) {
    final questionField = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          pergunta = text;
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Pergunta da questão",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    Column returnCheckbox(index, listAnswers) {
      return Column(
        children: [
          CheckboxListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 420, vertical: 5),
            value: listAnswers[index].alternativaA,
            onChanged: (bool? value) {
              setState(() {
                listAnswers[index].alternativaA = value!;
                checkAlternativaA = listAnswers[index].alternativaA;
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
                  hintText: "Resposta da alternativa A",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar QUIZ'),
        titleTextStyle: style,
      ),
      body: ListView.builder(
        itemCount: itemsQuestoes.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(itemsQuestoes[index].questao, style: style),
              ),
              questionField,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItemQuestao();
          addResposta();
          questionCounter++;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Questions {
  String questao;
  String pergunta;

  Questions({required this.questao, required this.pergunta});
}

class Answers {
  String respostaDaAlternativaA;
  //String respostaDaAlternativaB;
  /*String respostaDaAlternativaC;
  String respostaDaAlternativaD;*/

  bool alternativaA;
  //bool alternativaB;
  /*bool alternativaC;
  bool alternativaD;*/

  Answers({required this.respostaDaAlternativaA, required this.alternativaA});
}
