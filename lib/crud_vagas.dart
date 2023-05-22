import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class CrudVagasCall extends StatefulWidget {
  @override
  CrudVagas createState() => CrudVagas();
}

class CrudVagas extends State<CrudVagasCall> {

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);
  TextStyle styleTitle = const TextStyle(fontFamily: 'Nunito', fontSize: 50.9);

  final fieldText = TextEditingController();

  Timer? _debounce;
  final Duration _debounceTime = const Duration(seconds: 2);

  String tituloDaVaga = '';
  String empresaQueOferta = '';
  String descricaoDaVaga = '';
  String requisitosDaVaga = '';

  String minSalario = '';
  String maxSalario = '';

  @override
  Widget build(BuildContext context) {

    void checkText(minSalario, maxSalario) {
      if (minSalario != '' && maxSalario != '') {
        if (int.parse(maxSalario) < int.parse(minSalario)) {
          fieldText.clear();
        }
        if (int.parse(minSalario) > int.parse(maxSalario)) {
          fieldText.clear();
        }
      }
    }

    final titleVacancy = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          tituloDaVaga = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Título da vaga",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final companyOffer = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          empresaQueOferta = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Empresa que está ofertando",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final description = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          descricaoDaVaga = text;
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Descrição da vaga",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final requirements = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          requisitosDaVaga = text;
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Requisitos da vaga",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final maxWage = TextField(
      textAlign: TextAlign.center,
      onChanged: (text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();

        _debounce = Timer(_debounceTime, () {
          maxSalario = text;
          checkText(minSalario, maxSalario);
        });
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      obscureText: false,
      style: style,
      controller: fieldText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Salário Máximo",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixText: 'Reais',
        suffixStyle: style,
      ),
    );

    final minWage = TextField(
      textAlign: TextAlign.center,
      onChanged: (text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(_debounceTime, () {
          minSalario = text;
          checkText(minSalario, maxSalario);
        });
      },
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Salário Mínimo",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixText: 'Reais',
          suffixStyle: style),
    );

    final minMaxWage = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 400, child: minWage),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Text(
            "até",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(width: 400, child: maxWage),
      ],
    );

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

            final url = Uri.parse('http://127.0.0.1:5000/vaga_emprego');

            final resquest = await http.post(url, body: {'titulo_vaga': tituloDaVaga, 'empresa_oferece': empresaQueOferta, 'descricao_vaga': descricaoDaVaga, 'pre_requisitos': requisitosDaVaga, 'salario_minimo': minSalario, 'salario_maximo': maxSalario});
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

    final buttonCreateVacancy = ButtonTheme(

      minWidth: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
      child: ButtonTheme(
        minWidth: 200.0,
        height: 150.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            minimumSize: const Size(150, 40),
          ),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Continuar?'),
                    content: const Text('Os campos foram preenchidos corretamente?'),
                    actions: [buttonConfirm, buttonCancel],
                  );
                });
          },
          child: Text(
            "Criar VAGA",
            textAlign: TextAlign.center,
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 0),
        child: Column(
          children: [
            Text('Crie uma vaga!', style: styleTitle),
            const SizedBox(height: 30.0),
            titleVacancy,
            const SizedBox(height: 30.0),
            companyOffer,
            const SizedBox(height: 30.0),
            description,
            const SizedBox(height: 30.0),
            requirements,
            const SizedBox(height: 30.0),
            minMaxWage,
            const SizedBox(height: 30.0),
            buttonCreateVacancy
          ],
        ),
      ),
    );
  }
}
