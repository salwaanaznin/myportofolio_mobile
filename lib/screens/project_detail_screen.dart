import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';

class ProjectDetailScreen extends StatelessWidget {
  const ProjectDetailScreen({super.key, required this.project});

  final Project project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Project Detail',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar hanya ditampilkan jika URL tidak kosong.
            if (project.projectImageUrl.isNotEmpty) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  project.projectImageUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Text('Failed to load image.'));
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],

            // Judul proyek.
            Text(
              project.title,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            // Teknologi yang digunakan.
            const Text(
              'Tech Stack',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC66B91),
              ),
            ),

            const SizedBox(height: 8),

            Text(project.techStack, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // Deskripsi proyek.
            const Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC66B91),
              ),
            ),

            const SizedBox(height: 8),

            Text(project.description, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            // URL proyek.
            const Text(
              'Project URL',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC66B91),
              ),
            ),

            const SizedBox(height: 8),

            SelectableText(
              project.projectUrl.isEmpty
                  ? 'No project URL available.'
                  : project.projectUrl,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
