import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'fazer_quiz.dart';

class CursosCall extends StatefulWidget {
  final String userType;
  final String emailUser;

  const CursosCall({required this.userType, required this.emailUser});

  @override
  Cursos createState() => Cursos();
}

class Cursos extends State<CursosCall> {
  String _userType = '';
  String _emailUser = '';

  TextStyle style = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black12);

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

  TextStyle styleAltUpdate = const TextStyle(
      fontFamily: 'Nunito',
      fontSize: 20,
      fontWeight: FontWeight.normal,
      color: Colors.black);

  final fieldText = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  List<dynamic> dataListCursosBD = [];

  bool buttonUpdateVisibility = true;
  bool buttonDoQuizVisibility = false;
  bool buttonSubscribeVisibility = false;
  bool buttonUnsubscribeVisibility = false;

  Timer? _debounce;
  final Duration _debounceTime = const Duration(seconds: 1);

  Future<void> fetchDataFromAPI() async {
      final response = await http.post(Uri.parse('http://127.0.0.1:5000/listar_treinamentos'));

      setState(() {
        dataListCursosBD = json.decode(response.body);
      });
  }

  @override
  Widget build(BuildContext context) {
    _userType = widget.userType;
    _emailUser = widget.emailUser;

    if (_userType == 'Aluno') {
      buttonUpdateVisibility = false;
      buttonDoQuizVisibility = true;
      buttonSubscribeVisibility = true;
      buttonUnsubscribeVisibility = true;
    }

    void checkText(minAlunos, maxAlunos) {
      if (minAlunos != '' && maxAlunos != '') {
        if (int.parse(maxAlunos) < int.parse(minAlunos) ||
            int.parse(minAlunos) > int.parse(maxAlunos)) {
          fieldText.clear();
        }
      }
    }

    Visibility deleteTreinamento(index) {
      return Visibility(
        visible: buttonUpdateVisibility,
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
              onPressed: () async {
                Navigator.of(context).pop();
                final url =
                    Uri.parse('http://127.0.0.1:5000/Delete_treinamentos');

                await http.post(url, body: {
                  'codigo_curso': dataListCursosBD[index]['Código do Curso']
                });
                fetchDataFromAPI();
                CursosCall(userType: _userType, emailUser: _emailUser);
              },
              child: Text(
                "Excluir",
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
    }

    Column updateField(index) {
      final TextEditingController textFieldTitleController =
          TextEditingController(
              text: dataListCursosBD[index]['Nome Comercial']);
      final TextEditingController textFieldDescriptionController =
          TextEditingController(text: dataListCursosBD[index]['Descricao']);
      final TextEditingController textFieldWorkLoadController =
          TextEditingController(text: dataListCursosBD[index]['Carga Horária']);

      dataListCursosBD[index]['Quantidade mínima de alunos'] =
          dataListCursosBD[index]['Quantidade mínima de alunos'].toString();
      dataListCursosBD[index]['Quantidade máxima de alunos'] =
          dataListCursosBD[index]['Quantidade máxima de alunos'].toString();

      return Column(children: [
        const SizedBox(height: 30.0),
        SizedBox(
          width: 400,
          child: TextField(
            onChanged: (text) {
              dataListCursosBD[index]['Nome Comercial'] = text;
            },
            controller: textFieldTitleController,
            obscureText: false,
            style: styleAltUpdate,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              labelText: "Nome comercial do treinamento",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          width: 400,
          child: TextField(
            onChanged: (text) {
              dataListCursosBD[index]['Descricao'] = text;
            },
            controller: textFieldDescriptionController,
            obscureText: false,
            style: styleAltUpdate,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              labelText: "Descrição",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          width: 400,
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              dataListCursosBD[index]['Carga Horária'] = text;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: textFieldWorkLoadController,
            obscureText: false,
            style: styleAltUpdate,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Carga horária",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixText: 'Horas',
                suffixStyle: styleAltUpdate),
          ),
        ),
        const SizedBox(height: 30.0),
        SizedBox(
          width: 400,
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();

              _debounce = Timer(_debounceTime, () {
                dataListCursosBD[index]['Quantidade mínima de alunos'] = text;
                checkText(
                    dataListCursosBD[index]['Quantidade mínima de alunos'],
                    dataListCursosBD[index]['Quantidade máxima de alunos']);
              });
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            obscureText: false,
            style: styleAltUpdate,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              labelText: "Quantidade mínima de alunos",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffixText: 'Alunos',
              suffixStyle: styleAltUpdate,
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(child: Text('até', style: styleAltUpdate)),
        const SizedBox(height: 20.0),
        SizedBox(
          width: 400,
          child: TextField(
            textAlign: TextAlign.center,
            onChanged: (text) {
              if (_debounce?.isActive ?? false) _debounce?.cancel();

              _debounce = Timer(_debounceTime, () {
                dataListCursosBD[index]['Quantidade máxima de alunos'] = text;
                checkText(
                    dataListCursosBD[index]['Quantidade mínima de alunos'],
                    dataListCursosBD[index]['Quantidade máxima de alunos']);
              });
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            obscureText: false,
            style: styleAltUpdate,
            controller: fieldText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              labelText: "Quantidade máxima de alunos",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              suffixText: 'Alunos',
              suffixStyle: styleAltUpdate,
            ),
          ),
        ),
      ]);
    }

    Column buttonConfirmUpdates(index) {
      return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ButtonTheme(
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

                    final url =
                        Uri.parse('http://127.0.0.1:5000/Update_treinamentos');

                    final resquest = await http.post(url, body: {
                      'nome_comercial':
                          dataListCursosBD[index]['Nome Comercial'].toString(),
                      'codigo_curso':
                          dataListCursosBD[index]['Código do Curso'].toString(),
                      'descricao':
                          dataListCursosBD[index]['Descricao'].toString(),
                      'carga_horaria':
                          dataListCursosBD[index]['Carga Horária'].toString(),
                      'inicio_inscricoes': dataListCursosBD[index]
                              ['Início das incricoes']
                          .toString(),
                      'final_inscricoes': dataListCursosBD[index]
                              ['Final das inscricoes']
                          .toString(),
                      'inicio_treinamentos': dataListCursosBD[index]
                              ['Início dos treinamentos']
                          .toString(),
                      'final_treinamentos': dataListCursosBD[index]
                              ['Final dos treinamentos']
                          .toString(),
                      'qnt_min': dataListCursosBD[index]
                              ['Quantidade mínima de alunos']
                          .toString(),
                      'qnt_max': dataListCursosBD[index]
                              ['Quantidade máxima de alunos']
                          .toString()
                    });

                    fetchDataFromAPI();
                    CursosCall(userType: _userType, emailUser: _emailUser);
                  },
                  child: Text(
                    "Atualizar dados",
                    textAlign: TextAlign.center,
                    style: style.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ]);
    }

    Visibility buttonUpdate(index) {
      return Visibility(
        visible: buttonUpdateVisibility,
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
                Navigator.of(context).pop();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Atualize o curso:'),
                        content: updateField(index),
                        actions: [buttonConfirmUpdates(index)],
                      );
                    });
              },
              child: Text(
                "Atualizar",
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
    }

    Visibility buttonDoQuiz(index) {
      return Visibility(
        visible: buttonDoQuizVisibility,
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
                Navigator.of(context).pop();
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FazerQuizCall(randId: int.parse(dataListCursosBD[index]['Código do Curso']), emailUser: _emailUser)));
              },
              child: Text(
                "Fazer o Curso",
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

    Text returnTextBox() {
      if (buttonUpdateVisibility == true) {
        return const Text('Escolha entre atualizar ou excluir esse curso');
      } else {
        return const Text('O que deseja fazer?');
      }
    }

    Visibility subscribeTreinamento(index) {
      return Visibility(
        visible: buttonSubscribeVisibility,
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
              onPressed: () async {
                Navigator.of(context).pop();
                final url =
                    Uri.parse('http://127.0.0.1:5000/entrar_treinamento');

                await http.post(url, body: {
                  'codigo_curso': dataListCursosBD[index]['Código do Curso'].toString(),
                  'email': _emailUser
                });
                fetchDataFromAPI();
                CursosCall(userType: _userType, emailUser: _emailUser);
              },
              child: Text(
                "Inscrever-se",
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
    }

    Visibility unsubscribeTreinamento(index) {
      return Visibility(
        visible: buttonUnsubscribeVisibility,
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
              onPressed: () async {
                Navigator.of(context).pop();
                final url =
                    Uri.parse('http://127.0.0.1:5000/sair_treinamento');

                await http.post(url, body: {
                  'codigo_curso': dataListCursosBD[index]['Código do Curso'].toString(),
                  'email': _emailUser
                });

                fetchDataFromAPI();
                CursosCall(userType: _userType, emailUser: _emailUser);
              },
              child: Text(
                "Desinscrever-se",
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
    }

    Column returnListTile(index) {
      return Column(children: [
        Container(
          width: 1200,
          child: ListTile(
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50, top: 10),
                  child: Text(dataListCursosBD[index]['Nome Comercial'],
                      style: styleTitle),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 50),
                  child: Text(
                      '    ID: ${dataListCursosBD[index]['Código do Curso']}',
                      style: styleSubtitle),
                ),
              ],
            ),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 10),
                    child: Text('${dataListCursosBD[index]['Descricao']}',
                        style: styleSubtitle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Carga horária: ', style: styleComplement),
                        Text(
                            '${dataListCursosBD[index]['Carga Horária']} Horas',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Inscrições: ', style: styleComplement),
                        Text(
                            '${dataListCursosBD[index]['Início das incricoes']} até ${dataListCursosBD[index]['Final das inscricoes']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Treinamentos: ', style: styleComplement),
                        Text(
                            '${dataListCursosBD[index]['Início dos treinamentos']} até ${dataListCursosBD[index]['Final dos treinamentos']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Quantidade de alunos: ', style: styleComplement),
                        Text(
                            '${dataListCursosBD[index]['Quantidade mínima de alunos']} até ${dataListCursosBD[index]['Quantidade máxima de alunos']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 10),
                    child: Row(
                      children: [
                        Text('Quantidade atual de alunos inscritos: ',
                            style: styleComplement),
                        Text(
                            '${dataListCursosBD[index]['Quantidade atual de alunos']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 10),
                    child: Text(
                        'Clique aqui para atualizar ou deletar o treinamento',
                        style: styleSubtitleSmall),
                  ),
                ]),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('O que deseja fazer?'),
                      content: returnTextBox(),
                      actions: [
                        buttonUpdate(index),
                        deleteTreinamento(index),
                        buttonDoQuiz(index),
                        subscribeTreinamento(index),
                        unsubscribeTreinamento(index),
                        buttonCancel
                      ],
                    );
                  });
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50),
          child: Divider(
            color: Colors.amber,
            height: 10.0,
          ),
        ),
      ]);
    }

    return Scaffold(
      body: ListView.builder(
        itemCount: dataListCursosBD.length,
        itemBuilder: (context, index) {
          return returnListTile(index);
        },
      ),
    );
  }
}
