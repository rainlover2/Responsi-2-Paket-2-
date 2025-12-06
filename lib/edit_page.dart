import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  // Kita butuh variabel penampung data yang dikirim dari Home
  final Map data; 
  
  const EditPage({super.key, required this.data});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _nama = TextEditingController();
  final _harga = TextEditingController();
  final _jumlah = TextEditingController();
  final _tglMasuk = TextEditingController();
  final _tglExp = TextEditingController();

  @override
  void initState() {
    super.initState();
    // SAAT HALAMAN DIBUKA, ISI KOLOM DENGAN DATA LAMA
    _nama.text = widget.data['nama_barang'];
    _harga.text = widget.data['harga'].toString();
    _jumlah.text = widget.data['jumlah'].toString();
    _tglMasuk.text = widget.data['tanggal_masuk'];
    _tglExp.text = widget.data['tanggal_kadaluwarsa'];
  }

  Future<void> _update() async {
    final url = 'http://192.168.1.8/api_responsi/update.php'; // Ganti IP jika perlu
    
    final response = await http.post(Uri.parse(url), body: {
      'id': widget.data['id'].toString(), // PENTING: ID Barang
      'nama_barang': _nama.text,
      'harga': _harga.text,
      'jumlah': _jumlah.text,
      'tanggal_masuk': _tglMasuk.text,
      'tanggal_kadaluwarsa': _tglExp.text,
    });

    if (response.statusCode == 200) {
       // Bisa tambahkan showDialog sukses disini jika mau
       Navigator.pop(context); // Kembali ke Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Barang")),
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
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), // Warna Orange biar beda
                onPressed: _update, 
                child: const Text("Update Data", style: TextStyle(color: Colors.white))
            )
          ],
        ),
      ),
    );
  }
}