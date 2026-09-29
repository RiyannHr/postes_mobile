import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

// Widget MaterialApp: Wrapper utama aplikasi
class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MainPage(),
    );
  }
}

// Widget Stateful untuk mengatur Navigasi BottomNavigationBar
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const SambalHomePage(),
    const CartPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
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

// Halaman 1: Beranda Katalog Sambal
class SambalHomePage extends StatelessWidget {
  const SambalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              _buildSambalItem(
                context,
                'Sambal Terasi',
                'Pedas manis khas Jawa dengan aroma terasi bakar.',
                '15 Mins',
                'assets/sambal.terasi.jpeg',
              ),
              const SizedBox(height: 12),
              _buildSambalItem(
                context,
                'Sambal Matah',
                'Sambal iris mentah khas Bali yang segar dan harum.',
                '10 Mins',
                'assets/sambalmentah.webp',
              ),
              const SizedBox(height: 12),
              _buildSambalItem(
                context,
                'Sambal Hijau',
                'Sambal khas Minang dari cabai hijau segar.',
                '20 Mins',
                'assets/sambalhijau.jpg',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSambalItem(
    BuildContext context,
    String nama,
    String deskripsi,
    String waktu,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailSambalPage(
              nama: nama,
              deskripsi: deskripsi,
              imagePath: imagePath,
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
                imagePath,
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
                    nama,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    deskripsi,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.timer, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
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
      ),
    );
  }
}

// Halaman 2: Keranjang Belanja Sambal Kemasan
class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
          SingleChildScrollView(
            padding: const EdgeInsets.only(
                bottom: 100, left: 16, right: 16, top: 16),
            child: Column(
              children: const [
                CartItemTile(
                  nama: "Sambal Terasi",
                  harga: "Rp 35.000",
                  imagePath: "assets/sambal.terasi.jpeg",
                ),
                CartItemTile(
                  nama: "Sambal Mentah",
                  harga: "Rp 40.000",
                  imagePath: "assets/sambalmentah.webp",
                ),
                CartItemTile(
                  nama: "Sambal Hijau",
                  harga: "Rp 30.000",
                  imagePath: "assets/sambalhijau.jpg",
                ),
              ],
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
                    children: const [
                      Text("Total Harga",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(
                        "Rp 105.000",
                        style: TextStyle(
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
                    onPressed: () {},
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

// Widget Item Produk di Keranjang
class CartItemTile extends StatelessWidget {
  final String nama;
  final String harga;
  final String imagePath;

  const CartItemTile({
    super.key,
    required this.nama,
    required this.harga,
    required this.imagePath,
  });

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
              imagePath,
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
                  nama,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  harga,
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
              controller: TextEditingController(text: "1"),
            ),
          ),
        ],
      ),
    );
  }
}

// Halaman 3: Profil Pengguna
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Profil Pengguna"),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Foto Profil menggunakan CircleAvatar
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Riyan Hidayat", // <-- Diubah menjadi Riyan Hidayat
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "riyanhidayat@email.com",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            
            // Kartu Informasi Akun & Menu Pengaturan
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.deepOrange),
                    title: Text("Alamat Pengiriman"),
                    subtitle: Text("Jl. Mawar No. 12, Samarinda"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.history, color: Colors.deepOrange),
                    title: Text("Riwayat Pesanan"),
                    subtitle: Text("Lihat status pembelian sambal"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.deepOrange),
                    title: Text("Pengaturan Akun"),
                    subtitle: Text("Ubah kata sandi dan preferensi"),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Tombol Keluar
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                minimumSize: const Size(double.infinity, 45),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              icon: const Icon(Icons.logout),
              label: const Text("Keluar Aplikasi"),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Detail Sambal
class DetailSambalPage extends StatelessWidget {
  final String nama;
  final String deskripsi;
  final String imagePath;

  const DetailSambalPage({
    super.key,
    required this.nama,
    required this.deskripsi,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nama),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                imagePath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.deepOrange.shade100,
                    child: const Icon(Icons.restaurant_menu,
                        size: 60, color: Colors.deepOrange),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              nama,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              deskripsi,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 45),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Kembali ke Katalog"),
            ),
          ],
        ),
      ),
    );
  }
}