// ignore_for_file: unused_import, use_key_in_widget_constructors, unused_local_variable, sort_child_properties_last

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<String> destinos = [
    'Maragogi',
    'Alexandria',
    'Gramado',
    'Sem viagem por enquanto',
  ];

  String fraseAtual = 'Clique no botão e descubra seu destino';

  void gerarDestino() {
    final random = Random();
    setState(() {
      fraseAtual = destinos[random.nextInt(destinos.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Próxima viagem', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  fraseAtual,
                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: gerarDestino,
                  child: Text(
                    'Seu próximo destino',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
