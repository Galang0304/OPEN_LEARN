import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TentangPage extends StatefulWidget {
  const TentangPage({super.key});

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Tentang Open Learn. Aplikasi pembelajaran untuk tunanetra.");
  }

  Future<void> _configureTts() async {
    await flutterTts.setLanguage("id-ID");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  Widget _buildInfoCard(String title, String content, Color color, IconData icon) {
    return Card(
      elevation: 8,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => _speak("$title. $content"),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    size: 32,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
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
                content,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tentang Open Learn',
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
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildInfoCard(
              'Apa itu Open Learn?',
              'Open Learn adalah aplikasi pembelajaran yang dirancang khusus untuk membantu tunanetra dalam mengakses materi pendidikan dengan mudah dan menyenangkan.',
              Colors.indigo[400]!,
              Icons.school,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Fitur Utama',
              '• Text to Speech dalam Bahasa Indonesia\n'
              '• Navigasi mudah dengan gesture\n'
              '• Materi pembelajaran yang beragam\n'
              '• Antarmuka yang ramah tunanetra\n'
              '• Konten edukatif berkualitas',
              Colors.teal[400]!,
              Icons.stars,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Cara Menggunakan',
              '• Sentuh layar untuk mendengarkan\n'
              '• Ketuk dua kali untuk membuka menu\n'
              '• Tekan lama untuk informasi tambahan\n'
              '• Geser ke kiri/kanan untuk navigasi\n'
              '• Geser ke atas/bawah untuk scroll',
              Colors.orange[400]!,
              Icons.touch_app,
            ),
            const SizedBox(height: 16),
            _buildInfoCard(
              'Dukungan',
              'Aplikasi ini mendukung pembelajaran inklusif dan dapat digunakan oleh semua kalangan. Kami berkomitmen untuk terus mengembangkan fitur yang membantu proses pembelajaran.',
              Colors.purple[400]!,
              Icons.favorite,
            ),
          ],
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