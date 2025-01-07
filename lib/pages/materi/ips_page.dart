import 'package:flutter/material.dart';
import 'materi_template.dart';

class IpsPage extends StatelessWidget {
  const IpsPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Keluarga':
        return Icons.family_restroom;
      case 'Lingkungan':
        return Icons.location_city;
      case 'Pekerjaan':
        return Icons.work;
      case 'Transportasi':
        return Icons.directions_bus;
      case 'Budaya':
        return Icons.theater_comedy;
      default:
        return Icons.people;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'IPS',
      materiTitles: const [
        'Keluarga',
        'Lingkungan',
        'Pekerjaan',
        'Transportasi',
        'Budaya',
      ],
      themeColor: Colors.purple,
      getIcon: _getIconForMateri,
    );
  }
} 