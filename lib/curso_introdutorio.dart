import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'fazer_quiz.dart';

class CursoIntrodutorioCall extends StatefulWidget {
  final int randId;
  final String emailUser;
  final int flag;

  const CursoIntrodutorioCall({required this.randId, required this.emailUser, required this.flag});

  @override
  CursoIntrodutorio createState() => CursoIntrodutorio();
}

class CursoIntrodutorio extends State<CursoIntrodutorioCall> {
  int randId = 0;
  String emailUser = '';
  int flagToSend = 1;
  List<dynamic> curso_introdutorio = [];
  String curso_introdutorio_texto = '';

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
    final url =
        Uri.parse('http://127.0.0.1:5000/curso_introdutorio_treinamentos');
    final response =
        await http.post(url, body: {'id': widget.randId.toString()});

    setState(() {
      curso_introdutorio = jsonDecode(response.body);
      curso_introdutorio_texto = curso_introdutorio[0]['ci'];
    });
  }

  @override
  Widget build(BuildContext context) {
    randId = widget.randId;
    emailUser = widget.emailUser;

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

    final buttonGoToTest = ButtonTheme(
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
            Navigator.pop(context);

            Navigator.push(context,MaterialPageRoute(builder: (context) => FazerQuizCall(randId: widget.randId, emailUser: widget.emailUser, flag: flagToSend)));
          },
          child: Text(
            "Ir",
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
          title: const Text('Curso introdutório'),
          titleTextStyle: styleAltUpdate,
          automaticallyImplyLeading: false),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 200.0, vertical: 50),
          child: Column(
            children: [
              Center(
                child: Text('Curso introdutório', style: styleMainTitle),
              ),
              Center(
                child: Expanded(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(curso_introdutorio_texto, style: styleAltUpdate),
                      ]),
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
                          title: const Text(
                              'Deseja ir para o teste do curso introdutório?'),
                          content:
                              const Text('Você não voltará para essa tela'),
                          actions: [buttonGoToTest, buttonCancel],
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
