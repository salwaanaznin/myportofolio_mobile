import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _techStack = '';
  String _projectUrl = '';
  String _projectImageUrl = '';

  bool _isSubmitting = false;

  // Validasi format URL.
  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value.trim());

    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  // Mengirim data proyek ke backend Django.
  Future<void> _submit() async {
    if (_isSubmitting) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Pastikan pengguna sudah login.
      final loggedIn = await ensureLoggedIn(context);

      if (!mounted || !loggedIn) return;

      final auth = context.read<AuthState>();
      final apiClient = context.read<ApiClient>();
      final token = auth.token;

      if (token == null) return;

      // Membuat objek Project sesuai skema API Django.
      final newProject = Project(
        title: _title.trim(),
        description: _description.trim(),
        techStack: _techStack.trim(),
        projectUrl: _projectUrl.trim(),
        projectImageUrl: _projectImageUrl.trim(),
      );

      // Mengirim POST request menggunakan token.
      final createdProject = await apiClient.createProject(
        newProject,
        token: token,
      );

      if (!mounted) return;

      // Dialog hanya muncul setelah backend berhasil menyimpan data.
      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Proyek berhasil ditambahkan!'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${createdProject.title}'),
                  Text('Description: ${createdProject.description}'),
                  Text('Tech Stack: ${createdProject.techStack}'),
                  Text('Project URL: ${createdProject.projectUrl}'),
                  if (createdProject.projectImageUrl.isNotEmpty)
                    Text('Image URL: ${createdProject.projectImageUrl}'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );

      if (!mounted) return;

      // Kosongkan form setelah proyek berhasil dibuat.
      _formKey.currentState!.reset();

      setState(() {
        _title = '';
        _description = '';
        _techStack = '';
        _projectUrl = '';
        _projectImageUrl = '';
      });
    } on ApiException catch (e) {
      if (!mounted) return;

      // Token tidak valid atau sudah dicabut.
      if (e.statusCode == 401) {
        try {
          await context.read<AuthState>().logout();
        } catch (_) {
          // AuthState tetap menghapus token lokal.
        }

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sesi login berakhir. Silakan login kembali.'),
          ),
        );

        await ensureLoggedIn(context);
      } else {
        // Menangani error API lainnya.
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal menambahkan proyek (${e.statusCode}).'),
          ),
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terjadi kesalahan. Periksa koneksi ke server.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Add Project Form')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. TITLE ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: 'Nama Proyek',
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _title = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Nama proyek tidak boleh kosong!';
                    }

                    return null;
                  },
                ),
              ),

              // === 2. DESCRIPTION ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !_isSubmitting,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Deskripsi Proyek',
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _description = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Deskripsi proyek tidak boleh kosong!';
                    }

                    return null;
                  },
                ),
              ),

              // === 3. TECH STACK ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !_isSubmitting,
                  maxLength: 255,
                  decoration: InputDecoration(
                    hintText: 'Contoh: Flutter, Django, Figma',
                    labelText: 'Tech Stack',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _techStack = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Tech Stack tidak boleh kosong!';
                    }

                    return null;
                  },
                ),
              ),

              // === 4. PROJECT URL ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !_isSubmitting,
                  keyboardType: TextInputType.url,
                  maxLength: 200,
                  decoration: InputDecoration(
                    hintText: 'https://example.com',
                    labelText: 'Project URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _projectUrl = value,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Project URL tidak boleh kosong!';
                    }

                    if (!_isValidUrl(value)) {
                      return 'Masukkan URL yang valid!';
                    }

                    return null;
                  },
                ),
              ),

              // === 5. PROJECT IMAGE URL (OPTIONAL) ===
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  enabled: !_isSubmitting,
                  keyboardType: TextInputType.url,
                  maxLength: 500,
                  decoration: InputDecoration(
                    hintText: 'https://example.com/image.png',
                    labelText: 'Project Image URL (Optional)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) => _projectImageUrl = value,
                  validator: (value) {
                    if (value != null &&
                        value.trim().isNotEmpty &&
                        !_isValidUrl(value)) {
                      return 'Masukkan URL gambar yang valid!';
                    }

                    return null;
                  },
                ),
              ),

              // === 6. TOMBOL SAVE ===
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: _isSubmitting ? null : _submit,
                    child: _isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Save'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
