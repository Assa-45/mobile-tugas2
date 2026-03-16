import 'package:flutter/material.dart';

class InputBilangan extends StatefulWidget {
  const InputBilangan({super.key});

  @override
  State<InputBilangan> createState() => _InputBilanganState();
}

class _InputBilanganState extends State<InputBilangan> {
  final TextEditingController _controller = TextEditingController();
  bool _isChecked = false;
  bool _isGanjil = false;
  bool _isPrima = false;
  int _number = 0;

  bool _checkPrima(int n) {
    if (n < 2) return false;
    for (int i = 2; i <= n ~/ 2; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  void _cekBilangan() {
    final input = int.tryParse(_controller.text);
    if (input == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Masukkan angka yang valid!')),
      );
      return;
    }
    setState(() {
      _number = input;
      _isGanjil = input % 2 != 0;
      _isPrima = _checkPrima(input);
      _isChecked = true;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Bilangan", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color(0xFFBC66D6),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      backgroundColor: Color(0xFFF2F0FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24),
            child: Column(
              children: [
                SizedBox(height: 24),
                // Label input
                Text(
                  'Masukkan Bilangan',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10),
            
                // Input angka
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withValues(alpha: 0.3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Colors.deepPurple.shade300, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(color: Color(0xFF6C5CE7), width: 2),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 18),
                    ),
                  ),
                ),
                SizedBox(height: 20),
            
                // Tombol cek
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _cekBilangan,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF6C5CE7),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0,
                      ),
                      child: Text('Cek Bilangan', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),
            
                // Hasil (hanya muncul setelah tombol ditekan)
                if (_isChecked) ...[
                  SizedBox(height: 20),
            
                  // Badge hasil
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Badge ganjil/genap
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: _isGanjil ? Color(0xFFFFF3E8) : Color(0xFFE8F8F0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _isGanjil ? 'Bilangan Ganjil' : 'Bilangan Genap',
                              style: TextStyle(
                                color: _isGanjil ? Color(0xFFE07B00) : Color(0xFF0E8A4A),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
            
                        // Badge prima
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            color: _isPrima ? Color.fromARGB(255, 235, 229, 255) : Color(0xFFFFE8E8),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              _isPrima ? 'Bilangan Prima' : 'Bukan Prima',
                              style: TextStyle(
                                color: _isPrima ? Color(0xFF5341DE) : Color(0xFFCC3333),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 20),
            
                  // Card detail ganjil/genap
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // Card ganjil/genap
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFFF3E8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text('🔢', style: TextStyle(fontSize: 22)),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Ganjil / Genap',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _isGanjil ? 'Ganjil' : 'Genap',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _isGanjil ? Color(0xFFFFF3E8) : Color(0xFFE8F8F0),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _isGanjil ? 'Ganjil' : 'Genap',
                                  style: TextStyle(
                                    color: _isGanjil ? Color(0xFFE07B00) : Color(0xFF0E8A4A),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
            
                        SizedBox(height: 12),
            
                        // Card prima
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF0ECFF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text('✨', style: TextStyle(fontSize: 22)),
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Bilangan Prima',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      _isPrima ? 'Ya, bilangan prima' : 'Bukan bilangan prima',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: _isPrima ? Color(0xFFF0ECFF) : Color(0xFFFFE8E8),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  _isPrima ? 'Prima' : 'Bukan',
                                  style: TextStyle(
                                    color: _isPrima ? Color(0xFF6C5CE7) : Color(0xFFCC3333),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}