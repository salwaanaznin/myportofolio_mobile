# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


### Tugas 7

**1. Jelaskan apa yang dimaksud dengan widget tree pada Flutter dan bagaimana hubungan induk-anak (parent-child) bekerja antar-widget!**

Widget tree adalah struktur hierarki yang menggambarkan susunan widget dalam aplikasi Flutter. Setiap widget dapat memiliki widget lain sebagai child, sehingga terbentuk hubungan parent-child. Parent berperan dalam membungkus atau mengatur widget anak, misalnya menentukan posisi, ukuran, atau tata letaknya. Pada proyek MyPortfolio Mobile, MaterialApp memuat MyHomePage sebagai halaman utama. Di dalam MyHomePage terdapat Scaffold yang menyediakan AppBar dan body. Selanjutnya, body menggunakan Column, Row, dan GridView.count untuk menyusun InfoCard dan ItemCard. Hubungan ini memungkinkan setiap widget memiliki perannya masing-masing dalam membentuk tampilan aplikasi.

**2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya masing-masing!**

Widget yang digunakan dalam proyek MyPortfolio Mobile antara lain:
1. **MyApp:** Widget utama yang membangun MaterialApp dan mengatur konfigurasi aplikasi.
2. **MaterialApp:** Mengatur tema, judul, serta halaman utama aplikasi.
3. **MyHomePage:** Widget halaman utama portofolio yang menggunakan StatelessWidget.
4. **Scaffold:** Menyediakan struktur dasar halaman, seperti AppBar dan body.
5. **AppBar:** Menampilkan header aplikasi dengan judul MyPortfolio.
6. **Text:** Menampilkan informasi berupa teks, seperti nama, NPM, dan judul tombol.
7. **Padding:** Memberikan jarak di sekitar widget agar tampilan lebih rapi.
8. **Column:** Menyusun widget secara vertikal.
9. **Row:** Menyusun widget secara horizontal, seperti tiga kartu informasi.
10. **Center:** Menempatkan widget anak di tengah ruang yang tersedia.
11. **Card:** Membuat tampilan kartu untuk informasi profil.
12. **Container:** Mengatur ukuran, padding, dan tata letak komponen.
13. **SizedBox:** Memberikan jarak antar-widget.
14. **GridView.count:** Menyusun tombol menu dalam bentuk grid tiga kolom.
15. **InfoCard:** Widget buatan sendiri untuk menampilkan judul dan isi informasi profil.
16. **ItemCard:** Widget buatan sendiri untuk menampilkan menu aksi berbentuk kartu.
17. **Material:** Menyediakan dasar visual kartu dan warna latarnya.
18. **InkWell:** Membuat tombol dapat merespons sentuhan melalui onTap.
19. **Icon:** Menampilkan ikon yang sesuai dengan fungsi tombol.
20. **SnackBar:** Menampilkan pesan saat pengguna menekan tombol.

Selain widget di atas, proyek juga menggunakan ScaffoldMessenger untuk mengelola SnackBar, ThemeData dan ColorScheme untuk mengatur tema, serta ItemHomepage sebagai model data menu. StatelessWidget digunakan sebagai dasar pembuatan widget yang tidak mengelola state lokal yang berubah.

**3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini umumnya digunakan sebagai root widget pada aplikasi Flutter!**

MaterialApp adalah widget yang menyediakan konfigurasi utama aplikasi Flutter berbasis Material Design, seperti tema, navigasi, judul aplikasi, dan halaman utama.
MaterialApp umumnya digunakan sebagai root widget karena menyediakan berbagai fasilitas yang dibutuhkan oleh widget lain di bawahnya, sehingga pengaturan aplikasi dapat dilakukan secara terpusat dan konsisten.
Dalam proyek MyPortfolio Mobile, MaterialApp digunakan untuk mengatur tema aplikasi melalui ThemeData dan ColorScheme.fromSeed, menentukan judul MyPortfolio, serta menetapkan MyHomePage sebagai halaman utama melalui properti home.

**4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget! Kapan kita sebaiknya memilih StatelessWidget dan kapan harus menggunakan StatefulWidget?**

StatelessWidget merupakan widget yang tidak mengelola state lokal yang berubah selama widget digunakan. Widget ini cocok untuk menampilkan komponen yang relatif statis, seperti informasi profil, ikon, atau teks.
Sebaliknya, StatefulWidget digunakan ketika suatu widget perlu menyimpan dan memperbarui state yang memengaruhi tampilannya, misalnya counter, pilihan checkbox, atau data input pengguna.
Dalam proyek MyPortfolio Mobile, MyHomePage, InfoCard, dan ItemCard menggunakan StatelessWidget karena tidak memerlukan state lokal yang berubah. Interaksi pada ItemCard hanya menampilkan SnackBar melalui ScaffoldMessenger, sehingga tidak memerlukan StatefulWidget.
Jadi, StatelessWidget digunakan ketika tidak diperlukan pengelolaan state lokal yang berubah, sedangkan StatefulWidget dipilih ketika perubahan state perlu dikelola dan ditampilkan pada antarmuka.

