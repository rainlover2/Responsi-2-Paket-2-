# responsi 2 paket 2 H1D023004 #

# Nama: Ratu Naurah Calista
# Nim: H1D023004  
# Shift Baru: B
# Shift Lama: C

# Video Demo Aplikasi #


#  Spesifkasi API yg digunakan #
Aplikasi ini menggunakan REST API sederhana yang dibuat dengan PHP Native yang disimpan dalam www pada laragon dengan nama folder "api_responsi".
Base URL:
Untuk Emulator Android Studio: http://10.0.2.2/api_responsi/
Untuk HP Fisik (Jaringan WiFi): http://192.168.1.8/api_responsi/ 
Format Data Response: JSON.
Metode Pengiriman Data (Request): POST (Form Data) dan GET.
Database: MySQL (db_responsi_h1d023004).

#  Penjelasan Tiap Fungsi #

# 1. Fungsi Autentikasi (Login & Register)
_login() (di login_page.dart)
Tujuan: Mengirim data username dan password ke server untuk diperiksa.
Cara Kerja:
Mengambil teks dari inputan (controller.text).
Melakukan request POST ke login.php.
Menerima respon JSON. Jika pesan == 'sukses', aplikasi menggunakan Navigator.pushReplacement untuk pindah ke Home (agar user tidak bisa kembali ke login dengan tombol back).
Jika gagal, memunculkan SnackBar peringatan.

_register() (di register_page.dart)
Tujuan: Mendaftarkan akun baru ke database.
Cara Kerja:
Mengambil inputan username dan password baru.
Melakukan request POST ke register.php.
Jika server merespon sukses (200), aplikasi memunculkan notifikasi berhasil dan menutup halaman register (Navigator.pop) agar kembali ke halaman Login.

# 2. Fungsi Tampil Data (Read)
initState() (di home_page.dart)
Tujuan: Fungsi bawaan Flutter yang dijalankan pertama kali saat halaman dibuka.
Cara Kerja: Di sini kita memanggil fungsi _getData() agar saat aplikasi terbuka, data barang langsung dimuat otomatis tanpa perlu klik tombol refresh.

_getData() (di home_page.dart)
Tujuan: Mengambil daftar seluruh barang dari server untuk ditampilkan.
Cara Kerja:
Melakukan request GET ke read.php.
Menerima respon mentah (String), lalu mengubahnya menjadi format List/Array menggunakan jsonDecode().
Menggunakan setState() untuk memperbarui variabel _listBarang. Penting: Tanpa setState, data masuk tapi layar tidak akan berubah (tetap kosong).

# 3. Fungsi Manipulasi Data (Create, Update, Delete)
_simpan() (di tambah_barang.dart)
Tujuan: Mengirim data barang baru ke database.
Cara Kerja:
Mengumpulkan 5 data inputan (Nama, Harga, Jumlah, Tgl Masuk, Tgl Exp).
Mengirim paket data tersebut via POST ke create.php.
Jika berhasil (Status 200), halaman tambah ditutup (Navigator.pop). Saat kembali ke Home, daftar data otomatis di-refresh.

initState() (di edit_page.dart)
Tujuan: Mengisi kolom inputan dengan data lama sebelum diedit.
Cara Kerja: Mengambil data yang dikirim dari Home (widget.data), lalu memasukkannya ke dalam TextEditingController. Ini membuat kolom isian tidak kosong saat halaman Edit dibuka, sehingga user tahu apa yang mau diedit.

_update() (di edit_page.dart)
Tujuan: Mengirim perubahan data ke server.
Cara Kerja:
Mirip dengan simpan, tapi wajib mengirimkan ID barang (id).
Data dikirim via POST ke update.php.
Server akan mencari barang berdasarkan ID tersebut dan menimpa datanya dengan data baru.

Logika Hapus / Delete (di tombol onPressed home_page.dart)
Tujuan: Menghapus barang permanen dari database.
Cara Kerja:
(Opsional) Menampilkan Dialog Konfirmasi ("Yakin hapus?").
Mengirim request POST ke delete.php dengan membawa parameter ID barang.
Setelah sukses, fungsi _getData() dipanggil kembali. Ini membuat barang yang barusan dihapus langsung hilang dari layar tanpa perlu restart aplikasi.
