import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PembelajaranPage extends StatefulWidget {
  final String title;
  final Map<String, dynamic> materi;

  const PembelajaranPage({
    super.key,
    required this.title,
    required this.materi,
  });

  @override
  State<PembelajaranPage> createState() => _PembelajaranPageState();
}

class _PembelajaranPageState extends State<PembelajaranPage> {
  final FlutterTts flutterTts = FlutterTts();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _speak('${widget.title}. ${widget.materi['deskripsi']}');
    _configureTts();
  }

  Future<void> _configureTts() async {
    await flutterTts.setLanguage('id-ID');
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Widget _buildMateriSection() {
    final subMateri = widget.materi['subMateri'] as List;
    return ListView.builder(
      itemCount: subMateri.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(subMateri[index].toString()),
          onTap: () => _speak(subMateri[index].toString()),
          onLongPress: () => _speak(subMateri[index].toString()),
        );
      },
    );
  }

  Widget _buildContohSection() {
    final contohSoal = widget.materi['contohSoal'] as List;
    final kunciJawaban = widget.materi['kunciJawaban'] as List;
    return ListView.builder(
      itemCount: contohSoal.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.all(8.0),
          child: ExpansionTile(
            title: Text(contohSoal[index].toString()),
            onExpansionChanged: (expanded) {
              if (expanded) {
                _speak(contohSoal[index].toString());
              }
            },
            children: [
              ListTile(
                title: Text(
                  'Jawaban: ${kunciJawaban[index]}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
                onTap: () => _speak('Jawaban: ${kunciJawaban[index]}'),
                onLongPress: () => _speak('Jawaban: ${kunciJawaban[index]}'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLatihanSection() {
    final latihan = widget.materi['latihan'] as List;
    return ListView.builder(
      itemCount: latihan.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(latihan[index].toString()),
          onTap: () => _speak(latihan[index].toString()),
          onLongPress: () => _speak(latihan[index].toString()),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.materi['deskripsi'] as String,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavButton(0, 'Materi'),
              _buildNavButton(1, 'Contoh'),
              _buildNavButton(2, 'Latihan'),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                _buildMateriSection(),
                _buildContohSection(),
                _buildLatihanSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton(int index, String label) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedIndex = index;
        });
        _speak(label);
      },
      style: TextButton.styleFrom(
        backgroundColor: _selectedIndex == index ? Colors.blue : null,
        foregroundColor: _selectedIndex == index ? Colors.white : Colors.blue,
      ),
      child: Text(label),
    );
  }
} 