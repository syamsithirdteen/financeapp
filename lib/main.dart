import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const FinanceMateApp());
}

class FinanceMateApp extends StatelessWidget {
  const FinanceMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceMate Pro', // Mengubah nama aplikasi
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Mengubah tema menjadi Indigo untuk kesan profesional
        colorSchemeSeed: Colors.indigo,
        // Warna latar belakang yang lebih bersih untuk Scaffold
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        useMaterial3: true,
        // Mendefinisikan tema teks secara eksplisit
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
        // Tema AppBar yang bersih (digunakan oleh SliverAppBar)
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F9FC),
          elevation: 0, // Menghilangkan bayangan
          foregroundColor: Colors.black,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
