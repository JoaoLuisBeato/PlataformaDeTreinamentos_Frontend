import 'package:flutter/material.dart';

class QuizCall extends StatefulWidget {
  @override
  Quiz createState() => Quiz();
}

class Quiz extends State<QuizCall> {
  List<Answers> itemsRespostas = [];

  void addResposta() {
    setState(() {
      int questionCount = itemsRespostas.length + 1;
      itemsRespostas.add(Answers(
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

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);

  String pergunta = '';

  String respostaA = '';
  String respostaB = '';
  String respostaC = '';

  bool checkAlternativaA = false;
  bool checkAlternativaB = false;
  bool checkAlternativaC = false;

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
      checkAlternativaA = false;
      checkAlternativaB = false;
      checkAlternativaC = false;

      respostaA = '';
      respostaB = '';
      respostaC = '';

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
                  hintText: "Resposta da alternativa A",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ),
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
                  hintText: "Resposta da alternativa B",
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
                  hintText: "Resposta da alternativa C",
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
        itemCount: itemsRespostas.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(itemsRespostas[index].questao, style: style),
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
          addResposta();
          questionCounter++;
        },
        child: const Icon(Icons.add),
      ),
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

  Answers(
      {required this.questao,
      required this.pergunta,
      required this.respostaDaAlternativaA,
      required this.alternativaA,
      required this.respostaDaAlternativaB,
      required this.alternativaB,
      required this.respostaDaAlternativaC,
      required this.alternativaC,});
}
