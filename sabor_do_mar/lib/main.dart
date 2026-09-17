import 'package:flutter/material.dart';
import 'tela_inicial.dart';
import 'tema.dart';

void main() => runApp(const Principal());

class Principal extends StatelessWidget {
  // Trabalho de Desenvolvimento para Dispositivos Móveis 1 (ISW-012).
  // Autores: Ana Carolina Sabino e Caio Henrique C. R. Cunha.
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sabor do Mar • Temakeria',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: creme,
        colorScheme: ColorScheme.fromSeed(seedColor: verde),
        appBarTheme: const AppBarTheme(
          backgroundColor: verde,
          foregroundColor: Colors.white,
          centerTitle: true,
          toolbarHeight: 84,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: turquesa,
            foregroundColor: Colors.white,
            minimumSize: const Size(48, 48),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
      home: const TelaInicial(),
    );
  }
}
