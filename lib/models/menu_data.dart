import 'package:flutter/material.dart'; 
import '../menu/calculate.dart';
import '../menu/stopwatch.dart';
import '../menu/hitungpiramid.dart';
import '../menu/inputbilangan.dart';

class MenuModel {
  int id;
  String name;
  IconData icon;
  String desc;
  Widget page;

  MenuModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.desc,
    required this.page,
  });
}

final List<MenuModel> menuList = [
    MenuModel(
      id: 0,
      name: "Penjumlahan Pengurangan",
      icon:
          Icons.calculate,
      desc:
          "Melakukan operasi hitung penjumlahan dan pengurangan dari dua angka yang diinputkan pengguna.",
      page: Calculate()
    ),
    MenuModel(
      id: 1,
      name: "Input Bilangan Ganjil Genap dan Prima",
      icon:
          Icons.looks_3,
      desc:
          "Mendeteksi apakah bilangan yang diinputkan termasuk bilangan ganjil atau genap dan prima atau bukan.",
      page: InputBilangan()
    ),
    MenuModel(
      id: 2,
      name: "Stopwatch",
      icon:
          Icons.timer,
      desc:
          "Menjalankan, menghentikan, dan mereset stopwatch sebagai penghitung waktu.",
      page: StopWatch()
    ),
    MenuModel(
      id: 3,
      name: "Hitung Luas dan Volume Piramid",
      icon:
          Icons.change_history,
      desc:
          "Menghitung luas permukaan dan volume piramid berdasarkan alas dan tinggi yang diinputkan pengguna.",
      page: HitungPiramid()
    ),
];
