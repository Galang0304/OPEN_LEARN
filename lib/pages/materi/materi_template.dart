import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../data/materi_data.dart';

class MateriPage extends StatefulWidget {
  final String title;
  final List<String> materiTitles;
  final Color themeColor;
  final IconData Function(String) getIcon;

  const MateriPage({
    super.key,
    required this.title,
    required this.materiTitles,
    required this.themeColor,
    required this.getIcon,
  });

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _speak('Halaman ${widget.title}. Sentuh kartu untuk memilih materi. Tekan lama untuk mendengar penjelasan.');
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

  void _showMateriDetail(BuildContext context, String title) {
    final materiData = MateriData.getMateriData(title);
    if (materiData != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailMateriPage(
            title: title,
            materiData: materiData,
            themeColor: widget.themeColor,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.themeColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: widget.materiTitles.length,
          itemBuilder: (context, index) {
            final title = widget.materiTitles[index];
            final materiData = MateriData.getMateriData(title);
            if (materiData == null) return const SizedBox.shrink();

            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  _speak(title + '. ' + materiData['deskripsi']);
                  _showMateriDetail(context, title);
                },
                onLongPress: () {
                  _speak(title + '. ' + materiData['deskripsi']);
                },
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: widget.themeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Icon(
                          widget.getIcon(title),
                          size: 32,
                          color: widget.themeColor,
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              materiData['deskripsi'],
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

class DetailMateriPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic> materiData;
  final Color themeColor;

  const DetailMateriPage({
    super.key,
    required this.title,
    required this.materiData,
    required this.themeColor,
  });

  @override
  State<DetailMateriPage> createState() => _DetailMateriPageState();
}

class _DetailMateriPageState extends State<DetailMateriPage> {
  final FlutterTts flutterTts = FlutterTts();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _speak('Halaman ${widget.title}. ${widget.materiData['deskripsi']}');
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
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              widget.themeColor.withOpacity(0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.materiData['deskripsi'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: [
                  _buildMateriSection('Sub Materi', widget.materiData['subMateri']),
                  _buildMateriSection('Contoh Soal', widget.materiData['contohSoal'], answers: widget.materiData['kunciJawaban']),
                  _buildMateriSection('Latihan', widget.materiData['latihan']),
                ],
              ),
            ),
            BottomNavigationBar(
              currentIndex: _currentIndex,
              selectedItemColor: widget.themeColor,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book),
                  label: 'Materi',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.quiz),
                  label: 'Contoh',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_note),
                  label: 'Latihan',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMateriSection(String title, List<dynamic> items, {List<dynamic>? answers}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () {
                      String textToSpeak = items[index];
                      if (answers != null && index < answers.length) {
                        textToSpeak += '. Jawaban: ${answers[index]}';
                      }
                      _speak(textToSpeak);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            items[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (answers != null && index < answers.length) ...[
                            const SizedBox(height: 8.0),
                            Text(
                              'Jawaban: ${answers[index]}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
} 