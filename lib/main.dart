import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lista_de_contatos/paginas/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Impede a rotação para paisagem
    DeviceOrientation.portraitDown, // Impede a rotação para paisagem invertida
  ]).then((_) {
    runApp(const MyApp());
  });
}
