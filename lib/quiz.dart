import 'package:flutter/material.dart';

class QuizCall extends StatefulWidget {
  @override
  Quiz createState() => Quiz();
}

class Quiz extends State<QuizCall> {
  List<Questions> items = [];

  void addItem() {
    setState(() {
      int questionCount = items.length + 1;
      items.add(
          Questions(questao: 'Questão $questionCount', pergunta: pergunta));
    });
  }

  List<bool> checkboxesParaQuestoes = List.generate(5, (_) => false);

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);
  String pergunta = '';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar QUIZ'),
        titleTextStyle: style,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                title: Text(items[index].questao, style: style),
              ),
              questionField,
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
        onPressed: (){
          addItem();
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
