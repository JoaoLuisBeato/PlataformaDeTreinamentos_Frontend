import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class FazerQuizCall extends StatefulWidget {
  final int randId;

  FazerQuizCall({required this.randId});

  @override
  FazerQuiz createState() => FazerQuiz();
}

class FazerQuiz extends State<FazerQuizCall> {
  int randId = 0;
  List<dynamic> dataListQuestoesBD = [];

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
    //fetchDataFromAPI();
  }

Future<void> fetchDataFromAPI() async {


      final url = Uri.parse('http://127.0.0.1:5000/Listar_teste');
      final response = await http.post(url, body: {'id': widget.randId.toString()});

      setState(() {
        dataListQuestoesBD = json.decode(response.body);
      });
   
  }

  @override
  Widget build(BuildContext context) {
    randId = widget.randId;

    return Scaffold(
      appBar: AppBar(
          title: const Text('Fazer QUIZ'),
          titleTextStyle: styleAltUpdate,
          automaticallyImplyLeading: false),
      /*body: ListView.builder(
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
      ),*/
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              FloatingActionButton(
                onPressed: () {
                  fetchDataFromAPI();
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
