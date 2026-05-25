import 'package:flutter/material.dart';
import 'screens/animated_container_screen.dart';
import 'screens/animated_opacity_screen.dart';
import 'screens/animation_controller_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _screens = [
    {
      'title': 'AnimatedContainer',
      'subtitle': 'Animate size, color & shape smoothly',
      'icon': Icons.crop_square_rounded,
      'color': Color(0xFF7C3AED),
      'tag': 'Screen 1',
      'screen': AnimatedContainerScreen(),
    },
    {
      'title': 'AnimatedOpacity',
      'subtitle': 'Fade elements in and out gracefully',
      'icon': Icons.blur_on,
      'color': Color(0xFF0891B2),
      'tag': 'Screen 2',
      'screen': AnimatedOpacityScreen(),
    },
    {
      'title': 'AnimationController',
      'subtitle': 'Rotate, scale & bounce with full control',
      'icon': Icons.animation,
      'color': Color(0xFF16A34A),
      'tag': 'Screen 3',
      'screen': AnimationControllerScreen(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                itemCount: _screens.length,
                itemBuilder: (context, i) => _buildCard(context, i),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF312E81)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('Flutter Animations',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ),
          const SizedBox(height: 10),
          const Text('Animation\nScreens',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2)),
          const SizedBox(height: 8),
          const Text(
              '3 screens, each with a unique animation technique',
              style: TextStyle(color: Colors.white60, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, int i) {
    final item = _screens[i];
    final color = item['color'] as Color;
    final screen = item['screen'] as Widget;

    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => screen)),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(item['icon'] as IconData,
                        color: Colors.white, size: 30),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(item['tag'] as String,
                              style: TextStyle(
                                  fontSize: 11,
                                  color: color,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 4),
                        Text(item['title'] as String,
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87)),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, size: 16, color: color),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(item['subtitle'] as String,
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            height: 1.4)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('Open',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500)),
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
