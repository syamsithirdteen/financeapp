import 'package:flutter/material.dart';

class GridMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const GridMenuItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    // Mengambil warna primer (Indigo) dari tema utama
    final Color primaryColor = Theme.of(context).primaryColor;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Menggunakan CircleAvatar untuk "icon bubble" yang modern
        CircleAvatar(
          radius: 30,
          // Latar belakang bubble = 10% opacity dari warna primer
          backgroundColor: primaryColor.withOpacity(0.1),
          child: Icon(
            icon,
            size: 30,
            // Warna ikon = warna primer
            color: primaryColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12, // Ukuran font disesuaikan untuk 4 kolom
          ),
        ),
      ],
    );
  }
}
