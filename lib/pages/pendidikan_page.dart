import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PendidikanPage extends StatefulWidget {
  const PendidikanPage({super.key});

  @override
  State<PendidikanPage> createState() => _PendidikanPageState();
}

class _PendidikanPageState extends State<PendidikanPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiPendidikan = [
    {
      'judul': 'Matematika Dasar',
      'isi': 'Pelajari konsep dasar matematika seperti penjumlahan, pengurangan, perkalian, dan pembagian.',
      'icon': Icons.calculate,
      'color': Colors.blue[400]!
    },
    {
      'judul': 'Bahasa Indonesia',
      'isi': 'Belajar membaca, menulis, dan memahami teks dalam Bahasa Indonesia.',
      'icon': Icons.book,
      'color': Colors.red[400]!
    },
    {
      'judul': 'Ilmu Pengetahuan Alam',
      'isi': 'Mengenal alam sekitar, makhluk hidup, dan fenomena alam.',
      'icon': Icons.science,
      'color': Colors.green[400]!
    },
    {
      'judul': 'Ilmu Pengetahuan Sosial',
      'isi': 'Belajar tentang masyarakat, sejarah, dan budaya Indonesia.',
      'icon': Icons.people,
      'color': Colors.orange[400]!
    },
    {
      'judul': 'Pendidikan Agama',
      'isi': 'Mempelajari nilai-nilai moral dan keagamaan dalam kehidupan.',
      'icon': Icons.mosque,
      'color': Colors.purple[400]!
    }
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak(
      "Halaman materi pendidikan. "
      "Geser ke atas atau bawah untuk menjelajahi materi. "
      "Ketuk dua kali untuk mendengarkan materi lengkap. "
      "Geser ke kiri untuk kembali ke menu utama."
    );
  }

  Future<void> _configureTts() async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Materi Pendidikan',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.indigo[100]!,
              Colors.grey[100]!,
            ],
          ),
        ),
        child: GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.pop(context);
              _speak("Kembali ke menu utama");
            }
          },
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: materiPendidikan.length,
            itemBuilder: (context, index) {
              final materi = materiPendidikan[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Card(
                  elevation: 8,
                  color: materi['color'],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () => _speak(materi['judul']),
                    onDoubleTap: () => _speak("${materi['judul']}: ${materi['isi']}"),
                    onLongPress: () => _showDetailMateri(context, materi),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                materi['icon'],
                                size: 32,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  materi['judul'],
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            materi['isi'],
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _showDetailMateri(BuildContext context, Map<String, dynamic> materi) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: materi['color'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  materi['icon'],
                  size: 40,
                  color: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    materi['judul'],
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              materi['isi'],
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Panduan: Ketuk dua kali untuk mendengarkan materi lengkap. '
              'Geser ke bawah untuk menutup detail.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    ).then((_) => _speak(materi['judul']));
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
} 