import 'dart:ui';
import 'package:app_abastecimento_agua/components/formFieldCustom.dart';
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
  TextEditingController qtddGarrafaController = TextEditingController();
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
              title: Text("Informe a quantidade de litros do galão?"),
              content: Column(
                children: [
                  TextFormField(
                    controller: capacidadeController,
                    decoration: InputDecoration(
                      labelText: 'Informe o volume',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              isActive: _currentStep >= 0,
              state:
                  _currentStep >= 0 ? StepState.complete : StepState.disabled,
            ),
            Step(
              title:
                  Text("Informe a quantidade de garrafas a serem utilizadas?"),
              content: Column(
                children: [
                  TextFormField(
                    controller: qtddGarrafaController,
                    decoration: InputDecoration(
                      labelText: 'Informe a quantidade de garrafas',
                    ),
                    keyboardType: TextInputType.number,
                  ),
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
                  FormFieldCustom(controller: garrafa1Controller),
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
    _currentStep < 3
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
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros, ${garrafa2.toString()} litros e ${garrafa3.toString()} litros, sem desperdícios, Parabéns!!!"),
                    );
                  });
            } else if (somaGarrafas >= capacidade) {
              int desperdicio = somaGarrafas - capacidade;
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros, ${garrafa2.toString()} litros e ${garrafa3.toString()} litros, porém houve uma sobra de $desperdicio litro(s), Tome Cuidado!!!"),
                    );
                  });
            } else {
              int falta = capacidade - somaGarrafas;
              return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                          "Foram utilizadas as garrafas de ${garrafa1.toString()} litros, ${garrafa2.toString()} litros e ${garrafa3.toString()} litros, porém ainda falta(m) $falta litro(s) para completar, reveja as garrafas utilizadas."),
                    );
                  });
            }
          });
  }

  cancel() {
    _currentStep > 0 ? setState(() => _currentStep -= 1) : null;
  }
}
