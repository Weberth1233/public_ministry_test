import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataComponent extends StatelessWidget {
  const NoDataComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/cadastro.json',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            repeat: true,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              'Sem dados!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              'Faça seu  primeiro cadastro na plataforma!',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
