import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class KeterampilanPage extends StatefulWidget {
  const KeterampilanPage({super.key});

  @override
  State<KeterampilanPage> createState() => _KeterampilanPageState();
}

class _KeterampilanPageState extends State<KeterampilanPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiKeterampilan = [
    {
      'judul': 'Keterampilan Komunikasi',
      'isi': 'Belajar berkomunikasi dengan baik dan efektif dalam kehidupan sehari-hari.',
      'icon': Icons.chat,
      'color': Colors.orange[400]!
    },
    {
      'judul': 'Keterampilan Sosial',
      'isi': 'Mengembangkan kemampuan berinteraksi dan bekerja sama dengan orang lain.',
      'icon': Icons.people_alt,
      'color': Colors.purple[400]!
    },
    {
      'judul': 'Keterampilan Hidup',
      'isi': 'Belajar kemandirian dan mengurus diri sendiri dalam aktivitas sehari-hari.',
      'icon': Icons.home,
      'color': Colors.blue[400]!
    },
    {
      'judul': 'Keterampilan Belajar',
      'isi': 'Mengembangkan cara belajar yang efektif dan strategi memahami materi.',
      'icon': Icons.school,
      'color': Colors.green[400]!
    },
    {
      'judul': 'Keterampilan Teknologi',
      'isi': 'Belajar menggunakan teknologi dan alat bantu untuk mendukung kemandirian.',
      'icon': Icons.computer,
      'color': Colors.indigo[400]!
    }
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Halaman materi keterampilan. Sentuh materi untuk mendengarkan.");
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
          'Materi Keterampilan',
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
          itemCount: materiKeterampilan.length,
          itemBuilder: (context, index) {
            final materi = materiKeterampilan[index];
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