import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class SortMatchGame extends StatefulWidget {
  final Map<String, dynamic> game;
  const SortMatchGame({Key? key, required this.game}) : super(key: key);

  @override
  State<SortMatchGame> createState() => _SortMatchGameState();
}

class _SortMatchGameState extends State<SortMatchGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentLevel = 0;
  int score = 0;
  bool gameCompleted = false;
  String feedbackMessage = "";
  bool showFeedback = false;
  bool isCorrectFeedback = false;

  List<Map<String, dynamic>> levels = [
    {
      "target": {"text": "Red", "icon": "🔴", "color": Colors.red},
      "options": [
        {"text": "Red", "icon": "🔴", "color": Colors.red},
        {"text": "Blue", "icon": "🔵", "color": Colors.blue},
        {"text": "Green", "icon": "🟢", "color": Colors.green},
      ],
    },
    {
      "target": {"text": "Blue", "icon": "🔵", "color": Colors.blue},
      "options": [
        {"text": "Yellow", "icon": "🟡", "color": Colors.yellow},
        {"text": "Blue", "icon": "🔵", "color": Colors.blue},
        {"text": "Red", "icon": "🔴", "color": Colors.red},
      ],
    },
    {
      "target": {"text": "Circle", "icon": "⚪", "color": Colors.purple},
      "options": [
        {"text": "Circle", "icon": "⚪", "color": Colors.purple},
        {"text": "Square", "icon": "🟩", "color": Colors.green},
        {"text": "Triangle", "icon": "🔺", "color": Colors.orange},
      ],
    },
    {
      "target": {"text": "Dog", "icon": "🐶", "color": Colors.brown},
      "options": [
        {"text": "Cat", "icon": "🐱", "color": Colors.grey},
        {"text": "Dog", "icon": "🐶", "color": Colors.brown},
        {"text": "Bird", "icon": "🐦", "color": Colors.blue},
      ],
    },
    {
      "target": {"text": "Car", "icon": "🚗", "color": Colors.redAccent},
      "options": [
        {"text": "Car", "icon": "🚗", "color": Colors.redAccent},
        {"text": "Bike", "icon": "🚲", "color": Colors.orange},
        {"text": "Plane", "icon": "✈️", "color": Colors.blue},
      ],
    },
  ];

  int get totalLevels => levels.length;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound(String sound) {
    try {
      _audioPlayer.play(AssetSource('audio/$sound.mp3'));
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  void _checkAnswer(String selectedText) {
    if (showFeedback) return; 

    final targetText = levels[currentLevel]["target"]["text"];
    bool isCorrect = selectedText == targetText;

    if (isCorrect) {
      _playSound('correct');
      setState(() {
        score++;
        feedbackMessage = "✅ Great job! That's correct! ✅";
        isCorrectFeedback = true;
        showFeedback = true;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          showFeedback = false;
          if (currentLevel + 1 < totalLevels) {
            currentLevel++;
          } else {
            gameCompleted = true;
          }
        });
      });
    } else {
      _playSound('wrong');
      setState(() {
        feedbackMessage = "❌ Oops! Try again! ❌";
        isCorrectFeedback = false;
        showFeedback = true;
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) setState(() => showFeedback = false);
      });
    }
  }

  void _resetGame() {
    setState(() {
      currentLevel = 0;
      score = 0;
      gameCompleted = false;
      showFeedback = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    if (gameCompleted) {
      return _buildCompletionScreen(sw, sh);
    }

    final level = levels[currentLevel];
    final target = level["target"];
    final options = List<Map<String, dynamic>>.from(level["options"]);
    final progress = (currentLevel + 1) / totalLevels;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFDAB9), Color(0xFFFFB6C1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button and score
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.02),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.brown, size: 22),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 28),
                        SizedBox(width: sw * 0.02),
                        Text(
                          "$score / $totalLevels",
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Progress bar
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                child: Column(
                  children: [
                    Text(
                      "Level ${currentLevel + 1} of $totalLevels",
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sh * 0.05),

              // Target Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: sw * 0.1),
                padding: EdgeInsets.all(sw * 0.06),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9C4), Color(0xFFFFF59D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: const Offset(0, 6))],
                ),
                child: Column(
                  children: [
                    Text(
                      "Find the match!",
                      style: TextStyle(fontSize: sw * 0.05, fontWeight: FontWeight.bold, color: Colors.brown.shade800),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          target["icon"],
                          style: TextStyle(fontSize: sw * 0.12, shadows: const [Shadow(color: Colors.black26, blurRadius: 4)]),
                        ),
                        SizedBox(width: sw * 0.03),
                        Text(
                          target["text"],
                          style: TextStyle(
                            fontSize: sw * 0.07,
                            fontWeight: FontWeight.w900,
                            color: target["color"],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: sh * 0.04),

              // Feedback message
              if (showFeedback)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sw * 0.05),
                    padding: EdgeInsets.symmetric(vertical: sh * 0.01, horizontal: sw * 0.04),
                    decoration: BoxDecoration(
                      color: isCorrectFeedback ? Colors.green.shade800 : Colors.red.shade800,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      feedbackMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

              const Spacer(),

              // Options grid
              Padding(
                padding: EdgeInsets.all(sw * 0.05),
                child: Wrap(
                  spacing: sw * 0.04,
                  runSpacing: sh * 0.02,
                  alignment: WrapAlignment.center,
                  children: options.map((option) {
                    return Material(
                      elevation: 6,
                      borderRadius: BorderRadius.circular(50),
                      child: InkWell(
                        onTap: showFeedback ? null : () => _checkAnswer(option["text"]),
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          width: sw * 0.35,
                          padding: EdgeInsets.symmetric(vertical: sh * 0.02),
                          decoration: BoxDecoration(
                            color: option["color"],
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                          ),
                          child: Column(
                            children: [
                              Text(option["icon"], style: TextStyle(fontSize: sw * 0.08)),
                              const SizedBox(height: 6),
                              Text(
                                option["text"],
                                style: TextStyle(
                                  fontSize: sw * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: sh * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionScreen(double sw, double sh) {
    // Play congrats sound when screen appears
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playSound('correct'); // or fanfare if you have
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF43A047), Color(0xFF1B5E20)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🏆 You're a Champion! 🏆",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: sh * 0.02),
              Text(
                "You scored $score out of $totalLevels",
                style: const TextStyle(fontSize: 24, color: Colors.white70),
              ),
              SizedBox(height: sh * 0.04),
              ElevatedButton(
                onPressed: _resetGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green.shade800,
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.08, vertical: sh * 0.02),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
                child: const Text("Play Again", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: sh * 0.02),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Back to Games", style: TextStyle(color: Colors.white70, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}