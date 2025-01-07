import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class KeselamatanPage extends StatefulWidget {
  const KeselamatanPage({super.key});

  @override
  State<KeselamatanPage> createState() => _KeselamatanPageState();
}

class _KeselamatanPageState extends State<KeselamatanPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiKeselamatan = [
    {
      'judul': 'Keselamatan di Rumah',
      'isi': 'Mengenal potensi bahaya di rumah dan cara menghindarinya, seperti listrik, api, dan benda tajam.',
      'icon': Icons.home,
      'color': Colors.red[400]!
    },
    {
      'judul': 'Keselamatan di Jalan',
      'isi': 'Belajar aturan lalu lintas dan cara menyeberang jalan dengan aman.',
      'icon': Icons.directions_walk,
      'color': Colors.amber[700]!
    },
    {
      'judul': 'Keselamatan dari Orang Asing',
      'isi': 'Mengenali situasi berbahaya dan cara melindungi diri dari orang yang tidak dikenal.',
      'icon': Icons.security,
      'color': Colors.purple[400]!
    },
    {
      'judul': 'Pertolongan Pertama',
      'isi': 'Mengetahui tindakan dasar saat terjadi kecelakaan atau kondisi darurat.',
      'icon': Icons.medical_services,
      'color': Colors.green[400]!
    },
    {
      'judul': 'Nomor Darurat',
      'isi': 'Menghafal nomor telepon penting seperti polisi, ambulans, dan pemadam kebakaran.',
      'icon': Icons.phone,
      'color': Colors.blue[400]!
    }
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Halaman materi keselamatan. Sentuh materi untuk mendengarkan.");
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
          'Materi Keselamatan',
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
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: materiKeselamatan.length,
          itemBuilder: (context, index) {
            final materi = materiKeselamatan[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Card(
                elevation: 8,
                color: materi['color'],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () => _speak("${materi['judul']}: ${materi['isi']}"),
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
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
} 