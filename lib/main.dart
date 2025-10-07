// ignore_for_file: depend_on_referenced_packages, unused_import, unused_field, prefer_final_fields, dead_code, empty_catches, unused_local_variable, use_build_context_synchronously, avoid_print, use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: ConversorMoeda()),
  );
}

class ConversorMoeda extends StatefulWidget {
  const ConversorMoeda({super.key});

  @override
  State<ConversorMoeda> createState() => _ConversorMoedaState();
}

class _ConversorMoedaState extends State<ConversorMoeda> {
  final TextEditingController _controller = TextEditingController();

  String de = 'USD';
  String para = 'BRL';
  double? cotacao;
  String? resultado;
  bool carregando = false;

  final List<String> modedas = [
    'USD',
    'BRL',
    'EUR',
    'ARS',
    'CAD',
    'JPY',
    'BTC',
  ];

  Future<void> converter() async {
    final valor = _controller.text;
    if (valor.isEmpty ||
        double.tryParse(valor) == null ||
        double.tryParse(valor)! < 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Digite um valor válido')));
      return;
    }

    setState(() {
      carregando = true;
      cotacao = null;
      resultado = null;
    });

    try {
      final url = 'https://economia.awesomeapi.com.br/json/last/$de-$para';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final key = '$de$para';
        final taxa = double.parse(data[key]['bid']);

        final valorConvertido = double.parse(valor) * taxa;

        setState(() {
          carregando = false;
          cotacao = taxa;
          resultado = valorConvertido.toStringAsFixed(2);
        });
      } else {
        throw Exception('Erro na API');
      }
    } catch (e) {
      print('Erro na conversão: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar cotação, tente novamente!')),
      );
    } finally {
      setState(() {
        carregando = false;
      });
    }
  }

  void inverter() {
    setState(() {
      final temp = de;
      de = para;
      para = temp;
      resultado = null;
      cotacao = null;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text(
          'Conversor de Moedas',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              /*buildDropDown('De', de, (val) {
                setState(() {
                  de = val!;
                });
              }),
              buildDropDown('Para', para, (val) {
                setState(() {
                  para = val!;
                });
              }),*/
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: inverter,
                child: Text('Inverter moeda'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Valor para converter',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: converter,
                child: Text('Converter moeda'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
