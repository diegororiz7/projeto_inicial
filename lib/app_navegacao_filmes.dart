// ignore_for_file: prefer_final_fields, unused_field, unused_element, override_on_non_overriding_member, unused_local_variable, unnecessary_const

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
      appBar: AppBar(
        title: Text(
          _titulos[_paginaAtual],
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
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
        {
          'titulo': 'Mad Max',
          'ano': '2015',
          'nota': '8.1',
          'cartaz': 'src/mad_max.jpg',
        },
        {
          'titulo': 'John Wick',
          'ano': '2014',
          'nota': '7.4',
          'cartaz': 'src/john_wick.jpg',
        },
      ],
      'Comédia': [
        {
          'titulo': 'Se beber não case',
          'ano': '2009',
          'nota': '7.7',
          'cartaz': 'src/se_beber.jpg',
        },
        {
          'titulo': 'As branquelas',
          'ano': '2004',
          'nota': '5.7',
          'cartaz': 'src/as_branquelas.jpg',
        },
      ],
      'Drama': [
        {
          'titulo': 'À procura da felicidade',
          'ano': '2006',
          'nota': '8.0',
          'cartaz': 'src/procura_felicidade.jpg',
        },
        {
          'titulo': 'Clube da luta',
          'ano': '1999',
          'nota': '8.8',
          'cartaz': 'src/clube_luta.jpg',
        },
      ],
    };

    final filmes = filmesPorCategoria[categoriaArg] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filmes de $categoriaArg',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          final filme = filmes[index];
          return Card(
            elevation: 3,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.movie_creation, color: Colors.indigo),
              title: Text(filme['titulo'] ?? ''),
              subtitle: Text('Ano: ${filme['ano']} . Nota: ${filme['nota']}'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/detalhe', arguments: filme);
              },
            ),
          );
        },
      ),
    );
  }
}

class TelaDetalheFilme extends StatelessWidget {
  final Map<String, String> filme;
  const TelaDetalheFilme({super.key, required this.filme});

  @override
  Widget build(BuildContext context) {
    final filmeArg = filme.isEmpty
        ? ModalRoute.of(context)!.settings.arguments as Map<String, String>
        : filme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          filmeArg['titulo'] ?? '',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                filmeArg['cartaz'] ?? '',
                width: 300,
                height: 450,
                fit: BoxFit.contain,
              ),
              Text(
                filmeArg['titulo'] ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Text('Ano: ${filmeArg['ano']}', style: TextStyle(fontSize: 16)),
              Text('Nota: ${filmeArg['nota']}', style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Catálogo de Filmes\nVersão 1.0\nDesenvolvido com Flutter',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
