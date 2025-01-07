import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/story.dart';
import 'story_detail_page.dart';

class CeritaPage extends StatefulWidget {
  const CeritaPage({super.key});

  @override
  State<CeritaPage> createState() => _CeritaPageState();
}

class _CeritaPageState extends State<CeritaPage> {
  final FlutterTts flutterTts = FlutterTts();
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  bool isSearching = false;

  final List<Story> allStories = [
    Story(
      title: 'Malin Kundang',
      description: 'Kisah anak durhaka dari Sumatra Barat',
      content: 'Di sebuah perkampungan nelayan di Sumatra Barat, hiduplah seorang janda miskin dengan anak laki-lakinya yang bernama Malin Kundang...',
      author: 'Cerita Rakyat',
      category: 'Dongeng',
      tags: ['Legenda', 'Sumatra', 'Moral'],
      readTime: 10,
      relatedStories: ['Bawang Merah Bawang Putih', 'Timun Mas'],
    ),
    Story(
      title: 'Timun Mas',
      description: 'Cerita keberanian gadis kecil melawan raksasa',
      content: 'Pada zaman dahulu, hiduplah sepasang suami istri petani. Mereka hidup sederhana di sebuah desa...',
      author: 'Cerita Rakyat',
      category: 'Dongeng',
      tags: ['Legenda', 'Jawa', 'Keberanian'],
      readTime: 8,
      relatedStories: ['Malin Kundang', 'Bawang Merah Bawang Putih'],
    ),
    Story(
      title: 'Kancil dan Buaya',
      description: 'Kisah kecerdikan kancil menghadapi buaya',
      content: 'Suatu hari, seekor kancil yang cerdik ingin menyeberangi sungai...',
      author: 'Cerita Rakyat',
      category: 'Fabel',
      tags: ['Hewan', 'Kecerdikan', 'Moral'],
      readTime: 5,
      relatedStories: ['Kancil Mencuri Timun', 'Kura-kura dan Kelinci'],
    ),
    Story(
      title: 'Bawang Merah Bawang Putih',
      description: 'Kisah dua saudari dengan sifat yang berbeda',
      content: 'Pada zaman dahulu, hiduplah dua orang gadis yang bernama Bawang Merah dan Bawang Putih...',
      author: 'Cerita Rakyat',
      category: 'Dongeng',
      tags: ['Legenda', 'Moral', 'Kebaikan'],
      readTime: 12,
      relatedStories: ['Malin Kundang', 'Timun Mas'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _configureTts();
    _speak(
      "Halaman cerita. Temukan berbagai cerita menarik. "
      "Ketuk dua kali untuk membuka cerita. "
      "Tekan lama untuk mendengar ringkasan cerita."
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

  List<Story> _getFilteredStories() {
    if (searchQuery.isEmpty) return allStories;
    
    return allStories.where((story) =>
      story.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
      story.description.toLowerCase().contains(searchQuery.toLowerCase()) ||
      story.tags.any((tag) => tag.toLowerCase().contains(searchQuery.toLowerCase()))
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
          ? const Text(
              'Cerita',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
          : TextField(
              controller: searchController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Cari cerita...',
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
        actions: [
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  searchQuery = '';
                }
                isSearching = !isSearching;
              });
              _speak(isSearching ? "Mode pencarian aktif" : "Mode pencarian nonaktif");
            },
          ),
        ],
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
        child: _buildStoryList(_getFilteredStories()),
      ),
    );
  }

  Widget _buildStoryList(List<Story> stories) {
    if (stories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'Tidak ada cerita ditemukan',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: stories.length,
      itemBuilder: (context, index) {
        final story = stories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {
                _speak(story.title);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoryDetailPage(
                      story: story,
                      heroTag: 'story_${story.title}_$index',
                    ),
                  ),
                );
              },
              onLongPress: () => _speak("${story.title}: ${story.description}"),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            story.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (story.isFavorite)
                          const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 20,
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      story.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${story.readTime} menit',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const Spacer(),
                        ...story.tags.take(2).map((tag) => Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(
                              tag,
                              style: const TextStyle(fontSize: 12),
                            ),
                            backgroundColor: Colors.indigo[100],
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    flutterTts.stop();
    searchController.dispose();
    super.dispose();
  }
} 