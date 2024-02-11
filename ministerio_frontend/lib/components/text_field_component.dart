import 'package:flutter/material.dart';

class TextFielComponent extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;

  const TextFielComponent(
      {super.key, required this.textEditingController, required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        decoration:
            InputDecoration(labelText: label, border: const OutlineInputBorder()));
  }
}
