import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendaftarkan CartProvider menggunakan MultiProvider di tingkat root aplikasi
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Katalog Resep Sambal Nusantara',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Times New Roman',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        // MainPage dipanggil tanpa parameter karena sudah menggunakan Provider
        home: const MainPage(),
      ),
    );
  }
}