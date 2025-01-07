import 'package:flutter/material.dart';
import 'materi_template.dart';

class KeterampilanPage extends StatelessWidget {
  const KeterampilanPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Kebersihan Diri':
        return Icons.clean_hands;
      case 'Kerapian':
        return Icons.checkroom;
      case 'Kemandirian':
        return Icons.person;
      case 'Kreativitas':
        return Icons.lightbulb;
      case 'Kerja Sama':
        return Icons.group;
      default:
        return Icons.build;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'Keterampilan',
      materiTitles: const [
        'Kebersihan Diri',
        'Kerapian',
        'Kemandirian',
        'Kreativitas',
        'Kerja Sama',
      ],
      themeColor: Colors.teal,
      getIcon: _getIconForMateri,
    );
  }
} 