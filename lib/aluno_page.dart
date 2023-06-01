import 'package:flutter/material.dart';
import 'cursos.dart';
import 'listagem_vagas.dart';
import 'atividades_concluidas.dart';

class StudentPageCall extends StatefulWidget {
  final String userType;
  final String emailUser;

  const StudentPageCall({required this.userType, required this.emailUser});

  @override
  StudentPage createState() => StudentPage();
}

class StudentPage extends State<StudentPageCall> {
  int _selectedIndex = 0;
  String _userType = '';
  String _emailUser = '';

    List<Widget> getWidgetOptions() {
    return [
      CursosCall(userType: _userType, emailUser: _emailUser),
      ListagemVagasCall(userType: _userType, emailUser: _emailUser),
      CompletedPageCall(emailUser: _emailUser)
    ];
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  TextStyle style = const TextStyle(fontFamily: 'Nunito', fontSize: 20.9, fontWeight: FontWeight.normal);

  @override
  Widget build(BuildContext context) {

    _userType = widget.userType;
    _emailUser = widget.emailUser;

    final widgetOptions = getWidgetOptions();

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Bem-vindo ALUNO, $_emailUser'), //<-- colocar $nomedisplay
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
            icon: Icon(Icons.school),
            label: 'Cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Vagas Divulgadas',
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
