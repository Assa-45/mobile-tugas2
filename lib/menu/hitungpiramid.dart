import 'package:flutter/material.dart';
import 'dart:math';

class HitungPiramid extends StatefulWidget {
  const HitungPiramid({super.key});

  @override
  State<HitungPiramid> createState() => _HitungPiramidState();
}

class _HitungPiramidState extends State<HitungPiramid> {
  TextEditingController alasController = TextEditingController();
  TextEditingController tinggiController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double luasPermukaan = 0;
  double volume = 0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F0FA),
      appBar: AppBar(
        title: Text("Kalkulator Piramid", style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color(0xFFBC66D6),
        iconTheme: IconThemeData(color: Colors.white)
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.network('https://images.pexels.com/photos/6256066/pexels-photo-6256066.jpeg', height: 150, width: double.infinity,fit: BoxFit.cover),
               SizedBox(height: 24),
              /// INPUT
              Row(
                children: [
                  Expanded(child: inputBox("ALAS (A) — CM", alasController)),
                  const SizedBox(width: 16),
                  Expanded(child: inputBox("TINGGI (T) — CM", tinggiController)),
                ],
              ),
              SizedBox(height: 24),
              /// HASIL
              Row(
                children: [
                  Expanded(
                    child: resultCard(
                      "Luas\nPermukaan",
                      luasPermukaan.toStringAsFixed(2),
                      "cm²",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: resultCard(
                      "Volume",
                      volume.toStringAsFixed(2),
                      "cm³",
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 24),
          
              /// RUMUS
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFE6E2F3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rumus yang digunakan",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "L = a² + 2a√(t²+(a/2)²)\nV = 1/3 x a² x t",
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // HITUNG PIRAMID
  void hitung() {
    double a = double.tryParse(alasController.text) ?? 0;
    double t = double.tryParse(tinggiController.text) ?? 0;

    double luas = a * a + 2 * a * (sqrt(t * t + (a / 2) * (a / 2)));
    double vol = (1 / 3) * a * a * t;

    setState(() {
      luasPermukaan = luas;
      volume = vol;
    });
  }

  /// INPUT BOX
  Widget inputBox(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
            letterSpacing: 1,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value){
            if(_formKey.currentState!.validate()){
              hitung();
            }
          },
          textAlign: TextAlign.center,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Input tidak boleh kosong';
            }

            if (double.tryParse(value) == null) {
              return 'Harus berupa angka';
            }

            return null;
          },
          style: const TextStyle(
            color: Colors.deepPurple,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.deepPurple.shade100, width: 1),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Colors.deepPurple,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// RESULT CARD
  Widget resultCard(String title, String value, String unit) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(unit, style: TextStyle(color: Colors.grey))
        ],
      ),
    );
  }
}