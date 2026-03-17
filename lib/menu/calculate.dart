import 'package:flutter/material.dart';

class Calculate extends StatefulWidget {
  const Calculate({super.key});

  @override
  State<Calculate> createState() => _CalculateState();
}

class _CalculateState extends State<Calculate> {
  final TextEditingController _num1 = TextEditingController(text: '25');
  final TextEditingController _num2 = TextEditingController(text: '18');
  final _formKey = GlobalKey<FormState>();
  bool _isPenjumlahan = true;


  double get _result {
    final a = double.tryParse(_num1.text) ?? 0;
    final b = double.tryParse(_num2.text) ?? 0;
    return _isPenjumlahan ? a + b : a - b;
  }

  String _formatResult(double val) {
    if (val == val.truncateToDouble()) {
      return val.toInt().toString();
    }
    return val.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _num1.dispose();
    _num2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalkulator Dasar", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color(0xFFBC66D6),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      backgroundColor: Color(0xFFF2F0FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Toggle Penjumlahan / Pengurangan
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E4F8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPenjumlahan = true),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: _isPenjumlahan ? Color(0xFF6C5CE7) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Penjumlahan',
                                  style: TextStyle(
                                    color: _isPenjumlahan ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _isPenjumlahan = false),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: !_isPenjumlahan ? Color(0xFF6C5CE7) : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'Pengurangan',
                                  style: TextStyle(
                                    color: !_isPenjumlahan ? Colors.white : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 28),

                  // Input row
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Input angka pertama
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ANGKA PERTAMA',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 6),
                              TextFormField(
                                controller: _num1,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (_) => setState(() {}),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Input tidak boleh kosong';
                                  }
                    
                                  if (double.tryParse(value) == null) {
                                    return 'Harus berupa angka';
                                  }
                    
                                  return null;
                                },
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withValues(alpha: 0.8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFF8273F6), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFF6C5CE7), width: 2),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                    
                        // Simbol operator
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 12, right: 12),
                          child: Text(
                            _isPenjumlahan ? '+' : '−',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C5CE7),
                            ),
                          ),
                        ),
                    
                        // Input angka kedua
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ANGKA KEDUA',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  letterSpacing: 0.5,
                                ),
                              ),
                              SizedBox(height: 6),
                              TextFormField(
                                controller: _num2,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onChanged: (_) => setState(() {}),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Input tidak boleh kosong';
                                  }
                    
                                  if (double.tryParse(value) == null) {
                                    return 'Harus berupa angka';
                                  }
                    
                                  return null;
                                },
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withValues(alpha: 0.8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFF8273F6), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Color(0xFF6C5CE7), width: 2),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  // Box hasil
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      color: Color(0xFF8B82E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Hasil',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          _formatResult(_result),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}