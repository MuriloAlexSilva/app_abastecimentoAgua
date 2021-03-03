import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;
  TextEditingController capacidadeController = TextEditingController();
  TextEditingController garrafa1Controller = TextEditingController();
  TextEditingController garrafa2Controller = TextEditingController();
  TextEditingController garrafa3Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "App de Abastecimento de Água",
      home: Scaffold(
        appBar: AppBar(
          title: Text("App de Abastecimento de Água"),
          centerTitle: true,
        ),
        body: Stepper(
          type: StepperType.vertical,
          physics: ScrollPhysics(),
          currentStep: _currentStep,
          onStepTapped: (step) => tapped(step),
          onStepContinue: continued,
          onStepCancel: cancel,
          steps: [
            Step(
              title: Text("Qual o volume do galão?"),
              content: Column(
                children: [
                  TextFormField(
                    controller: capacidadeController,
                    decoration: InputDecoration(
                      labelText: 'Informe o volume',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "O volume desejado deverá ser numeros inteiros(Ex.: 1,2,3 etc...)"),
                  )
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: Text("Qual o volume das garrafas desejadas?"),
              content: Column(
                children: [
                  TextFormField(
                    controller: garrafa1Controller,
                    decoration: InputDecoration(
                      labelText: 'Informe o volume da 1ª garrafa',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "O volume desejado deverá ser numeros inteiros(Ex.: 1,2,3 etc...)"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: garrafa2Controller,
                    decoration: InputDecoration(
                      labelText: 'Informe o volume da 2ª garrafa',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "O volume desejado deverá ser numeros inteiros(Ex.: 1,2,3 etc...)"),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: garrafa3Controller,
                    decoration: InputDecoration(
                      labelText: 'Informe o volume da 3ª garrafa',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "O volume desejado deverá ser numeros inteiros(Ex.: 1,2,3 etc...)"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Cuidado!!! Se atentar quanto ao volume da soma das garrafas, para que não haja desperdício ao encher seu galão!!!",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 1 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title: Text("Vamos calcular a quantidade?"),
              content: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Vamos calcular a quantidade?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        "Se sim clique em Continue, caso contrário retorne e realize as alterações desejadas")
                  ],
                ),
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  continued() {
    _currentStep < 2
        ? setState(() => _currentStep += 1)
        : setState(() {
            final int capacidade = int.tryParse(capacidadeController.text);
            final int garrafa1 = int.tryParse(garrafa1Controller.text) ?? 0;
            final int garrafa2 = int.tryParse(garrafa2Controller.text) ?? 0;
            final int garrafa3 = int.tryParse(garrafa3Controller.text) ?? 0;
            final int somaGarrafas = garrafa1 + garrafa2 + garrafa3;

            if (somaGarrafas == capacidade) {
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros,${garrafa2.toString()} litros e ${garrafa3.toString()} litros, sem desperdícios, Parabéns!!!"),
                    );
                  });
            } else if (somaGarrafas >= capacidade) {
              int desperdicio = somaGarrafas - capacidade;
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros,${garrafa2.toString()} litros e ${garrafa3.toString()} litros, porém houve uma sobra de $desperdicio litro(s), Tome Cuidado!!!"),
                    );
                  });
            } else {
              int falta = capacidade - somaGarrafas;
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros,${garrafa2.toString()} litros e ${garrafa3.toString()} litros, porém ainda falta(m) $falta litro(s) para completar, reveja as garrafas utilizadas."),
                    );
                  });
            }
          });
  }

  // _validaEstado(context, novaTransferencia, valor) {
  //   Provider.of<Transferencias>(context, listen: false)
  //       .adiciona(novaTransferencia);
  //   Provider.of<Saldo>(context, listen: false).subtrair(valor);
  // }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
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
