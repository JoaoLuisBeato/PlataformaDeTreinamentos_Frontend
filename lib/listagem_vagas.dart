import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:my_app/crud_vagas.dart';

class ListagemVagasCall extends StatefulWidget {

  final String userType;

  ListagemVagasCall({required this.userType});

  @override
  ListagemVagas createState() => ListagemVagas();
}

class ListagemVagas extends State<ListagemVagasCall> {

  String _userType = '';

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

  List<dynamic> dataListVagasBD = [];

  Future<void> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:5000/listar_vaga_emprego'));

    setState(() {
      dataListVagasBD = json.decode(response.body);
    });
  }

  final fieldText = TextEditingController();

  Timer? _debounce;
  final Duration _debounceTime = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {

    _userType = widget.userType;

    void checkText(minSalario, maxSalario) {
      if (minSalario != '' && maxSalario != '') {
        if (int.parse(maxSalario) < int.parse(minSalario) ||
            int.parse(minSalario) > int.parse(maxSalario)) {
          fieldText.clear();
        }
      }
    }

    Column updateField(index) {
      final TextEditingController textFieldTitleController =
          TextEditingController(text: dataListVagasBD[index]['Titulo da vaga']);
      final TextEditingController textFieldCompanyController =
          TextEditingController(text: dataListVagasBD[index]['Empresa']);
      final TextEditingController textFieldDescriptionController =
          TextEditingController(text: dataListVagasBD[index]['Descricao']);
      final TextEditingController textFieldRequirementsController =
          TextEditingController(text: dataListVagasBD[index]['Pré Requisito']);

      dataListVagasBD[index]['Salário mínimo'] =
          dataListVagasBD[index]['Salário mínimo'].toString();
      dataListVagasBD[index]['Salário máximo'] =
          dataListVagasBD[index]['Salário máximo'].toString();

      return Column(
        children: [
          const SizedBox(height: 30.0),
          SizedBox(
            width: 400,
            child: TextField(
              onChanged: (text) {
                dataListVagasBD[index]['Titulo da vaga'] = text;
              },
              controller: textFieldTitleController,
              obscureText: false,
              style: styleAltUpdate,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Título da vaga",
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
                dataListVagasBD[index]['Empresa'] = text;
              },
              controller: textFieldCompanyController,
              obscureText: false,
              style: styleAltUpdate,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Empresa",
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
                dataListVagasBD[index]['Descricao'] = text;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
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
              onChanged: (text) {
                dataListVagasBD[index]['Pré Requisito'] = text;
              },
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: textFieldRequirementsController,
              obscureText: false,
              style: styleAltUpdate,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelText: "Pré Requisitos",
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
                if (_debounce?.isActive ?? false) _debounce?.cancel();

                _debounce = Timer(_debounceTime, () {
                  dataListVagasBD[index]['Salário mínimo'] = text;
                  checkText(dataListVagasBD[index]['Salário mínimo'],
                      dataListVagasBD[index]['Salário máximo']);
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
                labelText: "Salário mínimo",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixText: 'Reais',
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
                  dataListVagasBD[index]['Salário máximo'] = text;
                  checkText(dataListVagasBD[index]['Salário mínimo'],
                      dataListVagasBD[index]['Salário máximo']);
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
                labelText: "Salário máximo",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                suffixText: 'Reais',
                suffixStyle: styleAltUpdate,
              ),
            ),
          ),
        ],
      );
    }

    ButtonTheme deleteVaga(index) {
      return ButtonTheme(
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
              final url = Uri.parse('http://127.0.0.1:5000/Delete_vagas');

              final resquest = await http.post(url, body: {
                'codigo_vaga': dataListVagasBD[index]['id'].toString()
              });
              fetchDataFromAPI();
              ListagemVagasCall(userType: _userType);
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
      );
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

                    final url = Uri.parse('http://127.0.0.1:5000/Update_vaga');

                    final resquest = await http.post(url, body: {
                      'id': dataListVagasBD[index]['id'].toString(),
                      'titulo_vaga': dataListVagasBD[index]['Titulo da vaga'],
                      'empresa_oferece': dataListVagasBD[index]['Empresa'],
                      'descricao_vaga': dataListVagasBD[index]['Descricao'],
                      'pre_requisitos': dataListVagasBD[index]['Pré Requisito'],
                      'salario_minimo':
                          dataListVagasBD[index]['Salário mínimo'].toString(),
                      'salario_maximo':
                          dataListVagasBD[index]['Salário máximo'].toString()
                    });

                    fetchDataFromAPI();
                    ListagemVagasCall(userType: _userType);
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

    ButtonTheme buttonUpdate(index) {
      return ButtonTheme(
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
                      title: const Text('Usuários inscritos:'),
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

    Column returnListTile(index) {
      return Column(children: [
        Container(
          width: 1200,
          child: ListTile(
            title: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Text(dataListVagasBD[index]['Titulo da vaga'],
                    style: styleTitle),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 50),
                child: Text(
                    '    ID: ${dataListVagasBD[index]['id'].toString()}',
                    style: styleSubtitle),
              ),
            ]),
            subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Empresa que está ofertando: ',
                            style: styleComplement),
                        Text('${dataListVagasBD[index]['Empresa']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 10),
                    child: Text('${dataListVagasBD[index]['Descricao']}',
                        style: styleSubtitle),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Faixa Salarial: ', style: styleComplement),
                        Text(
                            'De R\$ ${dataListVagasBD[index]['Salário mínimo'].toString()} até R\$ ${dataListVagasBD[index]['Salário máximo'].toString()}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 20),
                    child: Row(
                      children: [
                        Text('Requisitos da candidatura: ',
                            style: styleComplement),
                        Text('${dataListVagasBD[index]['Pré Requisito']}',
                            style: styleSubtitle),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100, top: 10),
                    child: Text('Clique aqui para ver os inscritos na vaga.',
                        style: styleSubtitleSmall),
                  ),
                ]),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Usuários inscritos:'),
                      //content: const Text('Escolha entre atualizar ou excluir esse curso'), --> colocar um for para imprimir alunos inscritos
                      actions: [
                        buttonUpdate(index),
                        deleteVaga(index),
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
        itemCount: dataListVagasBD.length,
        itemBuilder: (context, index) {
          return returnListTile(index);
        },
      ),
    );
  }
}