**5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di dalam metode build?**

BuildContext adalah objek yang merepresentasikan posisi suatu widget dalam widget tree. BuildContext memungkinkan widget mengakses informasi atau layanan dari widget lain yang berada di atasnya dalam struktur tersebut.
BuildContext penting karena banyak fitur Flutter memerlukan konteks widget, misalnya untuk mengambil tema aplikasi, ukuran layar, atau menampilkan SnackBar.
Pada proyek MyPortfolio Mobile, penggunaan BuildContext dapat dilihat pada beberapa bagian:

- `Theme.of(context).colorScheme.primary` digunakan untuk mengambil warna utama dari tema aplikasi.
- `MediaQuery.of(context).size.width` digunakan untuk mendapatkan lebar layar dalam menentukan ukuran InfoCard.
- `ScaffoldMessenger.of(context)` digunakan untuk mengakses ScaffoldMessenger dan menampilkan SnackBar.

Dalam metode `build(BuildContext context)`, context diterima sebagai parameter agar widget dapat membangun tampilan sesuai dengan lingkungan dan posisinya pada widget tree.

**6. Jelaskan konsep hot reload di Flutter dan apa perbedaannya dengan hot restart! Kapan kita tidak bisa hanya mengandalkan hot reload dan harus melakukan hot restart atau full restart?**

Hot reload merupakan fitur Flutter yang memungkinkan perubahan kode diterapkan pada aplikasi yang sedang berjalan tanpa memulai aplikasi dari awal. State aplikasi umumnya tetap dipertahankan, sehingga proses pengembangan menjadi lebih cepat.
Sementara itu, hot restart menjalankan ulang aplikasi dari awal pada tingkat kode Dart sehingga state yang tersimpan selama aplikasi berjalan akan direset.
Hot reload cocok digunakan untuk perubahan tampilan, seperti warna tombol, teks, atau tata letak widget. Namun, hot reload tidak selalu menjalankan ulang kode inisialisasi seperti fungsi main() atau initState(). Untuk perubahan seperti ini, hot restart biasanya diperlukan.
Full restart dilakukan dengan menghentikan dan menjalankan ulang aplikasi, terutama ketika perubahan melibatkan konfigurasi native, dependency, atau bagian proyek yang membutuhkan proses build ulang.
Dalam pengerjaan MyPortfolio Mobile, hot reload digunakan untuk memperbarui tampilan setelah perubahan kode, sedangkan hot restart digunakan untuk menjalankan ulang aplikasi ketika perubahan perlu diterapkan dari awal.

## AI Disclosure

Dalam pengerjaan Tutorial 08 dan Individual Assignment 7, saya menggunakan ChatGPT (OpenAI) sebagai alat bantu pembelajaran dan pendamping teknis.

**Penyusunan Jawaban Pertanyaan Reflektif Individual Assignment 7**
- Prompt: "dr materi Tutorial 08 yang aku kasih, bantuin pahamin dan merumuskan jawaban pertanyaan reflektifnya. jelasin konsepnya dengan bahasa yang mudah dipahami, trs hubungkan dengan penerapannya pada proyek Flutter milikku. bantu susun jawabannya biar runtut"
- Screenshoot jawaban: 
![AI Disclosure 1](<AI%20DISCLOSURE/tugas7-1.jpeg>)
![AI Disclosure 2](<AI%20DISCLOSURE/tugas7-2.jpeg>)
![AI Disclosure 3](<AI%20DISCLOSURE/tugas7-3.jpeg>)
- Pemanfaatan output: Output AI digunakan sebagai referensi untuk memahami konsep dasar Flutter dan membantu merumuskan jawaban enam pertanyaan reflektif pada README.md. Penjelasan yang diberikan kemudian disesuaikan dengan implementasi pada proyek MyPortfolio Mobile agar jawaban lebih runtut, jelas, dan relevan dengan kode yang digunakan.

### Tugas 8

**1. Jelaskan perbedaan antara Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop(). Metode apa yang digunakan untuk membuka formulir dari kartu aksi? Jelaskan juga bagaimana opsi Home di drawer membawa pengguna kembali ke halaman utama.**

- Navigator.push() digunakan untuk membuka halaman baru dengan menambahkannya ke navigation stack, sehingga halaman sebelumnya tetap tersimpan dan pengguna dapat kembali menggunakan tombol Back. 
- Navigator.pushReplacement() mengganti halaman yang sedang aktif dengan halaman baru, sedangkan Navigator.pop() menutup halaman teratas dan kembali ke halaman sebelumnya.
- Pada aplikasi MyPortfolio Mobile, Navigator.push() digunakan dalam ItemCard untuk membuka EducationFormPage ketika kartu Tambah Education ditekan. Sementara itu, opsi Home pada LeftDrawer menggunakan Navigator.pushReplacement() untuk mengganti halaman saat ini dengan MyHomePage, sehingga pengguna kembali ke halaman utama.

