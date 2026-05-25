import 'package:flutter/material.dart';

class AnimatedOpacityScreen extends StatefulWidget {
  const AnimatedOpacityScreen({super.key});

  @override
  State<AnimatedOpacityScreen> createState() => _AnimatedOpacityScreenState();
}

class _AnimatedOpacityScreenState extends State<AnimatedOpacityScreen> {
  double _opacity1 = 1.0;
  double _opacity2 = 0.0;
  double _opacity3 = 0.0;
  bool _showAll = false;
  int _step = 0;

  final List<Map<String, dynamic>> _cards = [
    {
      'title': 'Design',
      'icon': Icons.palette_outlined,
      'color': Color(0xFF7C4DFF),
      'desc': 'Beautiful UI components'
    },
    {
      'title': 'Develop',
      'icon': Icons.code,
      'color': Color(0xFF00BCD4),
      'desc': 'Clean Flutter code'
    },
    {
      'title': 'Deploy',
      'icon': Icons.rocket_launch_outlined,
      'color': Color(0xFF4CAF50),
      'desc': 'Ship to production'
    },
  ];

  void _nextStep() {
    setState(() {
      _step++;
      if (_step == 1) _opacity2 = 1.0;
      if (_step == 2) _opacity3 = 1.0;
      if (_step >= 3) {
        _step = 0;
        _opacity1 = 0.0;
        _opacity2 = 0.0;
        _opacity3 = 0.0;
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() => _opacity1 = 1.0);
        });
      }
    });
  }

  double _getOpacity(int index) {
    if (index == 0) return _opacity1;
    if (index == 1) return _opacity2;
    return _opacity3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF00BCD4),
        title: const Text('AnimatedOpacity',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Cards fade in one by one',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Text(
              'Step ${_step == 0 ? 1 : _step} of 3',
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black45),
            ),
            const SizedBox(height: 30),
            ...List.generate(_cards.length, (i) {
              final card = _cards[i];
              return AnimatedOpacity(
                opacity: _getOpacity(i),
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeIn,
                child: AnimatedSlide(
                  offset: _getOpacity(i) == 0
                      ? const Offset(0, 0.3)
                      : Offset.zero,
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeOut,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                          color: (card['color'] as Color).withOpacity(0.2)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color:
                                (card['color'] as Color).withOpacity(0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(card['icon'] as IconData,
                              color: card['color'] as Color, size: 26),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(card['title'] as String,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                            Text(card['desc'] as String,
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.black45)),
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.check_circle,
                            color: (card['color'] as Color).withOpacity(
                                _getOpacity(i) > 0.5 ? 1.0 : 0.0),
                            size: 22),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _nextStep,
                icon: Icon(_step >= 2 ? Icons.refresh : Icons.arrow_forward),
                label: Text(_step >= 2 ? 'Reset' : 'Show next card'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00BCD4),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Uses AnimatedOpacity + AnimatedSlide\nfor a staggered fade-in effect',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.black38),
            ),
          ],
        ),
      ),
    );
  }
}
