import 'package:flutter/material.dart';
import 'homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});


  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPasswordVisible = false;
  bool isLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign In", style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
                SizedBox(height: 12),
                Text("Hai, mohon Sign In dulu yaa", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey)),
                Text("Matkul Teknologi Pemrograman Mobile", style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.grey)),
                SizedBox(height: 30),
                TextFormField(
                  controller: _username,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Username tidak boleh kosong'; 
                    }
                    return null; 
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person, color: const Color(0xFFBC66D6),), 
                    labelText: 'Username', 
                    border: OutlineInputBorder()),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _password,
                  obscureText: !_isPasswordVisible,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock, color: const Color(0xFFBC66D6)), 
                    labelText: 'Password', 
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(onPressed: (){
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    }, icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: const Color(0xFFBC66D6)))),
                ),
                SizedBox(height: 15),
                ElevatedButton(onPressed: () {
                    String username = _username.text;
                    String password = _password.text;
                    if(_formKey.currentState!.validate()) {
                      if (username == 'Admin' && password == 'admin123') {
                        setState(() {
                          isLoggedIn = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Berhasil'), backgroundColor: Colors.green),
                        );
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage(userValue: _username.text)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Username/Password Salah'), backgroundColor: Colors.red),
                        );
                      }
                    }
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBC66D6),        
                  foregroundColor: Colors.white,    
                  minimumSize: Size(double.infinity, 50), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5), 
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
                ),
                child: Text('Sign In', style: TextStyle(fontSize: 18))),
                SizedBox(height: 40),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.purple, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text('Data Kelompok : \n1. Assasa Salma (123230160) \n2. Ni Luh Nitya Wijaya (123230116)', style: TextStyle(fontSize: 16, color: Colors.black87)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}