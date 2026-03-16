import 'package:flutter/material.dart';
import 'dart:async';

class StopWatch extends StatefulWidget {
  const StopWatch({super.key});

  @override
  State<StopWatch> createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  Timer? _timer;
  int _milliseconds = 0;
  bool _isRunning = false;
  List<int> _laps = [];

  void _toggleTimer() {
    if (_isRunning) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
        setState(() {
          _milliseconds++;
        });
      });
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
      _laps = [];
    });
  }

  void _addLap() {
    if (_isRunning) {
      setState(() {
        _laps.add(_milliseconds);
      });
    }
  }

  String _formatTime(int ms) {
    int seconds = ms ~/ 100;
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    int centiseconds = ms % 100;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
  }

  String _formatDisplay(int ms) {
    int seconds = ms ~/ 100;
    int minutes = seconds ~/ 60;
    int secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  String _formatMs(int ms) {
    return '.${(ms % 100).toString().padLeft(2, '0')}';
  }

  Color _getLapColor(int index) {
    if (_laps.isEmpty || _laps.length < 2) return Colors.black;
    int best = _laps.reduce((a, b) => a < b ? a : b);
    int worst = _laps.reduce((a, b) => a > b ? a : b);
    if (_laps[index] == best) return Colors.green;
    if (_laps[index] == worst) return Colors.red;
    return Colors.black;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch', style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color(0xFFBC66D6),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Color(0xFFF2F0FA),
      body: SafeArea(
        child: Column(
          children: [
            Divider(height: 1, color: Colors.grey.shade200),
            // Lingkaran jam
            Padding(
              padding: EdgeInsets.symmetric(vertical: 36),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF8B82E8),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8B82E8).withValues(alpha: 0.4),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _formatDisplay(_milliseconds),
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      _formatMs(_milliseconds),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Tombol kontrol
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Reset
                  GestureDetector(
                    onTap: _reset,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E1E1E),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(Icons.restart_alt, color: Colors.white, size: 32),
                    ),
                  ),

                  // Play / Pause
                  GestureDetector(
                    onTap: _toggleTimer,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFF6C5CE7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _isRunning ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ),

                  // Lap
                  GestureDetector(
                    onTap: _addLap,
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: Color(0xFFDCE8F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Lap',
                          style: TextStyle(
                            color: Color(0xFF185FA5),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Label lap
            Text(
              'Lap tercatat',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),

            SizedBox(height: 12),

            // List lap
            Expanded(
              child: _laps.isEmpty
                  ? Center(
                      child: Text(
                        'Belum ada lap',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _laps.length,
                      separatorBuilder: (_, _) => Divider(height: 1),
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: index == 0
                                ? BorderRadius.vertical(top: Radius.circular(12))
                                : index == _laps.length - 1
                                    ? BorderRadius.vertical(bottom: Radius.circular(12))
                                    : BorderRadius.zero,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Lap ${index + 1}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                _formatTime(_laps[index]),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: _getLapColor(index),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}