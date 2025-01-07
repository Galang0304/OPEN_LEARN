import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LingkunganPage extends StatefulWidget {
  const LingkunganPage({super.key});

  @override
  State<LingkunganPage> createState() => _LingkunganPageState();
}

class _LingkunganPageState extends State<LingkunganPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiLingkungan = [
    {
      'judul': 'Kebersihan Lingkungan',
      'isi': 'Menjaga kebersihan lingkungan dengan membuang sampah pada tempatnya dan melakukan daur ulang.',
      'icon': Icons.cleaning_services,
      'color': Colors.green[400]!
    },
    {
      'judul': 'Pelestarian Alam',
      'isi': 'Menjaga kelestarian alam dengan menanam pohon dan melindungi hewan.',
      'icon': Icons.park,
      'color': Colors.teal[400]!
    },
    {
      'judul': 'Hemat Energi',
      'isi': 'Menghemat penggunaan listrik dan air untuk menjaga sumber daya alam.',
      'icon': Icons.eco,
      'color': Colors.lightGreen[400]!
    },
    {
      'judul': 'Pencegahan Polusi',
      'isi': 'Mengurangi polusi udara dan air dengan menggunakan transportasi ramah lingkungan.',
      'icon': Icons.air,
      'color': Colors.cyan[400]!
    },
    {
      'judul': 'Penghijauan',
      'isi': 'Membuat lingkungan lebih hijau dengan menanam tanaman di sekitar rumah.',
      'icon': Icons.forest,
      'color': Colors.green[600]!
    }
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Halaman materi lingkungan. Sentuh materi untuk mendengarkan.");
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
          'Materi Lingkungan',
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
          itemCount: materiLingkungan.length,
          itemBuilder: (context, index) {
            final materi = materiLingkungan[index];
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