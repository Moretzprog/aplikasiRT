import 'package:app_security/screens/berita_screen.dart';
import 'package:flutter/material.dart';
import 'package:app_security/screens/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_security/screens/panic_screen.dart';
import 'package:app_security/screens/aboutkomplek_screen.dart';
import 'package:app_security/screens/pembayaran_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100.0,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Avatar + Nickname
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg'
                      '?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        user?.displayName ?? 'Nama Pengguna',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        user?.email ?? 'email@example.com',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Icon Notifikasi dengan border
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(50.0),
                ),
                child: IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) => const NotificationScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul komplek
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black,
                  ),
                  children: const [
                    TextSpan(text: 'Komplek Selamat Riyadi '),
                    TextSpan(
                      text: 'KM 2',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Card iuran
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 110, 194, 240),
                    Color.fromARGB(255, 123, 196, 241),
                    Color.fromARGB(255, 160, 216, 246),
                  ],
                  stops: [0.0, 0.3, 0.7],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                children: [
                  // Kolom teks dan tombol
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mulai sekarang dengan membayar iuran RT-nya 😉.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            // aksi ke halaman iuran
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => const PembayaranScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            'Bayar Sekarang',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          
                        ),
                        const SizedBox(height: 8.0),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/people1.png',
                      width: 80.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Layanan
            Text(
              'Layanan',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 0.5),
            ),
            const SizedBox(height: 8.0),

            SizedBox(
              height: 115.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  _buildMenuItem(
                    Icons.warning,
                    'Panic Button',
                    
                    Colors.blue,
                    
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const PanicScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.newspaper,
                    'Berita',
                    Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const NewsScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    Icons.info,
                    'Tentang Komplek',
                    Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) => const AboutScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(Icons.chat, 'Chat', Colors.purple),
                  _buildMenuItem(Icons.settings, 'Pengaturan', Colors.orange),
                ],
              ),
            ),

            const SizedBox(height: 20.0),

            // Berita terbaru
            Text(
              'Berita Terbaru',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12.0),

            // List berita
            Column(
              children: [
                _buildNewsItem(
                  imageUrl: 'https://picsum.photos/400/200?1',
                  title: 'Kerja Bakti Bersama!',
                  description: 'Kegiatan kerja bakti dengan partisipasi RT 51',
                  date: '12 Okt 2025',
                  views: 120,
                ),
                _buildNewsItem(
                  imageUrl: 'https://picsum.photos/400/200?2',
                  title: 'Rapat Warga Mingguan',
                  description:
                      'Rapat warga di balai RT membahas keamanan komplek',
                  date: '10 Okt 2025',
                  views: 85,
                ),
                _buildNewsItem(
                  imageUrl: 'https://picsum.photos/400/200?3',
                  title: 'Senam Pagi',
                  description:
                      'Senam sehat bersama ibu-ibu komplek tiap Minggu pagi',
                  date: '08 Okt 2025',
                  views: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Menu Item
Widget _buildMenuItem(
  IconData icon,
  String title,
  Color color, {
  VoidCallback? onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(16),
    child: Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(color: color, width: 1.0),
            ),
            child: Icon(icon, color: color, size: 30.0),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, letterSpacing: 0.5),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildNewsItem({
  required String imageUrl,
  required String title,
  required String description,
  int views = 0,
  String date = '',
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 100,
                width: 100,
                color: Colors.grey[300],
                child: const Center(
                  child: Icon(Icons.image, color: Colors.grey, size: 40),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min, // 🔑 cegah error flex
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (description.isNotEmpty) ...[
                const SizedBox(height: 6.0),
                Text(
                  description,
                  style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                ),
              ],
              const SizedBox(height: 10.0),
              Text(
                date,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        if (views > 0) ...[
          // Menambahkan views di pojok kanan bawah
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.remove_red_eye,
                  size: 14.0,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '$views',
                  style: const TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}
