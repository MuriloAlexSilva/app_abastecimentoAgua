import 'package:app_abastecimento_agua/components/formFieldCustom.dart';
import 'package:flutter/widgets.dart';

class Controller extends ChangeNotifier {
  int qtddGarrafas;

  Controller({this.qtddGarrafas});

  List<FormFieldCustom> listaFormField = List<FormFieldCustom>();

  addGarrafas() {
    this.qtddGarrafas++;
  }

  addFormField(Widget widget) {
    listaFormField.add(widget);
    addGarrafas();

    notifyListeners();
  }
}
