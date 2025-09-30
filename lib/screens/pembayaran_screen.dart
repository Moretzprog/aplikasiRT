import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String? metodePembayaran;
  final user = FirebaseAuth.instance.currentUser; // Ganti dengan objek user yang sesuai

  final List<Map<String, dynamic>> metodeList = [
    {
      "nama": "Credit Card",
      "logo":
          "assets/images/creditcard.png", // Ganti dengan path logo yang sesuai
    },
    {
      "nama": "PayPal",
      "logo": "assets/images/paypal.png",
    },
    {
      "nama": "Bank Transfer",
      "logo": "assets/images/banktransfer.png",
    },
    {
      "nama": "Gopay",
      "logo": "assets/images/gopay.png",
    },
    {
      "nama": "OVO",
      "logo": "assets/images/ovo.png",
    },
    {
      "nama": "DANA",
      "logo": "assets/images/dana.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembayaran Iuran"),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F3F3),
      ),
      backgroundColor: const Color(0xFFF5F3F3),
      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget Profile Pengguna
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'images/profile/avatar1.jpg', // Ganti dengan path gambar profil yang sesuai
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(
                        user?.displayName ?? "Nama Pengguna",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "ID Pengguna: 123456",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16.0),
            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),

            /// List metode pembayaran
            Expanded(
              child: ListView.separated(
                itemCount: metodeList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final metode = metodeList[index];
                  final isSelected = metodePembayaran == metode["nama"];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        metodePembayaran = metode["nama"];
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? Colors.blue
                              : Colors.grey.shade300,
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Logo metode
                          Image.network(
                            metode["logo"],
                            width: 32,
                            height: 32,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.payment, size: 32),
                          ),
                          const SizedBox(width: 16),
                          // Nama metode
                          Expanded(
                            child: Text(
                              metode["nama"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          // Radio button
                          Radio<String>(
                            value: metode["nama"],
                            groupValue: metodePembayaran,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                metodePembayaran = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20.0),

            /// Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  backgroundColor: metodePembayaran == null
                      ? Colors.grey
                      : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: metodePembayaran == null
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pembayaran dengan $metodePembayaran diproses...",
                            ),
                          ),
                        );
                      },
                child: const Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
