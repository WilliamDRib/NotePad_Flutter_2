import 'package:flutter/material.dart';

@override
class About extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Sobre',
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Criador: William Dutra Ribeiro \n\nApp: O aplicativo é um bloco de anotações criado em Flutter com um sistema de armazenagem local',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
}
