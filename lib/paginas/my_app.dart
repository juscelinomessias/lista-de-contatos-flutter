import 'package:flutter/material.dart';
import 'package:lista_de_contatos/paginas/home_contatos.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.amber),
      home: const HomeContatos(),
    );
  }
}
