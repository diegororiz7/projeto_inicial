// ignore_for_file: prefer_final_fields, unused_field, unused_element, override_on_non_overriding_member, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(FilmesApp());
}

class FilmesApp extends StatelessWidget {
  const FilmesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Filmes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.indigo),
      initialRoute: '/',
      routes: {
        '/': (context) => TelaBase(),
        '/filmes': (context) => TelaFilmes(categoria: ''),
        '/detalhe': (context) => TelaDetalheFilme(filme: {}),
      },
    );
  }
}

class TelaBase extends StatefulWidget {
  const TelaBase({super.key});

  @override
  State<TelaBase> createState() => _TelaBaseState();
}

class _TelaBaseState extends State<TelaBase> {
  int _paginaAtual = 0;

  final List<Widget> _telas = const [TelaCategorias(), TelaSobre()];

  final List<String> _titulos = const ['Categorias', 'Sobre'];

  void _mudarPagina(int index) {
    setState(() {
      _paginaAtual = index;
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titulos[_paginaAtual])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Center(
                child: Text(
                  'Catálogo de filmes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie, color: Colors.indigo),
              title: Text('Categorias'),
              onTap: () {
                _mudarPagina(0);
              },
            ),
            ListTile(
              leading: Icon(Icons.info, color: Colors.indigo),
              title: Text('Sobre'),
              onTap: () {
                _mudarPagina(1);
              },
            ),
          ],
        ),
      ),
      body: _telas[_paginaAtual],
    );
  }
}

class TelaCategorias extends StatelessWidget {
  const TelaCategorias({super.key});

  final categorias = const ['Ação', 'Comédia', 'Drama'];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(12),
          elevation: 3,
          child: ListTile(
            leading: const Icon(Icons.local_movies, color: Colors.indigo),
            title: Text(
              categorias[index],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/filmes',
                arguments: categorias[index],
              );
            },
          ),
        );
      },
    );
  }
}

class TelaFilmes extends StatelessWidget {
  final String categoria;
  const TelaFilmes({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    final categoriaArg = categoria.isEmpty
        ? ModalRoute.of(context)!.settings.arguments as String
        : categoria;

    final filmesPorCategoria = {
      'Ação': [
        {'titulo': 'Mad Max', 'ano': '2015', 'nota': '8.1'},
        {'titulo': 'John Wick', 'ano': '2014', 'nota': '7.4'},
      ],
      'Comédia': [
        {'titulo': 'Se beber não case', 'ano': '2009', 'nota': '7.7'},
        {'titulo': 'As branquelas', 'ano': '2004', 'nota': '5.7'},
      ],
      'Drama': [
        {'titulo': 'À procura da felicidade', 'ano': '2006', 'nota': '8.0'},
        {'titulo': 'Clube da luta', 'ano': '1999', 'nota': '8.8'},
      ],
    };

    final filmes = filmesPorCategoria[categoriaArg] ?? [];

    return const Placeholder();
  }
}
