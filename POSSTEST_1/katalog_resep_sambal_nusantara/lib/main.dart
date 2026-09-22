import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// MaterialApp: Wrapper utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Katalog Resep Sambal Nusantara',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const SambalHomePage(),
    );
  }
}

class SambalHomePage extends StatelessWidget {
  const SambalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Kerangka dasar halaman aplikasi
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        // Text: Menampilkan judul pada AppBar
        title: const Text('Katalog Sambal Nusantara'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      // SafeArea: Memastikan konten tidak tertutup notch/status bar
      body: SafeArea(
        // SingleChildScrollView: Memberikan fitur scroll
        child: SingleChildScrollView(
          // Padding: Memberi jarak di sekeliling area dalam
          padding: const EdgeInsets.all(16.0),
          // Column: Menyusun tata letak secara vertikal
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField: Form pencarian resep
              TextField(
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
                    // Icon: Menampilkan ikon pencarian
                    child: Icon(
                      Icons.search,
                      size: 24,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),

              // SizedBox: Memberi jarak vertikal
              const SizedBox(height: 20),

              // Text: Judul seksi daftar sambal
              const Text(
                'Daftar Sambal Populer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              // SizedBox: Jarak antar teks dan kartu
              const SizedBox(height: 12),

              // Kartu Item Katalog 1
              _buildSambalItem(
                'Sambal Terasi',
                'Pedas manis khas Jawa dengan aroma terasi bakar.',
                '15 Mins',
                Colors.redAccent,
              ),

              // SizedBox: Jarak antar kartu
              const SizedBox(height: 12),

              // Kartu Item Katalog 2
              _buildSambalItem(
                'Sambal Matah',
                'Sambal iris mentah khas Bali yang segar dan harum.',
                '10 Mins',
                Colors.orangeAccent,
              ),

              // SizedBox: Jarak antar kartu
              const SizedBox(height: 12),

              // Kartu Item Katalog 3
              _buildSambalItem(
                'Sambal Hijau',
                'Sambal khas Minang dari cabai hijau segar.',
                '20 Mins',
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi pembantu membuat item katalog resep
  Widget _buildSambalItem(
    String nama,
    String deskripsi,
    String waktu,
    Color warna,
  ) {
    // Container: Wadah untuk membentuk kartu resep
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      // Row: Menyusun elemen gambar dan informasi secara horizontal
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container: Digunakan sebagai gambar/ikon wadah
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: warna.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            // Icon: Ikon visual makanan
            child: Icon(Icons.restaurant, color: warna, size: 36),
          ),

          // SizedBox: Jarak horizontal antar gambar dan teks
          const SizedBox(width: 12),

          // Expanded: Mengisi sisa ruang kosong agar teks tidak overflow
          Expanded(
            // Column: Menyusun teks nama, deskripsi, dan waktu secara vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text: Nama Sambal
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // SizedBox: Jarak kecil antar teks
                const SizedBox(height: 4),

                // Text: Deskripsi Sambal
                Text(
                  deskripsi,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),

                // SizedBox: Jarak kecil ke info waktu
                const SizedBox(height: 8),

                // Row: Menyusun ikon timer dan teks durasi secara horizontal
                Row(
                  children: [
                    // Icon: Ikon durasi
                    const Icon(Icons.timer, size: 14, color: Colors.grey),

                    // SizedBox: Jarak antara ikon dan teks durasi
                    const SizedBox(width: 4),

                    // Text: Durasi memasak
                    Text(
                      waktu,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
