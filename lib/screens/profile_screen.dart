import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Foto Profil
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'), 
              // ganti dengan path gambar kamu
            ),
            const SizedBox(height: 16),

            // Nama & Email
            const Text(
              "Nama Pengguna",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "email@example.com",
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Tombol Edit Profil
            ElevatedButton.icon(
              onPressed: () {
                // Arahkan ke halaman edit profil
              },
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile"),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
            const SizedBox(height: 20),

            // Menu Lain
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Pengaturan"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.lock),
                    title: const Text("Privasi & Keamanan"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text("Keluar", style: TextStyle(color: Colors.red)),
                    onTap: () {
                      // Tambahkan logika logout
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:    (context) => const ProfileScreen()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
