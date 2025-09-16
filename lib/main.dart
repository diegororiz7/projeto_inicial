// ignore_for_file: unused_import, prefer_final_fields, unused_field, unused_element, unnecessary_import, unnecessary_string_interpolations, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import 'dart:math';
import 'dart:ui';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de investimentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.green),
      home: CalculadoraInvestimento(),
    );
  }
}

class CalculadoraInvestimento extends StatefulWidget {
  const CalculadoraInvestimento({super.key});

  @override
  State<CalculadoraInvestimento> createState() =>
      _CalculadoraInvestimentoState();
}

class _CalculadoraInvestimentoState extends State<CalculadoraInvestimento> {
  TextStyle _textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);

  static final NumberFormat formatoReal = NumberFormat.currency(
    locale: 'pt-br',
  );

  double _investimentoMensal = 0;
  double _anosInvestindo = 0;
  double _resultado = 0;
  double _rentabilidadeAnual = 0;
  double _valorInvestido = 0;
  double _patrimonioAcumulado = 0;

  void _atualizarValorInvestido() {
    setState(() {
      _valorInvestido = _investimentoMensal * (_anosInvestindo * 12);
    });
  }

  void _atualizarResultado() {
    setState(() {
      _resultado =
          (_investimentoMensal *
                  (pow(
                        1 + (_rentabilidadeAnual / 12 / 100),
                        (_anosInvestindo * 12),
                      ) -
                      1)) /
              (_rentabilidadeAnual / 12 / 100) -
          _valorInvestido;
    });
  }

  void _atualizarPatrimonioAcumulado() {
    setState(() {
      _patrimonioAcumulado = _valorInvestido + _resultado;
    });
  }

  Widget textoTitulo() {
    return Text(
      'Calculadora de Investimentos',
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  Widget imagemCalculadora() {
    return SizedBox(
      height: 50,
      child: Image.asset('src/rentabilidade.jpg', fit: BoxFit.contain),
    );
  }

  Widget cardInvestimento() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text('Aporte mensal:', style: _textStyle),
                  Spacer(),
                  Text(
                    '${formatoReal.format(_investimentoMensal)}',
                    style: _textStyle,
                  ),
                ],
              ),
            ),
            Slider(
              value: _investimentoMensal,
              min: 0,
              max: 10000,
              divisions: 10000,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  _investimentoMensal = value;
                });
                _atualizarValorInvestido();
                _atualizarResultado();
                _atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardTempo() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text('Tempo de investimento:', style: _textStyle),
                  Spacer(),
                  Text(_anosInvestindo.toString() + ' anos', style: _textStyle),
                ],
              ),
            ),
            Slider(
              value: _anosInvestindo,
              min: 0,
              max: 10,
              divisions: 10,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  _anosInvestindo = value;
                });
                _atualizarValorInvestido();
                _atualizarResultado();
                _atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardRentabilidade() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  Text('Rentabilidade anual:', style: _textStyle),
                  Spacer(),
                  Text(_rentabilidadeAnual.toString() + '%', style: _textStyle),
                ],
              ),
            ),
            Slider(
              value: _rentabilidadeAnual,
              min: 0,
              max: 25,
              divisions: 50,
              activeColor: Colors.green.shade700,
              inactiveColor: Colors.green.shade100,
              onChanged: (double value) {
                setState(() {
                  _rentabilidadeAnual = value;
                });
                _atualizarValorInvestido();
                _atualizarResultado();
                _atualizarPatrimonioAcumulado();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget cardResultado() {
    return Card(
      margin: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(14),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.only(top: 14, bottom: 8),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Valor investido:', style: _textStyle),
                      Text(
                        '${formatoReal.format(_valorInvestido)}',
                        style: _textStyle,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rendimento:', style: _textStyle),
                      Text(
                        '${formatoReal.format(_resultado)}',
                        style: _textStyle,
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Patrimônio acumulado:', style: _textStyle),
                      Text(
                        '${formatoReal.format(_patrimonioAcumulado)}',
                        style: _textStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            textoTitulo(),
            SizedBox(height: 10),
            imagemCalculadora(),
            cardInvestimento(),
            cardTempo(),
            cardRentabilidade(),
            cardResultado(),
          ],
        ),
      ),
    );
  }
}
