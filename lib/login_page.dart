import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'home_page.dart';
import 'register_page.dart'; // <-- Agar Login kenal halaman Register

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  // PENTING: Ganti IP sesuai IP Laptop kamu (Cek di cmd > ipconfig)
  // Jangan pakai 'localhost' kalau run di HP Android asli.
  // Jika pakai Emulator, gunakan '10.0.2.2'.
  final String baseUrl = 'http://192.168.1.8/api_responsi'; 

  Future<void> _login() async {
    final response = await http.post(Uri.parse('$baseUrl/login.php'), body: {
      'username': _username.text,
      'password': _password.text,
    });
    final data = jsonDecode(response.body);
    if (data['pesan'] == 'sukses') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Login Gagal')));
    }
  }

  Future<void> _register() async {
    // Logika register mirip login, arahkan ke register.php
    final response = await http.post(Uri.parse('$baseUrl/register.php'), body: {
      'username': _username.text,
      'password': _password.text,
    });
    // Tampilkan notifikasi sukses register
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Inventaris NauMart")), 
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _username, decoration: const InputDecoration(labelText: 'Username')),
            TextField(controller: _password, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: const Text("Login")),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: const Text("Belum punya akun? Daftar di sini"),
            ),
          ],
        ),
      ),
    );
  }
}