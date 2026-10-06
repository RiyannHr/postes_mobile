import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final Function(CartItem, int) onUpdateQuantity;
  final int grandTotal;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.onUpdateQuantity,
    required this.grandTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Sambal"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          cartItems.isEmpty
              ? const Center(
                  child: Text(
                    "Keranjang masih kosong",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      bottom: 100, left: 16, right: 16, top: 16),
                  child: Column(
                    children: cartItems.map((item) {
                      return CartItemTile(
                        item: item,
                        onQuantityChanged: (newQty) {
                          onUpdateQuantity(item, newQty);
                        },
                      );
                    }).toList(),
                  ),
                ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Total Harga",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        "Rp $grandTotal",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                    ),
                    onPressed: grandTotal > 0
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Checkout Berhasil!")),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.shopping_bag, size: 18),
                    label: const Text("Beli Sekarang"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemTile extends StatefulWidget {
  final CartItem item;
  final ValueChanged<int> onQuantityChanged;

  const CartItemTile({
    super.key,
    required this.item,
    required this.onQuantityChanged,
  });

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  late TextEditingController _quantityController;

  @override
  void initState() {
    super.initState();
    _quantityController =
        TextEditingController(text: '${widget.item.quantity}');
  }

  @override
  void didUpdateWidget(covariant CartItemTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.quantity != widget.item.quantity &&
        _quantityController.text != '${widget.item.quantity}') {
      _quantityController.text = '${widget.item.quantity}';
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  void _updateQuantity(String value) {
    final parsed = int.tryParse(value);
    if (parsed == null || parsed < 1) return;
    widget.onQuantityChanged(parsed.clamp(1, widget.item.sambal.stok));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.item.sambal.imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image, color: Colors.grey),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.sambal.nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rp ${widget.item.sambal.harga}",
                  style: const TextStyle(
                      color: Colors.deepOrange, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 4),
                isDense: true,
                border: OutlineInputBorder(),
              ),
              controller: _quantityController,
              onChanged: _updateQuantity,
            ),
          ),
        ],
      ),
    );
  }
}