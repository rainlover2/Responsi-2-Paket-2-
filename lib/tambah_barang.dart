import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahBarangPage extends StatefulWidget {
  const TambahBarangPage({super.key});
  @override
  State<TambahBarangPage> createState() => _TambahBarangPageState();
}

class _TambahBarangPageState extends State<TambahBarangPage> {
  // Controller untuk 5 input wajib 
  final _nama = TextEditingController();
  final _harga = TextEditingController();
  final _jumlah = TextEditingController();
  final _tglMasuk = TextEditingController();
  final _tglExp = TextEditingController();
  
  final String baseUrl = 'http://192.168.1.8/api_responsi';

  Future<void> _simpan() async {
    final response = await http.post(Uri.parse('$baseUrl/create.php'), body: {
      'nama_barang': _nama.text,
      'harga': _harga.text,
      'jumlah': _jumlah.text,
      'tanggal_masuk': _tglMasuk.text,
      'tanggal_kadaluwarsa': _tglExp.text,
    });
    if (response.statusCode == 200) {
      Navigator.pop(context); // Kembali ke home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tambah Inventaris NauMart")), // [cite: 6]
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nama, decoration: const InputDecoration(labelText: 'Nama Barang')),
            TextField(controller: _harga, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Harga')),
            TextField(controller: _jumlah, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Jumlah')),
            TextField(controller: _tglMasuk, decoration: const InputDecoration(labelText: 'Tgl Masuk')),
            TextField(controller: _tglExp, decoration: const InputDecoration(labelText: 'Tgl Kadaluwarsa')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _simpan, child: const Text("Simpan Data"))
          ],
        ),
      ),
    );
  }
}