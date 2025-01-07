import 'package:flutter/material.dart';
import 'materi_template.dart';

class MatematikPage extends StatelessWidget {
  const MatematikPage({super.key});

  IconData _getIconForMateri(String title) {
    switch (title) {
      case 'Angka':
        return Icons.looks_one;
      case 'Penjumlahan':
        return Icons.add_circle;
      case 'Pengurangan':
        return Icons.remove_circle;
      case 'Perkalian':
        return Icons.close;
      case 'Pembagian':
        return Icons.functions;
      default:
        return Icons.book;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MateriPage(
      title: 'Matematika',
      materiTitles: const [
        'Angka',
        'Penjumlahan',
        'Pengurangan',
        'Perkalian',
        'Pembagian',
      ],
      themeColor: Colors.blue,
      getIcon: _getIconForMateri,
    );
  }
} 