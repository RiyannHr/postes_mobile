import 'package:flutter/material.dart';
import 'models/sambal_model.dart';
import 'models/cart_item.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // State global daftar sambal
  final List<SambalModel> _sambalList = [
    SambalModel(
      nama: 'Sambal Terasi',
      deskripsi: 'Pedas manis khas Jawa dengan aroma terasi bakar.',
      waktu: '15 Mins',
      imagePath: 'assets/sambal.terasi.jpeg',
      harga: 10000,
      stok: 10,
    ),
    SambalModel(
      nama: 'Sambal Matah',
      deskripsi: 'Sambal iris mentah khas Bali yang segar dan harum.',
      waktu: '10 Mins',
      imagePath: 'assets/sambalmentah.webp',
      harga: 5000,
      stok: 5,
    ),
    SambalModel(
      nama: 'Sambal Hijau',
      deskripsi: 'Sambal khas Minang dari cabai hijau segar.',
      waktu: '20 Mins',
      imagePath: 'assets/sambalhijau.jpg',
      harga: 10000,
      stok: 5, // Contoh stok habis agar tombol disable
    ),
  ];

  final List<CartItem> _cartItems = [];

  void _addToCart(SambalModel sambal) {
    setState(() {
      final index = _cartItems.indexWhere((item) => item.sambal.nama == sambal.nama);
      if (index >= 0) {
        _cartItems[index].quantity++;
      } else {
        _cartItems.add(CartItem(sambal: sambal, quantity: 1));
      }
    });
  }

  void _updateQuantity(CartItem item, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeWhere((cartItem) => cartItem.sambal.nama == item.sambal.nama);
      } else {
        item.quantity = newQuantity;
      }
    });
  }

  int get _grandTotal {
    int total = 0;
    for (var item in _cartItems) {
      total += item.sambal.harga * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Resep Sambal Nusantara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Times New Roman',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: MainPage(
        sambalList: _sambalList,
        cartItems: _cartItems,
        onAddToCart: _addToCart,
        onUpdateQuantity: _updateQuantity,
        grandTotal: _grandTotal,
      ),
    );
  }
}