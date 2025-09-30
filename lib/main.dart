// ignore_for_file: unused_field, prefer_final_fields, unused_element, unused_local_variable, sort_child_properties_last

import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: CalculadoraIMC()),
  );
}

class CalculadoraIMC extends StatefulWidget {
  const CalculadoraIMC({super.key});

  @override
  State<CalculadoraIMC> createState() => _CalculadoraIMCState();
}

class _CalculadoraIMCState extends State<CalculadoraIMC> {
  final _formKey = GlobalKey<FormState>();
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();

  String _resultado = 'Informe seus dados';

  void _limparCampos() {
    _pesoController.clear();
    _alturaController.clear();
    setState(() {
      _resultado = 'Informe seus dados';
    });
  }

  void _calcularImc() {
    final peso = double.tryParse(_pesoController.text);
    final altura = double.tryParse(_alturaController.text);

    if (peso == null || altura == null || peso <= 0 || altura <= 0) {
      setState(() {
        _resultado = 'Por favor, digite informações válidas';
      });
      return;
    }

    double imc = peso / (pow(altura, 2));
    String classificacao;

    if (imc < 18.5) {
      classificacao = 'Baixo peso';
    } else if (imc < 25) {
      classificacao = 'Peso normal';
    } else if (imc < 30) {
      classificacao = 'Sobrepeso';
    } else if (imc < 35) {
      classificacao = 'Obesidade I';
    } else if (imc < 40) {
      classificacao = 'Obesidade II';
    } else {
      classificacao = 'Obesidade III';
    }

    setState(() {
      _resultado =
          'IMC: ${imc.toStringAsFixed(1)}\nClassificação: $classificacao';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _limparCampos,
            color: Colors.white,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildCampoTexto(
                controller: _pesoController,
                label: 'Peso',
                error: 'Peso inválido',
                max: 635,
              ),
              SizedBox(height: 20),
              _buildCampoTexto(
                controller: _alturaController,
                label: 'Altura',
                error: 'Altura inválida',
                max: 2.72,
              ),
              SizedBox(height: 20),
              _buildResultado(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calcularImc();
                  }
                },
                child: Text(
                  'CALCULAR',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCampoTexto({
    required TextEditingController controller,
    required String label,
    required String error,
    required double max,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      validator: (text) {
        final value = double.tryParse(text ?? '');
        if (value == null || value <= 0 || value > max) {
          return 'Por favor, insira dados válidos';
        }
        return null;
      },
    );
  }

  Widget _buildResultado() {
    return Text(
      _resultado,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    );
  }
}
