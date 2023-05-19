import 'package:flutter/material.dart';

class QuizCall extends StatefulWidget {
  @override
  Quiz createState() => Quiz();
}

class Quiz extends State<QuizCall> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  void addItem() {
    setState(() {
      int itemCount = items.length + 1;
      items.add('Item $itemCount');
    });
  }

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar QUIZ'),
        titleTextStyle: style,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
      ),
    );
  }
}
