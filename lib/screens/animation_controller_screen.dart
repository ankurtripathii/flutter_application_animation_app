import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationControllerScreen extends StatefulWidget {
  const AnimationControllerScreen({super.key});

  @override
  State<AnimationControllerScreen> createState() =>
      _AnimationControllerScreenState();
}

class _AnimationControllerScreenState extends State<AnimationControllerScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotateController;
  late AnimationController _scaleController;
  late AnimationController _bounceController;

  late Animation<double> _rotateAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _bounceAnim;

  bool _isRotating = false;
  bool _isScaling = false;
  bool _isBouncing = false;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _rotateAnim = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.linear),
    );

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _bounceAnim = Tween<double>(begin: 0, end: -80).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.bounceOut),
    );
  }

  @override
  void dispose() {
    _rotateController.dispose();
    _scaleController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _toggleRotate() {
    setState(() => _isRotating = !_isRotating);
    if (_isRotating) {
      _rotateController.repeat();
    } else {
      _rotateController.stop();
      _rotateController.reset();
    }
  }

  void _toggleScale() {
    setState(() => _isScaling = !_isScaling);
    if (_isScaling) {
      _scaleController.forward();
    } else {
      _scaleController.reverse();
    }
  }

  void _triggerBounce() {
    _bounceController.reset();
    setState(() => _isBouncing = true);
    _bounceController.forward().then((_) {
      setState(() => _isBouncing = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text('AnimationController',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Three independent animation controllers',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 24),

            // Rotation
            _buildAnimCard(
              title: '1. Rotation',
              subtitle: 'Continuous 360° loop using repeat()',
              color: Colors.deepPurple,
              child: AnimatedBuilder(
                animation: _rotateAnim,
                builder: (_, child) => Transform.rotate(
                  angle: _rotateAnim.value,
                  child: child,
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.deepPurple, Colors.purpleAccent],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.star, color: Colors.white, size: 36),
                ),
              ),
              buttonLabel: _isRotating ? 'Stop' : 'Rotate',
              onTap: _toggleRotate,
              isActive: _isRotating,
              activeColor: Colors.deepPurple,
            ),

            const SizedBox(height: 16),

            // Scale
            _buildAnimCard(
              title: '2. Scale (Elastic)',
              subtitle: 'Grows with elasticOut curve',
              color: Colors.orange,
              child: AnimatedBuilder(
                animation: _scaleAnim,
                builder: (_, child) => Transform.scale(
                  scale: _scaleAnim.value,
                  child: child,
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.orange, Colors.deepOrange],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.flash_on, color: Colors.white, size: 36),
                ),
              ),
              buttonLabel: _isScaling ? 'Shrink' : 'Scale',
              onTap: _toggleScale,
              isActive: _isScaling,
              activeColor: Colors.orange,
            ),

            const SizedBox(height: 16),

            // Bounce
            _buildAnimCard(
              title: '3. Bounce',
              subtitle: 'Jump up using bounceOut curve',
              color: Colors.green[700]!,
              child: AnimatedBuilder(
                animation: _bounceAnim,
                builder: (_, child) => Transform.translate(
                  offset: Offset(0, _bounceAnim.value),
                  child: child,
                ),
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.green[600]!, Colors.teal],
                    ),
                    borderRadius: BorderRadius.circular(35),
                  ),
                  child: const Icon(Icons.sports_basketball,
                      color: Colors.white, size: 36),
                ),
              ),
              buttonLabel: 'Bounce!',
              onTap: _triggerBounce,
              isActive: _isBouncing,
              activeColor: Colors.green[700]!,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimCard({
    required String title,
    required String subtitle,
    required Color color,
    required Widget child,
    required String buttonLabel,
    required VoidCallback onTap,
    required bool isActive,
    required Color activeColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
            color: isActive ? color.withOpacity(0.4) : Colors.transparent,
            width: 1.5),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Center(child: child),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87)),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.black45, height: 1.4)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isActive ? activeColor : Colors.grey[100],
                    foregroundColor:
                        isActive ? Colors.white : Colors.black87,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 0,
                  ),
                  child: Text(buttonLabel,
                      style: const TextStyle(fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
