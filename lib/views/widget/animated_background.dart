import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class AnimatedKidsBackground extends StatelessWidget {
  const AnimatedKidsBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const _GradientBackground(),
        const _FloatingShapes(),
      ],
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFB3E5FC), // light sky blue
            Color(0xFFC8E6C9), // soft green
            Color(0xFFFFF9C4), // pastel yellow
          ],
        ),
      ),
    );
  }
}

class _FloatingShapes extends StatefulWidget {
  const _FloatingShapes();

  @override
  State<_FloatingShapes> createState() => _FloatingShapesState();
}

class _FloatingShapesState extends State<_FloatingShapes> {
  final random = Random();
  final List<_ShapeData> shapesData = [];

  static final _colors = [
    Colors.white54,
    Colors.pinkAccent.withOpacity(0.4),
    Colors.yellowAccent.withOpacity(0.4),
    Colors.lightBlueAccent.withOpacity(0.4),
    Colors.purpleAccent.withOpacity(0.4),
    Colors.greenAccent.withOpacity(0.4),
    Colors.orangeAccent.withOpacity(0.4),
  ];

  static final _shapes = [
    Icons.circle,
    Icons.star,
    Icons.favorite,
    Icons.favorite_border,
    Icons.tag_faces,
    Icons.catching_pokemon, // fun pokeball style
    Icons.ac_unit, // snowflake
    Icons.bubble_chart,
    Icons.lightbulb_outline,
    Icons.cloud,
    Icons.pets, // paw print
    Icons.sunny,
    Icons.auto_awesome, // sparkles
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 25; i++) { // increased shape count
      shapesData.add(
        _ShapeData(
          size: 20 + random.nextDouble() * 40,
          dx: random.nextDouble(),
          startDy: random.nextDouble(),
          speed: 12 + random.nextDouble() * 10, // slower speeds
          phase: random.nextDouble(),
          directionUp: random.nextBool(), // random up or down
          icon: _shapes[random.nextInt(_shapes.length)],
          color: _colors[random.nextInt(_colors.length)],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: shapesData.map((shape) {
        return LoopAnimationBuilder<double>(
          duration: Duration(seconds: shape.speed.toInt()),
          tween: Tween(begin: 0, end: 1),
          curve: Curves.linear,
          builder: (context, value, child) {
            double adjustedValue = (value + shape.phase) % 1.0;

            final dx = shape.dx * screenWidth;
            final dy = shape.directionUp
                ? (1 - adjustedValue) * (screenHeight + 200) - 200 // up
                : adjustedValue * (screenHeight + 200) - 200; // down

            return Positioned(
              left: dx,
              top: dy,
              child: Icon(
                shape.icon,
                size: shape.size,
                color: shape.color,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class _ShapeData {
  final double size;
  final double dx;
  final double startDy;
  final double speed;
  final double phase;
  final bool directionUp;
  final IconData icon;
  final Color color;

  _ShapeData({
    required this.size,
    required this.dx,
    required this.startDy,
    required this.speed,
    required this.phase,
    required this.directionUp,
    required this.icon,
    required this.color,
  });
}
