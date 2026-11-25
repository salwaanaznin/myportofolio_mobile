import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class EducationFormPage extends StatefulWidget {
  const EducationFormPage({super.key});

  @override
  State<EducationFormPage> createState() => _EducationFormPageState();
}

class _EducationFormPageState extends State<EducationFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Variabel untuk menyimpan data formulir
  String _title = "";
  String _description = "";
  String _major = "";
  String _degree = "S1";
  String _thumbnail = "";

  // Pilihan sesuai model Education di Django
  final List<String> _degrees = ['SMA', 'S1'];

  // Validasi URL gambar jika pengguna mengisinya
  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);

    if (uri == null) return false;

    return (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty &&
        uri.host.contains('.');
  }

  void _saveEducation() {
    // Periksa seluruh input
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Simpan nilai field yang sudah valid ke variabel
    _formKey.currentState!.save();

    // Tampilkan ringkasan melalui dialog
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Data Pendidikan Berhasil Diisi!'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Institusi: $_title'),
                const SizedBox(height: 8),

                Text('Deskripsi: $_description'),
                const SizedBox(height: 8),

                Text('Jurusan: ${_major.isEmpty ? "-" : _major}'),
                const SizedBox(height: 8),

                Text('Jenjang Pendidikan: $_degree'),
                const SizedBox(height: 8),

                Text('URL Logo: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Education Form',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // Menggunakan Drawer dari Tutorial 09
      drawer: const LeftDrawer(),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // === 1. NAMA INSTITUSI ===
              TextFormField(
                maxLength: 255,
                decoration: const InputDecoration(
                  labelText: 'Nama Institusi',
                  hintText: 'Contoh: Universitas Indonesia',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _title = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama institusi tidak boleh kosong!';
                  }

                  if (value.trim().length > 255) {
                    return 'Nama institusi maksimal 255 karakter!';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === 2. DESKRIPSI ===
              TextFormField(
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi Pendidikan',
                  hintText: 'Ceritakan pendidikan dan kegiatanmu',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                onSaved: (value) {
                  _description = value!.trim();
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Deskripsi tidak boleh kosong!';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === 3. JURUSAN ===
              TextFormField(
                maxLength: 255,
                decoration: const InputDecoration(
                  labelText: 'Jurusan (Opsional)',
                  hintText: 'Contoh: Sistem Informasi',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _major = value?.trim() ?? "";
                },
                validator: (value) {
                  if (value != null && value.trim().length > 255) {
                    return 'Jurusan maksimal 255 karakter!';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === 4. JENJANG PENDIDIKAN ===
              DropdownButtonFormField<String>(
                initialValue: _degree,
                decoration: const InputDecoration(
                  labelText: 'Jenjang Pendidikan',
                  border: OutlineInputBorder(),
                ),
                items: _degrees.map((degree) {
                  return DropdownMenuItem<String>(
                    value: degree,
                    child: Text(degree),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _degree = value;
                    });
                  }
                },
                onSaved: (value) {
                  _degree = value ?? "S1";
                },
                validator: (value) {
                  if (value == null || !_degrees.contains(value)) {
                    return 'Pilih jenjang pendidikan!';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // === 5. URL LOGO INSTITUSI ===
              TextFormField(
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'URL Logo Institusi (Opsional)',
                  hintText: 'https://example.com/logo.png',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _thumbnail = value?.trim() ?? "";
                },
                validator: (value) {
                  final url = value?.trim() ?? "";

                  // Field boleh kosong
                  if (url.isEmpty) {
                    return null;
                  }

                  if (url.length > 200) {
                    return 'URL maksimal 200 karakter!';
                  }

                  if (!_isValidUrl(url)) {
                    return 'Masukkan URL yang valid!';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 24),

              // === 6. TOMBOL SIMPAN ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _saveEducation,
                  child: const Text(
                    'Simpan Pendidikan',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
