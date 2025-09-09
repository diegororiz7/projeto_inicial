// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Scaffold e Widgets',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),

      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(child: Center(child: Text('Lista de ícones'))),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                print('Clicou em Home');
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                print('Clicou em Settings');
              },
            ),
          ],
        ),
      ),

      body: Center(
        child: Text(
          'Bem-vindo ao Scaffold',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_a_photo),
        onPressed: () {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Foto tirada!')));
        },
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.alarm, color: Colors.red),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Alarme acionado!')));
              },
            ),
            IconButton(
              icon: Icon(Icons.gif_box, color: Colors.green),
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Caixa acionada!')));
              },
            ),
          ],
        ),
      ),

      persistentFooterButtons: [
        IconButton(
          icon: Icon(Icons.laptop),
          onPressed: () {
            print('ADS');
          },
        ),
        IconButton(
          icon: Icon(Icons.school),
          onPressed: () {
            print('FASM');
          },
        ),
      ],
    );
  }
}
