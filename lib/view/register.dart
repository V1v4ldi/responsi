import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/login_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Buat Akun Baru", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: "Username Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () async {
                if (_userController.text.isEmpty || _passController.text.isEmpty) {
                   ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Isi semua data!")),
                  );
                  return;
                }

                final auth = Provider.of<LoginView>(context, listen: false);
                final message = await auth.register(
                  _userController.text, 
                  _passController.text
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                  // Kembali ke halaman login setelah register
                  Navigator.pop(context); 
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green, // Pembeda warna
              ),
              child: const Text("REGISTER"),
            ),
          ],
        ),
      ),
    );
  }
}