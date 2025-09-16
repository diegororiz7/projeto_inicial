// ignore_for_file: unused_import, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Pais {
  String nome;
  String capital;
  String localizacao;
  String imagemUrl;
  bool curtido;

  Pais({
    required this.nome,
    required this.capital,
    required this.localizacao,
    required this.imagemUrl,
    this.curtido = false,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Paises',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal),
      home: ListaPaises(),
    );
  }
}

class ListaPaises extends StatefulWidget {
  const ListaPaises({super.key});

  @override
  State<ListaPaises> createState() => _ListaPaisesState();
}

class _ListaPaisesState extends State<ListaPaises> {
  final List<Pais> paises = [
    Pais(
      nome: 'Brasil',
      capital: 'Brasília',
      localizacao: 'América do Sul',
      imagemUrl: 'https:flagcdn.com/w320/br.png',
    ),
    Pais(
      nome: 'Argentina',
      capital: 'Buenos Aires',
      localizacao: 'América do Sul',
      imagemUrl: 'https:flagcdn.com/w320/ar.png',
    ),
    Pais(
      nome: 'Portugal',
      capital: 'Lisboa',
      localizacao: 'Europa',
      imagemUrl: 'https:flagcdn.com/w320/pt.png',
    ),
    Pais(
      nome: 'Inglaterra',
      capital: 'Londres',
      localizacao: 'Europa',
      imagemUrl: 'https://flagcdn.com/w320/gb.png',
    ),
  ];

  void clicarCurtir(int index) {
    setState(() {
      paises[index].curtido = !paises[index].curtido;
    });
  }

  Widget linhaInfo(String emoji, String texto) {
    return Row(
      children: [
        Text(emoji, style: TextStyle(fontSize: 18)),
        Spacer(),
        Text(texto, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Paises', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: ListView.builder(
        itemCount: paises.length,
        itemBuilder: (context, index) {
          final pais = paises[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            elevation: 3,
            child: ListTile(
              leading: Image.network(
                pais.imagemUrl,
                width: 40,
                height: 50,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(Icons.flag),
              ),
              title: Text(
                pais.nome,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    linhaInfo('🏛️', pais.capital),
                    linhaInfo('📍', pais.localizacao),
                  ],
                ),
              ),
              trailing: IconButton(
                icon: Icon(
                  pais.curtido ? Icons.favorite : Icons.favorite_border,
                ),
                color: pais.curtido ? Colors.red : Colors.white,
                onPressed: () => clicarCurtir(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