**2. Bagaimana susunan Scaffold, AppBar, dan Drawer membantu menjaga struktur halaman tetap konsisten? Berikan satu contoh penggunaan warna tema portofolio di lebih dari satu halaman.**

- Scaffold menyediakan struktur dasar halaman Flutter 
- AppBar menampilkan judul dan navigasi bagian atas 
- Drawer menyediakan menu untuk berpindah antarhalaman. 

Dengan menggunakan komponen tersebut secara konsisten, halaman utama dan formulir memiliki struktur yang seragam serta navigasi yang mudah digunakan.

Pada aplikasi MyPortfolio Mobile, MyHomePage dan EducationFormPage sama-sama menggunakan Scaffold, AppBar, serta komponen LeftDrawer. Warna AppBar kedua halaman menggunakan Theme.of(context).colorScheme.primary, yang berasal dari tema indigo pada main.dart. Hal ini membuat tampilan aplikasi tetap konsisten.

**3. Mengapa tata letak tersebut dipilih untuk formulir? Jelaskan peran widget pengatur jarak dan widget penggulir ketika ruang layar terbatas.**

Formulir Education disusun menggunakan Column agar setiap input ditampilkan secara vertikal dan mudah diikuti pengguna. SizedBox digunakan untuk memberikan jarak antarfield agar tampilannya tidak terlalu rapat, sedangkan Padding memberikan ruang antara isi formulir dan tepi layar.

Selain itu, SingleChildScrollView memungkinkan formulir digulir secara vertikal ketika tinggi konten melebihi ruang yang tersedia, misalnya pada layar ponsel atau ketika keyboard muncul. Dengan demikian, pengguna tetap dapat mengakses seluruh input dan tombol Simpan.

**4. Apa peran GlobalKey<FormState>, validator, dan validate() saat tombol Simpan ditekan? Berikan satu contoh nilai yang ditolak oleh validasi dan jelaskan mengapa memilih jenis input atau papan ketik saja belum cukup.**

- GlobalKey<FormState> digunakan untuk mengakses dan mengelola state dari widget Form. 
- Setiap validator memeriksa apakah nilai pada field memenuhi aturan yang ditentukan
- validate() menjalankan seluruh validator ketika tombol Simpan ditekan. 
Jika ada input tidak valid, pesan kesalahan ditampilkan pada field terkait dan dialog ringkasan tidak akan muncul.

Contohnya, jika pengguna mengisi Nama Institusi hanya dengan spasi, validasi value.trim().isEmpty akan menolak input tersebut karena nama institusi wajib diisi. Pada field URL Logo Institusi, aplikasi juga memeriksa format URL dan mengharuskan penggunaan skema HTTP atau HTTPS apabila field diisi.

Pemilihan jenis keyboard, seperti TextInputType.url, hanya membantu pengguna mengetik URL dengan lebih mudah, tetapi tidak menjamin format input sudah benar. Oleh karena itu, validasi tetap diperlukan untuk memastikan data sesuai aturan model.

## AI Disclosure

Dalam pengerjaan Tutorial 08 dan Individual Assignment 7, saya menggunakan ChatGPT sebagai alat bantu pembelajaran dan pendamping teknis.

**Implementasi Navigasi dari ItemCard ke EducationFormPage**
- Prompt: "liat deh educationformpage aku. gmn cara menghubungkannya ke tombol Tambah Education di itemCard pake Navigator.push() tanpa ngubah fungsi tombol lainnya"
- Screenshoot jawaban: 
![AI Disclosure 1](<AI%20DISCLOSURE/tugas8-1.jpeg>)
- Pemanfaatan output: Output AI digunakan sebagai referensi untuk menambahkan navigasi Navigator.push() pada tombol Tambah Education melalui kondisi else if di ItemCard. Implementasi ini memungkinkan pengguna membuka EducationFormPage tanpa mengubah fungsi tombol lainnya, sekaligus mempertahankan mekanisme kembali ke halaman Home.

**Pengaturan Nilai Awal dan Pilihan Dropdown Jenjang Pendidikan**
- Prompt: "aku pake DropdownButtonFormField<String> kan ya buat jenjang pendidikan. gmn cara mengatur initialvalue nya ke s1 dan membatasi pilihannya cuman sma sm s1 aja"
- Screenshoot jawaban: 
![AI Disclosure 2](<AI%20DISCLOSURE/tugas8-2.jpeg>)
- Pemanfaatan output: Menggunakan penjelasan dan contoh kode dari AI untuk mengatur initialValue menjadi S1 serta membatasi pilihan dropdown hanya SMA dan S1 melalui DropdownButtonFormField, agar sesuai dengan model Education pada Django.