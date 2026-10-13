import 'package:flutter/material.dart';
import '../models/sambal_model.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
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
      stok: 5,
    ),
  ];

  final List<CartItem> _cartItems = [];

  List<SambalModel> get sambalList => _sambalList;
  List<CartItem> get cartItems => _cartItems;

  // Fungsi menambah ke keranjang dan mengurangi stok
  void addToCart(SambalModel sambal) {
    if (sambal.stok <= 0) return;
    sambal.stok--; // Mengurangi stok produk

    final index = _cartItems.indexWhere((item) => item.sambal.nama == sambal.nama);
    if (index >= 0) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(CartItem(sambal: sambal, quantity: 1));
    }
    notifyListeners(); // Memberi tahu widget yang mendengarkan perubahan[cite: 6]
  }

  // Fungsi memperbarui kuantitas di keranjang
  void updateQuantity(CartItem item, int newQuantity) {
    if (newQuantity <= 0) {
      item.sambal.stok += item.quantity; // Kembalikan stok jika item dihapus
      _cartItems.removeWhere((cartItem) => cartItem.sambal.nama == item.sambal.nama);
    } else {
      int diff = newQuantity - item.quantity;
      if (diff > 0 && item.sambal.stok >= diff) {
        item.sambal.stok -= diff;
        item.quantity = newQuantity;
      } else if (diff < 0) {
        item.sambal.stok += -diff;
        item.quantity = newQuantity;
      }
    }
    notifyListeners();
  }

  // Hitung grand total harga
  int get grandTotal {
    int total = 0;
    for (var item in _cartItems) {
      total += item.sambal.harga * item.quantity;
    }
    return total;
  }
}