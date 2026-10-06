import 'package:flutter/material.dart';

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
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.deepOrange,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Riyan Hidayat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              "riyanhidayat@email.com",
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
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