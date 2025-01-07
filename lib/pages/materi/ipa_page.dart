import 'package:flutter/material.dart';
import 'materi_template.dart';

class IpaPage extends StatelessWidget {
  const IpaPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Tubuh Manusia':
        return Icons.accessibility_new;
      case 'Hewan':
        return Icons.pets;
      case 'Tumbuhan':
        return Icons.forest;
      case 'Lingkungan Hidup':
        return Icons.eco;
      case 'Energi':
        return Icons.bolt;
      default:
        return Icons.science;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'IPA',
      materiTitles: const [
        'Tubuh Manusia',
        'Hewan',
        'Tumbuhan',
        'Lingkungan Hidup',
        'Energi',
      ],
      themeColor: Colors.orange,
      getIcon: _getIconForMateri,
    );
  }
} 