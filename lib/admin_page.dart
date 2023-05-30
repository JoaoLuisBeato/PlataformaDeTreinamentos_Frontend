import 'package:flutter/material.dart';
import 'package:my_app/crud_treinamentos.dart';
import 'crud_vagas.dart';
import 'cursos.dart';
import 'listagem_vagas.dart';

class AdminPageCall extends StatefulWidget {

  final String userType;
  final String emailUser;

  const AdminPageCall({required this.userType, required this.emailUser});

  @override
  AdminPage createState() => AdminPage();
}

class AdminPage extends State<AdminPageCall> {
  
  int _selectedIndex = 0;

  List<Widget> getWidgetOptions() {
    return [
      CrudTreinamentosCall(),
      CursosCall(userType: widget.userType, emailUser: widget.emailUser),
      const Text('Resultados'),
      const Text('Testes'),
      ListagemVagasCall(userType: widget.userType, emailUser: widget.emailUser),
      CrudVagasCall(userType: widget.userType),
      const Text('Atividades Concluídas'),
    ];
  }

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

    final widgetOptions = getWidgetOptions();

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Bem-vindo ADMINISTRADOR, '), //<-- colocar $nomedisplay
        titleTextStyle: style,
      ),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.amber,
        unselectedItemColor: Colors.white,
        iconSize: 30,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'CRUD de Treinamentos',
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
