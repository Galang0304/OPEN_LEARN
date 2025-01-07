import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HurufPage extends StatefulWidget {
  const HurufPage({super.key});

  @override
  State<HurufPage> createState() => _HurufPageState();
}

class _HurufPageState extends State<HurufPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<String> huruf = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
    'U', 'V', 'W', 'X', 'Y', 'Z'
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak("Halaman belajar huruf. Sentuh huruf untuk mendengarkan.");
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
        title: const Text('Belajar Huruf'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: huruf.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () => _speak("Huruf ${huruf[index]}"),
              child: Center(
                child: Text(
                  huruf[index],
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
} 