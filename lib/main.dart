// ignore_for_file: depend_on_referenced_packages, unused_import, unused_field, prefer_final_fields, dead_code, empty_catches, unused_local_variable, use_build_context_synchronously, avoid_print, use_full_hex_values_for_flutter_colors, unnecessary_brace_in_string_interps

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
  String? dataHoraCotacao;
  bool carregando = false;

  final List<String> moedas = ['USD', 'BRL', 'EUR', 'ARS', 'CAD', 'JPY', 'BTC'];

  final List<String> historico = [];

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
      carregando = false;
      cotacao = null;
      resultado = null;
      dataHoraCotacao = null;
    });

    try {
      final url = 'https://economia.awesomeapi.com.br/json/last/$de-$para';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final key = '$de$para';
        final taxa = double.parse(data[key]['bid']);
        final dataCotacao = data[key]['create_date'];

        final valorConvertido = double.parse(valor) * taxa;

        setState(() {
          carregando = false;
          cotacao = taxa;
          dataHoraCotacao = dataCotacao;
          resultado = valorConvertido.toStringAsFixed(2);

          historico.insert(0, '$valor $de -> $resultado $para $dataCotacao');
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
      backgroundColor: Colors.white,
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
              buildDropDown('De', de, (val) {
                setState(() {
                  de = val!;
                });
              }),
              buildDropDown('Para', para, (val) {
                setState(() {
                  para = val!;
                });
              }),
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
              if (carregando) ...[
                SizedBox(height: 30),
                CircularProgressIndicator(color: Colors.blue),
              ],
              if (resultado != null && cotacao != null) ...[
                SizedBox(height: 30),
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valor digitado: ${_controller.text} $de',
                        style: resultStyle,
                      ),
                      if (dataHoraCotacao != null) ...[
                        Text(
                          'Data da cotação: $dataHoraCotacao',
                          style: resultStyle,
                        ),
                      ],
                      Text(
                        'Cotação: 1 $de = ${cotacao!.toStringAsFixed(4)} $para',
                        style: resultStyle,
                      ),
                      Text(
                        'Valor convertido: $resultado $para',
                        style: resultStyle,
                      ),
                    ],
                  ),
                ),
              ],
              /*if (historico.isNotEmpty) ...[
                SizedBox(height: 30),
                Text(
                  'Histórico de conversões',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  itemCount: historico.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.history),
                      title: Text(historico[index]),
                    );
                  },
                ),
              ],*/
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropDown(
    String label,
    String value,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: DropdownButton<String>(
              value: value,
              underline: SizedBox(),
              items: moedas
                  .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get resultStyle => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.green.shade800,
  );
}
