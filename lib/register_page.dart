import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // URL API (Pastikan IP benar: 10.0.2.2 untuk Emulator)
  final String url = 'http://192.168.1.8/api_responsi/register.php';

  Future<void> _register() async {
    print("1. Tombol ditekan"); // Cek apakah tombol respon

    try {
      print("2. Mencoba kirim ke: $url");
      print("3. Data: ${_username.text} | ${_password.text}");

      final response = await http.post(Uri.parse(url), body: {
        'username': _username.text,
        'password': _password.text,
      });

      print("4. Respon Server: ${response.statusCode}");
      print("5. Isi Body: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['pesan'] == 'sukses') {
          print("6. Sukses!");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi Berhasil!')),
          );
          Navigator.pop(context); 
        } else {
          print("6. Gagal: Server bilang pesan bukan sukses");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registrasi Gagal!')),
          );
        }
      } else {
        print("Error Server Bukan 200");
      }
    } catch (e) {
      print("ERROR PARAH: $e"); // Ini yang paling penting dilihat
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Akun Baru")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.person_add, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            TextField(
              controller: _username,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _register,
                child: const Text("DAFTAR SEKARANG"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}