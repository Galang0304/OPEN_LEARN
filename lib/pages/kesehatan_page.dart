import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class KesehatanPage extends StatefulWidget {
  const KesehatanPage({super.key});

  @override
  State<KesehatanPage> createState() => _KesehatanPageState();
}

class _KesehatanPageState extends State<KesehatanPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiKesehatan = [
    {
      'judul': 'Mencuci Tangan',
      'isi': 'Cuci tangan dengan sabun dan air mengalir selama 20 detik untuk membunuh kuman.',
      'icon': Icons.clean_hands,
      'color': Colors.blue[400]!
    },
    {
      'judul': 'Makan Sehat',
      'isi': 'Makan makanan bergizi seperti sayur, buah, dan protein untuk menjaga kesehatan tubuh.',
      'icon': Icons.restaurant,
      'color': Colors.green[400]!
    },
    {
      'judul': 'Olahraga',
      'isi': 'Lakukan olahraga minimal 30 menit setiap hari untuk menjaga kebugaran.',
      'icon': Icons.directions_run,
      'color': Colors.orange[400]!
    },
    {
      'judul': 'Istirahat Cukup',
      'isi': 'Tidur 7-8 jam sehari untuk memulihkan energi dan menjaga kesehatan.',
      'icon': Icons.bedtime,
      'color': Colors.indigo[400]!
    },
    {
      'judul': 'Kebersihan Gigi',
      'isi': 'Sikat gigi minimal dua kali sehari untuk mencegah gigi berlubang.',
      'icon': Icons.cleaning_services,
      'color': Colors.purple[400]!
    }
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Halaman materi kesehatan. Sentuh materi untuk mendengarkan.");
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
          'Materi Kesehatan',
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
          itemCount: materiKesehatan.length,
          itemBuilder: (context, index) {
            final materi = materiKesehatan[index];
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