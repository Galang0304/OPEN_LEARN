import 'package:flutter/material.dart';
import 'materi_template.dart';

class BahasaPage extends StatelessWidget {
  const BahasaPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Huruf dan Alfabet':
        return Icons.abc;
      case 'Membaca':
        return Icons.menu_book;
      case 'Menulis':
        return Icons.edit;
      case 'Berbicara':
        return Icons.record_voice_over;
      case 'Mendengarkan':
        return Icons.hearing;
      default:
        return Icons.book;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'Bahasa',
      materiTitles: const [
        'Huruf dan Alfabet',
        'Membaca',
        'Menulis',
        'Berbicara',
        'Mendengarkan',
      ],
      themeColor: Colors.green,
      getIcon: _getIconForMateri,
    );
  }
} 