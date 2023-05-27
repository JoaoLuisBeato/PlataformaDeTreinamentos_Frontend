import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListagemVagasCall extends StatefulWidget {
  @override
  ListagemVagas createState() => ListagemVagas();
}

class ListagemVagas extends State<ListagemVagasCall> {
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

  List<dynamic> dataListVagasBD = [];

  Future<void> fetchDataFromAPI() async {
    final response =
        await http.post(Uri.parse('http://127.0.0.1:5000/listar_vaga_emprego'));

    setState(() {
      dataListVagasBD = json.decode(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              //colocar uma dialog box depois para listar usuários que se inscreveram
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
