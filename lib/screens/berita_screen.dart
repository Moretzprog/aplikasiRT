import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

/// Halaman Utama News
class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool isGridView = false; // default List View

  final List<Map<String, String>> newsData = [
    {
      "title": "Inovasi Teknologi di Indonesia",
      "desc":
          "Startup lokal berhasil mengembangkan aplikasi ramah lingkungan yang mendapat dukungan internasional.",
      "content":
          "Startup lokal berhasil mengembangkan aplikasi ramah lingkungan. Aplikasi ini diharapkan dapat membantu mengurangi jejak karbon dan mendorong gaya hidup berkelanjutan di Indonesia. Aplikasi ini juga diharapkan dapat memberikan informasi yang akurat dan terpercaya kepada pengguna.",
      "image": "https://picsum.photos/id/1015/400/200",
    },
    {
      "title": "Pendidikan Era Digital",
      "desc":
          "Sekolah-sekolah mulai memanfaatkan platform digital untuk meningkatkan kualitas pembelajaran.",
      "content":
          "Dengan hadirnya platform digital, guru dan siswa dapat mengakses materi pembelajaran kapan saja dan di mana saja.",
      "image": "https://picsum.photos/id/1005/400/200",
    },
    {
      "title": "Olahraga Nasional",
      "desc":
          "Atlet muda Indonesia kembali menorehkan prestasi di kejuaraan internasional.",
      "content":
          "Atlet muda Indonesia berhasil membawa pulang medali emas dalam ajang kejuaraan internasional.",
      "image": "https://picsum.photos/id/1021/400/200",
    },
    {
      "title": "Ekonomi Kreatif",
      "desc":
          "Industri kreatif terus tumbuh dan berkontribusi besar pada perekonomian Indonesia.",
      "content":
          "Pemerintah mendukung pelaku ekonomi kreatif dengan berbagai program pelatihan dan akses pasar global.",
      "image": "https://picsum.photos/id/1040/400/200",
    },
    {
      "title": "Pengabdian Masyarakat",
      "desc":
          "Organisasi non-profit membantu masyarakat dalam bidang sosial dan lingkungan.",
      "content":
          "Organisasi non-profit membantu masyarakat dalam bidang sosial dan lingkungan.",
      "image": "https://picsum.photos/id/1050/400/200",
    },
    {
      "title": "Kesehatan Lingkungan",
      "desc":
          "Pemerintah mengambil langkah-langkah untuk menjaga kesehatan lingkungan.",
      "content":
          "Pemerintah mengambil langkah-langkah untuk menjaga kesehatan lingkungan.",
      "image": "https://picsum.photos/id/1060/400/200",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3F3),
      appBar: AppBar(
        title: const Text('News'),
        backgroundColor: const Color.fromARGB(255, 236, 237, 237),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isGridView ? Icons.view_list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGridView = !isGridView; // toggle view
              });
            },
            style: IconButton.styleFrom(
              foregroundColor: const Color.fromARGB(221, 25, 137, 181),
            ),
          ),
        ],
      ),
      body: Container(
        color: const Color.fromARGB(255, 236, 237, 237), // sama dengan AppBar
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isGridView ? buildGridView(context) : buildListView(context),
        ),
      ),
    );
  }

  /// List View (Card penuh)
  Widget buildListView(BuildContext context) {
    return ListView.builder(
      itemCount: newsData.length,
      itemBuilder: (context, index) {
        final news = newsData[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          margin: const EdgeInsets.only(bottom: 16),
          color: Colors.white,
          // elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  news["image"]!,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news["title"]!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      news["desc"]!,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailScreen(
                                title: news["title"]!,
                                image: news["image"]!,
                                content: news["content"]!,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Baca Selengkapnya",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      physics: const BouncingScrollPhysics(),
    );
  }

  /// Grid View (2 kolom dengan judul + deskripsi)
  Widget buildGridView(BuildContext context) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: newsData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 kolom
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.90, // agak tinggi biar muat deskripsi
      ),
      itemBuilder: (context, index) {
        final news = newsData[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewsDetailScreen(
                  title: news["title"]!,
                  image: news["image"]!,
                  content: news["content"]!,
                  desc: news["desc"]!,
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            // elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.network(
                    news["image"]!,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news["title"]!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        news["desc"]!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailScreen(
                                  title: news["title"]!,
                                  image: news["image"]!,
                                  content: news["content"]!,
                                  desc: news["desc"]!,
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "Baca Selengkapnya",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Halaman Detail Berita
class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String image;
  final String content;
  final String? desc; // optional, hanya untuk Grid View

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.content,
    this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color.fromARGB(255, 236, 237, 237),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: () {
              Share.share(
                "$title\n\n$content\n\nSumber: App News",
                subject: title,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),

        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                image,
                width: double.infinity,
                height: 280,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 16),
            const Text(
              "Sumber: Majelis Lucu Indonesia",
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
