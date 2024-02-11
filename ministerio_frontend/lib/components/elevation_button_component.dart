import 'package:flutter/material.dart';

class ElevationButtonComponent extends StatelessWidget {
  final VoidCallback action;
  final String label;

  const ElevationButtonComponent(
      {super.key, required this.action, required this.label});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.purple),
      ),
      child: Text(
        label,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
