import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/story.dart';

class StoryDetailPage extends StatefulWidget {
  final Story story;
  final String heroTag;

  const StoryDetailPage({
    super.key, 
    required this.story,
    required this.heroTag,
  });

  @override
  State<StoryDetailPage> createState() => _StoryDetailPageState();
}

class _StoryDetailPageState extends State<StoryDetailPage> {
  FlutterTts? flutterTts;
  bool isPlaying = false;
  bool isFavorite = false;
  double fontSize = 18.0;
  ScrollController scrollController = ScrollController();
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  Future<void> _initTts() async {
    flutterTts = FlutterTts();
    try {
      await flutterTts?.setLanguage("id-ID");
      await flutterTts?.setPitch(1.0);
      await flutterTts?.setSpeechRate(0.5);
      await flutterTts?.setVolume(1.0);
      
      flutterTts?.setCompletionHandler(() {
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      });

      flutterTts?.setErrorHandler((msg) {
        debugPrint("TTS error: $msg");
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      });

      setState(() {
        isInitialized = true;
        isFavorite = widget.story.isFavorite;
      });

      // Delay welcome message
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        _speakWelcome();
      }
    } catch (e) {
      debugPrint('Error initializing TTS: $e');
    }
  }

  Future<void> _speakWelcome() async {
    if (!isInitialized) return;
    try {
      await _speak(
        "Cerita ${widget.story.title}. "
        "Geser ke atas atau bawah untuk membaca. "
        "Ketuk dua kali untuk memulai atau menghentikan narasi. "
        "Geser tiga jari ke atas untuk memperbesar teks. "
        "Geser tiga jari ke bawah untuk memperkecil teks."
      );
    } catch (e) {
      debugPrint('Error speaking welcome message: $e');
    }
  }

  Future<void> _speak(String text) async {
    if (!isInitialized || flutterTts == null) return;
    
    try {
      if (isPlaying) {
        await flutterTts?.stop();
        if (mounted) {
          setState(() {
            isPlaying = false;
          });
        }
      } else {
        var result = await flutterTts?.speak(text);
        if (mounted && result == 1) {
          setState(() {
            isPlaying = true;
          });
        }
      }
    } catch (e) {
      debugPrint('Error in _speak: $e');
      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    }
  }

  void _changeFontSize(double delta) {
    if (!mounted) return;
    setState(() {
      fontSize = (fontSize + delta).clamp(14.0, 32.0);
    });
    _speak("Ukuran teks sekarang ${fontSize.round()}");
  }

  @override
  void dispose() {
    try {
      flutterTts?.stop();
      flutterTts = null;
      scrollController.dispose();
    } catch (e) {
      debugPrint('Error disposing TTS: $e');
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await flutterTts?.stop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: widget.heroTag,
            child: Text(
              widget.story.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() => isFavorite = !isFavorite);
                _speak(isFavorite ? "Ditambahkan ke favorit" : "Dihapus dari favorit");
              },
            ),
            IconButton(
              icon: Icon(
                isPlaying ? Icons.pause_circle : Icons.play_circle,
                color: Colors.white,
              ),
              onPressed: () => _speak(widget.story.content),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'share':
                    _speak("Bagikan cerita");
                    break;
                  case 'download':
                    _speak("Unduh cerita untuk dibaca offline");
                    break;
                  case 'report':
                    _speak("Laporkan masalah");
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'share',
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.blue),
                      SizedBox(width: 8),
                      Text('Bagikan'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'download',
                  child: Row(
                    children: [
                      Icon(Icons.download, color: Colors.green),
                      SizedBox(width: 8),
                      Text('Unduh'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'report',
                  child: Row(
                    children: [
                      Icon(Icons.report_problem, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Laporkan'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.indigo[50]!,
                Colors.grey[50]!,
              ],
            ),
          ),
          child: GestureDetector(
            onDoubleTap: () => _speak(widget.story.content),
            onVerticalDragUpdate: (details) {
              if (details.delta.dy > 0) {
                _speak("Geser ke bawah untuk melanjutkan membaca");
              } else {
                _speak("Geser ke atas untuk kembali ke atas");
              }
            },
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                if (widget.story.imageUrl.isNotEmpty)
                  Container(
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: NetworkImage(widget.story.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                Row(
                  children: [
                    const Icon(Icons.person, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      widget.story.author,
                      style: TextStyle(
                        fontSize: fontSize - 2,
                        color: Colors.grey[700],
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.access_time, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      "${widget.story.readTime} menit",
                      style: TextStyle(
                        fontSize: fontSize - 2,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.story.description,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  widget.story.content,
                  style: TextStyle(
                    fontSize: fontSize,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  children: widget.story.tags.map((tag) => Chip(
                    label: Text(tag),
                    backgroundColor: Colors.indigo[100],
                  )).toList(),
                ),
                if (widget.story.relatedStories.isNotEmpty) ...[
                  const SizedBox(height: 30),
                  const Text(
                    'Cerita Terkait',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...widget.story.relatedStories.map((title) => ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(title),
                    onTap: () => _speak("Buka cerita $title"),
                  )),
                ],
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              mini: true,
              onPressed: () => _changeFontSize(2.0),
              child: const Icon(Icons.text_increase),
            ),
            const SizedBox(height: 8),
            FloatingActionButton(
              mini: true,
              onPressed: () => _changeFontSize(-2.0),
              child: const Icon(Icons.text_decrease),
            ),
          ],
        ),
      ),
    );
  }
} 