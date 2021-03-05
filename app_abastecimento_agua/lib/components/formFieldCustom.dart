import 'package:flutter/material.dart';

class FormFieldCustom extends StatelessWidget {
  final TextEditingController controller;

  const FormFieldCustom({Key key, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Informe o volume da garrafa',
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
