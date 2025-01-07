import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'materi/bahasa_page.dart';
import 'materi/ipa_page.dart';
import 'materi/ips_page.dart';
import 'materi/kesenian_page.dart';
import 'materi/keterampilan_page.dart';
import 'materi/matematika_page.dart';

class BelajarPage extends StatefulWidget {
  const BelajarPage({super.key});

  @override
  State<BelajarPage> createState() => _BelajarPageState();
}

class _BelajarPageState extends State<BelajarPage> {
  final FlutterTts flutterTts = FlutterTts();
  final List<Map<String, dynamic>> materiList = [
    {
      'title': 'Matematika',
      'description': 'Belajar berhitung dan memahami angka',
      'icon': Icons.calculate,
      'color': Colors.blue,
      'page': const MatematikPage(),
    },
    {
      'title': 'Bahasa',
      'description': 'Belajar membaca, menulis, dan berkomunikasi',
      'icon': Icons.book,
      'color': Colors.green,
      'page': const BahasaPage(),
    },
    {
      'title': 'IPA',
      'description': 'Belajar tentang alam dan lingkungan sekitar',
      'icon': Icons.science,
      'color': Colors.orange,
      'page': const IpaPage(),
    },
    {
      'title': 'IPS',
      'description': 'Belajar tentang kehidupan sosial dan masyarakat',
      'icon': Icons.people,
      'color': Colors.purple,
      'page': const IpsPage(),
    },
    {
      'title': 'Kesenian',
      'description': 'Belajar menggambar, bernyanyi, dan berkreasi',
      'icon': Icons.palette,
      'color': Colors.pink,
      'page': const KesenianPage(),
    },
    {
      'title': 'Keterampilan',
      'description': 'Belajar keterampilan hidup sehari-hari',
      'icon': Icons.build,
      'color': Colors.teal,
      'page': const KeterampilanPage(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _speak('Halaman Belajar. Sentuh kartu untuk memilih mata pelajaran. Tekan lama untuk mendengar penjelasan.');
  }

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('id-ID');
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: materiList.length,
          itemBuilder: (context, index) {
            final materi = materiList[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  _speak(materi['title'] + '. ' + materi['description']);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => materi['page'],
                    ),
                  );
                },
                onLongPress: () {
                  _speak(materi['title'] + '. ' + materi['description']);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: materi['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(
                          materi['icon'],
                          size: 32,
                          color: materi['color'],
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              materi['title'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              materi['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: Colors.grey[400],
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
} 