import 'package:flutter/material.dart';
import '../models/sambal_model.dart';
import 'detail_sambal_page.dart';

class SambalHomePage extends StatefulWidget {
  final List<SambalModel> sambalList;
  final Function(SambalModel) onAddToCart;

  const SambalHomePage({
    super.key,
    required this.sambalList,
    required this.onAddToCart,
  });

  @override
  State<SambalHomePage> createState() => _SambalHomePageState();
}

class _SambalHomePageState extends State<SambalHomePage> {
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final visibleProducts = widget.sambalList.where((product) {
      return product.nama.toLowerCase().contains(_searchQuery);
    }).toList();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Katalog Sambal Nusantara'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Cari resep sambal...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Daftar Sambal Populer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleProducts.length,
                itemBuilder: (context, index) {
                  final product = visibleProducts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildSambalItem(context, product),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSambalItem(BuildContext context, SambalModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailSambalPage(
              sambal: product,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                product.imagePath,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 70,
                    height: 70,
                    color: Colors.deepOrange.shade100,
                    child: const Icon(Icons.fastfood, color: Colors.deepOrange),
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
                    product.nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.deskripsi,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer, size: 14, color: Colors.grey),
                          const SizedBox(width: 4),
                          Text(
                            product.waktu,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: product.stok > 0
                            ? () => widget.onAddToCart(product)
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          product.stok > 0 ? 'Beli' : 'Habis',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}