import 'package:flutter/material.dart';
import 'models/menu_data.dart';

class HomePage extends StatefulWidget {
  final String userValue;
  const HomePage({super.key, required this.userValue});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFBC66D6), Color(0xFF6C5CE7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white.withValues(alpha: 0.3),
                      child: Icon(Icons.person, color: Colors.white, size: 50)
                    ),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Selamat Datang Kembali,', style: TextStyle(fontSize: 18, color: Colors.white.withValues(alpha: 0.85))),
                        Text('${widget.userValue}!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        // Text('Aplikasi Pemrograman Mobile', style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.75))),
                      ],
                    ),
                  ],
                ),
              ]
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => menuList[index].page));
                  },
                  child: Container(
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.07),
                          blurRadius: 16,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(menuList[index].icon, size: 50, color: Colors.deepPurple),
                          Text(menuList[index].name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple), textAlign: TextAlign.center),
                          Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                            height: 24,        // jarak atas bawah garis
                            indent: 14,        // jarak dari kiri
                            endIndent: 14,     // jarak dari kanan
                          ),
                          Text(menuList[index].desc, style: TextStyle(fontSize: 12, color: Colors.deepPurple.withValues(alpha: 0.7)), textAlign: TextAlign.center),
                        ]
                      ),
                    )
                  ),
                );
              }
            )
          )
        ],
      ),
    );
  }
}