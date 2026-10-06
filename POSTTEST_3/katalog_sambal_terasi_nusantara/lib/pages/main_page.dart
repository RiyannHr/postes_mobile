import 'package:flutter/material.dart';
import '../models/sambal_model.dart';
import '../models/cart_item.dart';
import 'sambal_home_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  final List<SambalModel> sambalList;
  final List<CartItem> cartItems;
  final Function(SambalModel) onAddToCart;
  final Function(CartItem, int) onUpdateQuantity;
  final int grandTotal;

  const MainPage({
    super.key,
    required this.sambalList,
    required this.cartItems,
    required this.onAddToCart,
    required this.onUpdateQuantity,
    required this.grandTotal,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      SambalHomePage(
        sambalList: widget.sambalList,
        onAddToCart: widget.onAddToCart,
      ),
      CartPage(
        cartItems: widget.cartItems,
        onUpdateQuantity: widget.onUpdateQuantity,
        grandTotal: widget.grandTotal,
      ),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}