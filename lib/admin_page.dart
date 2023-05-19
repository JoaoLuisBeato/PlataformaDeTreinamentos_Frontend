import 'package:flutter/material.dart';
import 'crud_treinamentos.dart';
import 'quiz.dart';

class AdminPageCall extends StatefulWidget {
  @override
  AdminPage createState() => AdminPage();
}

class AdminPage extends State<AdminPageCall> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    CrudTreinamentosCall(),
    const Text('Cursos'),
    const Text('Resultados'),
    const Text('Testes'),
    const Text('Vagas Divulgadas'),
    const Text('CRUD Vagas de Emprego'),
    const Text('Atividades Concluídas'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9, fontWeight: FontWeight.normal);

  //String nomeDisplay;

  //AdminPage({required this.nomeDisplay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Bem-vindo ADMINISTRADOR, '), //<-- colocar $nomedisplay
        titleTextStyle: style,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'CRUD Treinamentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Resultados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Testes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Vagas Divulgadas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'CRUD Vagas de Emprego',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Atividades Concluídas',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
