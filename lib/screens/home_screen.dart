import 'package:flutter/material.dart';
import '/screens/notification_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(width: 10.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Grace Moretz',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'Selamat datang kembali!',
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
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
                    // aksi ketika ditekan
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
            // Teks di tengah
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.black, // warna default untuk teks lainnya
                  ),
                  children: [
                    const TextSpan(text: 'Komplek Selamat Riyadi '),
                    TextSpan(
                      text: 'KM 2',
                      style: const TextStyle(
                        color: Colors.blue, // warna khusus KM 2
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20.0),

            // Container berisi text dan tombol
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 228, 220, 238),
                    Color.fromARGB(255, 202, 190, 230),
                    Color.fromARGB(255, 205, 192, 235),
                  ],
                  stops: [0.0, 0.5, 0.9],
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 6.0,
                    offset: const Offset(0, 3.0),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Kolom teks dan tombol
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Halo, jangan lupa ya pembayaran rutin aplikasi RT-nya 😉.',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        ElevatedButton(
                          onPressed: () {
                            // aksi tombol
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
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  // Gambar di kanan
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/people1.png',
                      width: 80.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80.0,
                          height: 100.0,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, color: Colors.grey),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),

            // Judul My Service
            Text(
              'Layanan',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 8.0),

            // Grid Menu
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 1.2,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(Icons.report, 'Lapor', Colors.redAccent),
                  _buildMenuItem(
                    Icons.info,
                    'Informasi',
                    Colors.lightBlueAccent,
                  ),
                  _buildMenuItem(
                    Icons.history_rounded,
                    'Riwayat Iuran',
                    Colors.greenAccent,
                  ),
                  _buildMenuItem(Icons.help, 'Bantuan', Colors.pinkAccent),
                  _buildMenuItem(Icons.chat, 'Pesan', Colors.orangeAccent),
                  _buildMenuItem(
                    Icons.more_horiz,
                    'Lainnya',
                    Colors.indigoAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Berita Terbaru',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            const SizedBox(height: 12.0),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://picsum.photos/400/200',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 150,
                          width: double.infinity,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(
                              Icons.image,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    'Kerja Bakti Bersama!',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'Kegiatan kerja bakti dengan partisipasi RT 51',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey),
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

Widget _buildMenuItem(IconData icon, String title, Color color) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: color, size: 28)),
      ),
      const SizedBox(height: 8.0),
      Text(
        title,
        style: const TextStyle(
          fontSize: 13.0,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    ],
  );
}
