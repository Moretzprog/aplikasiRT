import 'package:flutter/material.dart';

class PembayaranScreen extends StatefulWidget {
  const PembayaranScreen({super.key});

  @override
  State<PembayaranScreen> createState() => _PembayaranScreenState();
}

class _PembayaranScreenState extends State<PembayaranScreen> {
  String? metodePembayaran;

  // Data user (bisa diganti dari backend nanti)
  final String imageUrl = "https://picsum.photos/200";
  final String namaUser = "Budi Santoso";
  final String alamatUser = "Jl. Merpati No. 12, Jakarta";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran Iuran'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile User
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      imageUrl,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          namaUser,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          alamatUser,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // tagihan iuran
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Tagihan Iuran Bulan Ini",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rp 150.000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            /// Pilih Metode Pembayaran
            const Text(
              "Pilih Metode Pembayaran",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text("Transfer Bank"),
              value: "bank",
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("E-Wallet (OVO, Gopay, Dana)"),
              value: "ewallet",
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value;
                });
              },
            ),
            RadioListTile<String>(
              title: const Text("Kartu Kredit/Debit"),
              value: "card",
              groupValue: metodePembayaran,
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value;
                });
              },
            ),

            const Spacer(),

            /// Tombol Konfirmasi
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  textStyle: const TextStyle(fontSize: 16),
                  backgroundColor: metodePembayaran == null
                      ? Colors.grey
                      : Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: metodePembayaran == null
                    ? null
                    : () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Pembayaran dengan metode ${metodePembayaran!} diproses...",
                            ),
                          ),
                        );
                      },
                child: const Text(
                  "Konfirmasi Pembayaran",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
