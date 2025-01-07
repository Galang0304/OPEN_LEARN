import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> gameList = [
    {
      'judul': 'Tebak Kata',
      'deskripsi': 'Permainan menebak kata untuk meningkatkan kosakata',
      'icon': Icons.quiz,
      'color': Colors.purple[700]!,
      'level': 'Mudah',
      'kategori': 'Bahasa',
    },
    {
      'judul': 'Hitung Cepat',
      'deskripsi': 'Latihan berhitung dengan cara yang menyenangkan',
      'icon': Icons.calculate,
      'color': Colors.blue[700]!,
      'level': 'Sedang',
      'kategori': 'Matematika',
    },
    {
      'judul': 'Puzzle Suara',
      'deskripsi': 'Mencocokkan suara dengan objek yang tepat',
      'icon': Icons.music_note,
      'color': Colors.orange[700]!,
      'level': 'Mudah',
      'kategori': 'Audio',
    },
    {
      'judul': 'Kuis Pengetahuan',
      'deskripsi': 'Uji pengetahuan umum dengan pertanyaan menarik',
      'icon': Icons.psychology,
      'color': Colors.green[700]!,
      'level': 'Sedang',
      'kategori': 'Pengetahuan',
    },
    {
      'judul': 'Cerita Interaktif',
      'deskripsi': 'Petualangan cerita dengan pilihan yang menentukan akhir cerita',
      'icon': Icons.auto_stories,
      'color': Colors.red[700]!,
      'level': 'Mudah',
      'kategori': 'Cerita',
    },
    {
      'judul': 'Memory Game',
      'deskripsi': 'Latih ingatan dengan mencocokkan kartu yang sama',
      'icon': Icons.memory,
      'color': Colors.teal[700]!,
      'level': 'Sedang',
      'kategori': 'Memori',
    },
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak(
      "Halaman Game. Pilih permainan yang ingin dimainkan. "
      "Ketuk dua kali untuk memulai permainan. "
      "Tekan lama untuk mendengar deskripsi."
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

  void _showGameDetail(BuildContext context, Map<String, dynamic> game) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: game['color'],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  game['icon'],
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    game['judul'],
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
              game['deskripsi'],
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _buildInfoChip(Icons.speed, 'Level: ${game['level']}'),
                const SizedBox(width: 8),
                _buildInfoChip(Icons.category, 'Kategori: ${game['kategori']}'),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _speak("Memulai permainan ${game['judul']}");
                  // TODO: Implementasi game
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: game['color'],
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Mulai Bermain',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ).then((_) => _speak(game['judul']));
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Game',
          style: TextStyle(
            fontSize: 24,
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
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.95,
          ),
          itemCount: gameList.length,
          itemBuilder: (context, index) {
            final game = gameList[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: InkWell(
                onTap: () => _showGameDetail(context, game),
                onLongPress: () => _speak("${game['judul']}: ${game['deskripsi']}"),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        game['color'].withOpacity(0.8),
                        game['color'],
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        game['icon'],
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        game['judul'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        game['deskripsi'],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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