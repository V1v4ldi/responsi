import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsi/controller/login_controller.dart';
import 'package:responsi/view/navigation.dart';
import 'package:responsi/view/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.rocket_launch, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            
            TextField(
              controller: _userController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            
            TextField(
              controller: _passController,
              obscureText: true, // Sembunyikan password
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            
            ElevatedButton(
              onPressed: () async {
                final auth = Provider.of<LoginView>(context, listen: false);
                final message = await auth.login(
                  _userController.text, 
                  _passController.text
                );

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(message)),
                  );
                  
                  if (message == "Berhasil Login") { 
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Navigation()),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("LOGIN"),
            ),
            
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Register()),
                );
              },
              child: const Text("Belum punya akun? Register"),
            )
          ],
        ),
      ),
    );
  }
}