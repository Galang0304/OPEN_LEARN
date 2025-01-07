import 'package:flutter/material.dart';
import 'materi_template.dart';

class KesenianPage extends StatelessWidget {
  const KesenianPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Menggambar':
        return Icons.brush;
      case 'Mewarnai':
        return Icons.palette;
      case 'Bernyanyi':
        return Icons.music_note;
      case 'Menari':
        return Icons.directions_run;
      case 'Kerajinan Tangan':
        return Icons.handyman;
      default:
        return Icons.palette;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'Kesenian',
      materiTitles: const [
        'Menggambar',
        'Mewarnai',
        'Bernyanyi',
        'Menari',
        'Kerajinan Tangan',
      ],
      themeColor: Colors.pink,
      getIcon: _getIconForMateri,
    );
  }
} 