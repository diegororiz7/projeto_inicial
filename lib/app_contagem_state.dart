// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:projeto_inicial/app_inicial_scaffold.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Contagem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int contador = 0;

  void _aumentar() {
    setState(() {
      contador++;
    });
    _checarEspecial();
  }

  void _diminuir() {
    setState(() {
      contador--;
    });
    _checarEspecial();
  }

  void _checarEspecial() {
    if (contador % 10 == 0 && contador != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Você chegou a $contador cliques!')),
      );
    }
  }

  String getMensagem() {
    if (contador < 0) return 'Está diminuindo!';
    if (contador == 0) return 'Comece a clicar!';
    if (contador < 10) return 'Está aumentando!';
    if (contador < 20) return 'Continue clicando!';
    return 'Clique master!';
  }

  Color getCorFundo() {
    if (contador < 0) return Colors.grey.shade100;
    if (contador == 0) return Colors.brown.shade100;
    if (contador < 10) return Colors.blue.shade100;
    if (contador < 20) return Colors.orange.shade100;
    return Colors.red.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game contagem', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      backgroundColor: getCorFundo(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedSwitcher(
              duration: Duration(milliseconds: 400),
              transitionBuilder: (child, animation) =>
                  ScaleTransition(scale: animation, child: child),
              child: Text(
                '$contador',
                key: ValueKey(contador),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 10),
            Text(
              getMensagem(),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: _aumentar,
              icon: Icon(Icons.add),
              label: Text('Aumentar'),
            ),
            ElevatedButton.icon(
              onPressed: _diminuir,
              icon: Icon(Icons.remove),
              label: Text('Aumentar'),
            ),
          ],
        ),
      ),
    );
  }
}
