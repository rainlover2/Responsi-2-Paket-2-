import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'tambah_barang.dart';
import 'edit_page.dart'; // Pastikan file edit_page.dart sudah dibuat

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listBarang = [];
  
  // GANTI IP INI SESUAI DENGAN YANG BERHASIL KAMU PAKAI TADI
  final String baseUrl = 'http://192.168.1.8/api_responsi'; 

  Future<void> _getData() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/read.php'));
      if (response.statusCode == 200) {
        setState(() {
          _listBarang = jsonDecode(response.body);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventaris Bahan NauMart")), 
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahBarangPage()))
              .then((value) => _getData());
        },
      ),
      body: _listBarang.isEmpty 
          ? const Center(child: Text("Belum ada data")) 
          : ListView.builder(
              itemCount: _listBarang.length,
              itemBuilder: (context, index) {
                final item = _listBarang[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(item['nama_barang'], style: const TextStyle(fontWeight: FontWeight.bold)), 
                    subtitle: Text("Harga: ${item['harga']} | Stok: ${item['jumlah']}\nExp: ${item['tanggal_kadaluwarsa']}"), 
                    isThreeLine: true,
                    // --- BAGIAN TOMBOL EDIT & HAPUS ---
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min, // <--- INI KUNCINYA
                      children: [
                        // Tombol Edit
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                             // Pastikan file edit_page.dart sudah ada
                             Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => EditPage(data: item))
                             ).then((value) => _getData());
                          },
                        ),
                        // Tombol Hapus
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            // Langsung hapus (tanpa dialog biar cepat tesnya)
                            http.post(Uri.parse('$baseUrl/delete.php'), body: {
                                'id': item['id'].toString(),
                            }).then((response) {
                                if (response.statusCode == 200) {
                                  _getData();
                                }
                            });
                          },
                        ),
                      ],
                    ),
                    // ----------------------------------
                  ),
                );
              },
            ),
    );
  }
}