import 'package:flutter/material.dart';

class FormGeral extends StatelessWidget {
  final void Function(String value) onChanged;
  final TextEditingController controllerText;
  final String labelText;
  final String hintText;

  const FormGeral({
    Key? key,
    required this.onChanged,
    required this.controllerText,
    required this.labelText,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      controller: controllerText,
      onChanged: (value) {
        onChanged(value);
      },
      style: const TextStyle(fontSize: 15, color: Colors.white),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 10, 5),
          labelText: labelText,
          labelStyle: const TextStyle(color: Colors.white),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 10, color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.white),
          )),
    );
  }
}
