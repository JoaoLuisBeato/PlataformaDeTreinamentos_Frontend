import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CursosCall extends StatefulWidget {
  @override
  Cursos createState() => Cursos();
}

class Cursos extends State<CursosCall> {
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

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  List<dynamic> dataListCursosBD = [];

  Future<void> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:5000/listar_treinamentos'));

    setState(() {
      dataListCursosBD = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: Text('Clique aqui para atualizar ou deletar o treinamento',
                        style: styleSubtitleSmall),
                  ),
                ]),
            onTap: () {},
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
