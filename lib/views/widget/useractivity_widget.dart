import 'package:flutter/material.dart';

class _ActivityCircle extends StatelessWidget {
  final String label;
  final double percentage;
  final String value;
  final double screenWidth;

  const _ActivityCircle({
    required this.label,
    required this.percentage,
    required this.value,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate circle size based on screen width
    final circleSize = screenWidth * 0.25;
    
    return Column(
      children: [
        SizedBox(
          width: circleSize,
          height: circleSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background circle
              Container(
                width: circleSize,
                height: circleSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
              ),
              // Progress circle
              SizedBox(
                width: circleSize,
                height: circleSize,
                child: CircularProgressIndicator(
                  value: percentage,
                  strokeWidth: 8,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getCircleColor(percentage),
                  ),
                ),
              ),
              // Center text
              Text(
                value,
                style: TextStyle(
                  fontSize: circleSize * 0.2,
                  fontWeight: FontWeight.bold,
                  color: _getTextColor(percentage),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper method to determine circle color based on percentage
  Color _getCircleColor(double percentage) {
    if (percentage >= 0.75) return Colors.green;
    if (percentage >= 0.5) return Colors.blue;
    return Colors.orange;
  }

  // Helper method to determine text color based on percentage
  Color _getTextColor(double percentage) {
    if (percentage >= 0.75) return Colors.green;
    if (percentage >= 0.5) return Colors.blue;
    return Colors.orange;
  }
}