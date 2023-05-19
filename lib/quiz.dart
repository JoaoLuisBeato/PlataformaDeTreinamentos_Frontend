import 'package:flutter/material.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {

    TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);


   return Scaffold(
      appBar: AppBar(
        title:
            const Text('Criar QUIZ'), //<-- colocar $nomedisplay
        titleTextStyle: style,
      ),

    );
  }
}
