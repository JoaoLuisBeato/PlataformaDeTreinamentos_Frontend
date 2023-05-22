import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'dart:math';

import 'package:my_app/quiz.dart';

class CrudTreinamentosCall extends StatefulWidget {
  @override
  CrudTreinamentos createState() => CrudTreinamentos();
}

class CrudTreinamentos extends State<CrudTreinamentosCall> {
  
  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);
  TextStyle styleTitle = const TextStyle(fontFamily: 'Nunito', fontSize: 50.9);

  int id_treinamento = Random().nextInt(200);

  String nomeComercial = '';
  String descricao = '';
  String cargaHoraria = '';

  DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
  DateTime dataInicioInscricao = DateTime.now();
  DateTime dataFinalInscricao = DateTime.now();
  DateTime dataFinalTreinamento = DateTime.now();

  final fieldText = TextEditingController();

  String minCandidatos = '';
  String maxCandidatos = '';

  Timer? _debounce;
  final Duration _debounceTime = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    
    void _showDatePicker(pressedButton) {
      showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
      ).then((value) {
        setState(() {
          if (value != null) {
            if (pressedButton == 'Inicio') {
              dataInicioInscricao = value;
            } else if (pressedButton == 'Final' &&
                value.isAfter(dataInicioInscricao)) {
              dataFinalInscricao = value;
            } else if (pressedButton == 'Treinamento' &&
                value.isAfter(dataFinalInscricao)) {
              dataFinalTreinamento = value;
            }
          }
        });
      });
    }

    final comercialNameField = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          nomeComercial = text;
        },
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nome comercial do treinamento",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final descriptionField = SizedBox(
      width: 600,
      child: TextField(
        onChanged: (text) {
          descricao = text;
        },
        keyboardType: TextInputType.multiline,
        maxLines: null,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Descrição",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );

    final workloadField = SizedBox(
      width: 300,
      child: TextField(
        textAlign: TextAlign.center,
        onChanged: (text) {
          cargaHoraria = text;
        },
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        obscureText: false,
        style: style,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: "Carga horária",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            suffixText: 'Horas',
            suffixStyle: style),
      ),
    );

    void checkText(minCandidatos, maxCandidatos) {
      if (minCandidatos != '' && maxCandidatos != '') {
        if (int.parse(maxCandidatos) < int.parse(minCandidatos) || int.parse(minCandidatos) > int.parse(maxCandidatos)) {
          fieldText.clear();
        }
      }
    }

    final maxCandidates = TextField(
      textAlign: TextAlign.center,
      onChanged: (text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();

        _debounce = Timer(_debounceTime, () {
          maxCandidatos = text;
          checkText(minCandidatos, maxCandidatos);
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
        hintText: "Máximo de candidatos",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        suffixText: 'Candidatos',
        suffixStyle: style,
      ),
    );

    final minCandidates = TextField(
      textAlign: TextAlign.center,
      onChanged: (text) {
        if (_debounce?.isActive ?? false) _debounce?.cancel();
        _debounce = Timer(_debounceTime, () {
          minCandidatos = text;
          checkText(minCandidatos, maxCandidatos);
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
          hintText: "Mínimo de candidatos",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixText: 'Candidatos',
          suffixStyle: style),
    );

    final alinhamentoBotoesDeData = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ButtonTheme(
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
                  _showDatePicker('Inicio');
                },
                child: Text(
                  "Selecione INÍCIO das inscrições",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ButtonTheme(
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
                  _showDatePicker('Final');
                },
                child: Text(
                  "Selecione FIM das inscrições",
                  textAlign: TextAlign.center,
                  style: style.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        ButtonTheme(
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
                _showDatePicker('Treinamento');
              },
              child: Text(
                "Selecione FIM do treinamento",
                textAlign: TextAlign.center,
                style: style.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    final selectedDates = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30, left: 20),
          child: Text(
            "Data selecionada INÍCIO DA INSCRIÇÃO: ${formatter.format(dataInicioInscricao)}",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Text(
            "Data selecionada FIM DA INSCRIÇÃO: ${formatter.format(dataFinalInscricao)}",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            "Data selecionada FIM DO TREINAMENTO: ${formatter.format(dataFinalTreinamento)}",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
      ],
    );

    final minMaxCandidates = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: 400, child: minCandidates),
        Padding(
          padding: const EdgeInsets.only(right: 10, left: 10),
          child: Text(
            "até",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        SizedBox(width: 400, child: maxCandidates),
      ],
    );

    final buttonQuiz = ButtonTheme(
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QuizCall(randId: id_treinamento)),
            );
          },
          child: Text(
            "Criar QUIZ",
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
            Text('Crie um treinamento!', style: styleTitle),
            const SizedBox(height: 30.0), comercialNameField,
            const SizedBox(height: 30.0), descriptionField,
            const SizedBox(height: 30.0), workloadField,
            const SizedBox(height: 30.0), alinhamentoBotoesDeData,
            const SizedBox(height: 30.0), selectedDates,
            const SizedBox(height: 30.0), minMaxCandidates,
            const SizedBox(height: 30.0), buttonQuiz,
          ],
        ),
      ),
    );
  }
}
