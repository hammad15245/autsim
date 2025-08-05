import 'package:flutter/material.dart';

class BrushingTeethController extends ChangeNotifier {
  final int totalLevels;
  int completedLevels = 0;
  static final BrushingTeethController instance = BrushingTeethController();
  final ValueNotifier<int> currentRating = ValueNotifier<int>(0);

  BrushingTeethController({this.totalLevels = 5});

  void completeLevel() {
    if (completedLevels < totalLevels) {
      completedLevels++;
      notifyListeners();
    }
  }

  void resetProgress() {
    completedLevels = 0;
    notifyListeners();
  }

  List<Widget> getStars({double size = 32.0}) {
    return List.generate(
      totalLevels,
      (index) => Icon(
        index < completedLevels ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: size,
      ),
    );
  }

  bool get isCompleted => completedLevels == totalLevels;
}
class BrushingTeethQuiz extends StatefulWidget {
  final List<String> options;
  final String correctAnswer;
  final void Function(String selected) onAnswered;

  const BrushingTeethQuiz({
    Key? key,
    required this.options,
    required this.correctAnswer,
    required this.onAnswered, required Null Function(dynamic isCorrect) onAnswerSelected,
  }) : super(key: key);

  @override
  _BrushingTeethQuizState createState() => _BrushingTeethQuizState();
}

class _BrushingTeethQuizState extends State<BrushingTeethQuiz> {
  String? _selectedAnswer;

  void _handleTap(String selected) {
    if (_selectedAnswer != null) return;

    setState(() {
      _selectedAnswer = selected;
    });

    widget.onAnswered(selected);

    Future.delayed(const Duration(milliseconds: 300), () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(selected == widget.correctAnswer ? 'Congratulations!' : 'Try Again'),
          content: Text(selected == widget.correctAnswer
              ? 'You selected the correct answer.'
              : 'That was not the correct answer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.0, // makes buttons square
      padding: const EdgeInsets.all(12),
      children: widget.options.map((option) {
        final bool isSelected = _selectedAnswer != null && _selectedAnswer == option;
        final bool isCorrect = isSelected && option == widget.correctAnswer;
        final bool isWrong = isSelected && option != widget.correctAnswer;

        return ElevatedButton(
          onPressed: _selectedAnswer == null ? () => _handleTap(option) : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isCorrect
                ? Colors.green
                : isWrong
                    ? Colors.red
                    : Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            option,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      }).toList(),
    );
  }
}

