import 'package:flutter/material.dart';

class AnimatedContainerScreen extends StatefulWidget {
  const AnimatedContainerScreen({super.key});

  @override
  State<AnimatedContainerScreen> createState() =>
      _AnimatedContainerScreenState();
}

class _AnimatedContainerScreenState extends State<AnimatedContainerScreen> {
  double _width = 100;
  double _height = 100;
  Color _color = Colors.deepPurple;
  double _borderRadius = 12;
  double _padding = 16;
  bool _toggled = false;

  void _animate() {
    setState(() {
      _toggled = !_toggled;
      _width = _toggled ? 260 : 100;
      _height = _toggled ? 260 : 100;
      _color = _toggled ? Colors.orange : Colors.deepPurple;
      _borderRadius = _toggled ? 130 : 12;
      _padding = _toggled ? 40 : 16;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('AnimatedContainer',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Tap to animate shape, size & color',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _animate,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: _width,
                height: _height,
                padding: EdgeInsets.all(_padding),
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(_borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: _color.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const FittedBox(
                  child: Icon(Icons.star, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const Text('Properties animating:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 10),
            _buildPropertyRow(Icons.open_with, 'Size', '100px → 260px'),
            _buildPropertyRow(Icons.color_lens, 'Color', 'Purple → Orange'),
            _buildPropertyRow(
                Icons.rounded_corner, 'Border radius', 'Square → Circle'),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _animate,
              icon: const Icon(Icons.play_arrow),
              label: Text(_toggled ? 'Reset' : 'Animate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyRow(IconData icon, String prop, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(prop,
              style: const TextStyle(fontSize: 13, color: Colors.black54)),
          const SizedBox(width: 6),
          Text(value,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87)),
        ],
      ),
    );
  }
}
