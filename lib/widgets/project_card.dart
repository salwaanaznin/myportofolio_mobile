
import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/screens/education_form.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna yang sudah ditentukan pada menu.dart
      color: item.color,
      borderRadius: BorderRadius.circular(12),

      child: InkWell(
        onTap: () {
          // Menampilkan SnackBar ketika tombol ditekan
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  "Kamu telah menekan tombol ${item.name}!",
                ),
              ),
            );

          // Navigasi ke halaman Tambah Proyek (Tutorial 09)
          if (item.name == "Tambah Proyek") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProjectFormPage(),
              ),
            );
          }

          // Navigasi ke halaman Tambah Education (Tugas 8)
          else if (item.name == "Tambah Education") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EducationFormPage(),
              ),
            );
          }
        },

        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                ),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
