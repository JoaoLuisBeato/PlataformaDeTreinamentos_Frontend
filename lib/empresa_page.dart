import 'package:flutter/material.dart';
import 'crud_vagas.dart';
import 'pesquisa_de_aluno.dart';
import 'results_empresa.dart';

class CompanyPageCall extends StatefulWidget {

  final String userType;
  final String emailUser;

  const CompanyPageCall({required this.userType, required this.emailUser});

  @override
  CompanyPage createState() => CompanyPage();
}

class CompanyPage extends State<CompanyPageCall> {
  int _selectedIndex = 0;

  List<Widget> getWidgetOptions() {
    return [
      ResultsSearchCall(userType: widget.userType, emailUser: widget.emailUser),
      CrudVagasCall(userType: widget.userType, emailUser: widget.emailUser),
      AlunoSearchCall(userType: widget.userType, emailUser: widget.emailUser)
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
            const Text('Bem-vindo REPRESENTANTE DA EMPRESA, '), //<-- colocar $nomedisplay
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
            icon: Icon(Icons.bar_chart),
            label: 'Resultados',
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
