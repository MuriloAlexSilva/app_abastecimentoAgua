import 'dart:math';

import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController capacidadeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("App de Abastecimento de Água"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: capacidadeController,
                keyboardType: TextInputType.numberWithOptions(decimal: false),
                decoration:
                    InputDecoration(hintText: "Digite a capacidade desejada."),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                  child: Text("Calcular"),
                  onPressed: () {
                    final int capacidade =
                        int.tryParse(capacidadeController.text);
                    setState(() {
                      int galao = 0;
                      int garrafa = 0;

                      var garrafasUtilizadas = [];

                      for (int i = 0; galao <= capacidade; i++) {
                        garrafa = Random().nextInt(6) + 1;
                        if ((galao + garrafa) < capacidade) {
                          garrafasUtilizadas.add(garrafa);
                          galao += garrafa;
                        }
                        if ((galao + garrafa) == capacidade) {
                          garrafasUtilizadas.add(garrafa);
                          galao += garrafa;
                          print("galão $galao");
                          print(garrafasUtilizadas);

                          return garrafasUtilizadas;
                        } else {
                          continue;
                        }
                      }
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

encher(int capacidade) {
  int galao = 0;
  int garrafa = 0;
  var garrafasUtilizadas = [];

  for (int i = 0; galao <= capacidade; i++) {
    garrafa = Random().nextInt(6) + 1;
    if ((galao + garrafa) < capacidade) {
      garrafasUtilizadas.add(garrafa);
      galao += garrafa;
    }
    if ((galao + garrafa) == capacidade) {
      garrafasUtilizadas.add(garrafa);
      galao += garrafa;
      print("galão $galao");
      return garrafasUtilizadas;
    } else {
      continue;
    }
  }
}
