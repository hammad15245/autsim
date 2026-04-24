import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class EmotionDetectiveGame extends StatefulWidget {
  final Map<String, dynamic> game;
  const EmotionDetectiveGame({Key? key, required this.game}) : super(key: key);

  @override
  State<EmotionDetectiveGame> createState() => _EmotionDetectiveGameState();
}

class _EmotionDetectiveGameState extends State<EmotionDetectiveGame>
    with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int currentIndex = 0;
  int score = 0;
  bool gameCompleted = false;
  bool showFeedback = false;
  bool feedbackIsCorrect = false;
  String feedbackMessage = "";

  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      "emotion": "Happy",
      "emoji": "😊",
      "scenario": "The boy got a new toy! He feels...",
      "options": ["Happy", "Sad", "Angry"],
      "correct": "Happy",
      "color": Colors.amber.shade400
    },
    {
      "emotion": "Sad",
      "emoji": "😢",
      "scenario": "Her best friend moved away. She feels...",
      "options": ["Happy", "Sad", "Scared"],
      "correct": "Sad",
      "color": Colors.blue.shade300
    },
    {
      "emotion": "Angry",
      "emoji": "😠",
      "scenario": "Someone took his snack without asking. He feels...",
      "options": ["Happy", "Angry", "Scared"],
      "correct": "Angry",
      "color": Colors.red.shade400
    },
    {
      "emotion": "Scared",
      "emoji": "😨",
      "scenario": "He heard a loud noise at night. He feels...",
      "options": ["Happy", "Angry", "Scared"],
      "correct": "Scared",
      "color": Colors.purple.shade400
    },
    {
      "emotion": "Surprised",
      "emoji": "😲",
      "scenario": "Wow! A rainbow appeared! He feels...",
      "options": ["Sad", "Angry", "Surprised"],
      "correct": "Surprised",
      "color": Colors.orange.shade400
    },
    {
      "emotion": "Calm",
      "emoji": "😌",
      "scenario": "He is breathing slowly and feels peaceful. He feels...",
      "options": ["Calm", "Angry", "Scared"],
      "correct": "Calm",
      "color": Colors.teal.shade400
    },
    {
      "emotion": "Excited",
      "emoji": "🤩",
      "scenario": "Tomorrow is his birthday party! He feels...",
      "options": ["Sad", "Excited", "Scared"],
      "correct": "Excited",
      "color": Colors.pink.shade400
    },
    {
      "emotion": "Tired",
      "emoji": "😴",
      "scenario": "He played all day and now wants to sleep. He feels...",
      "options": ["Happy", "Tired", "Angry"],
      "correct": "Tired",
      "color": Colors.grey.shade500
    },
  ];

  int get totalQuestions => questions.length;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticOut),
    );
    // Trigger bounce when first load
    WidgetsBinding.instance.addPostFrameCallback((_) => _bounceController.forward());
  }

  @override
  void dispose() {
    _bounceController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playSound(String soundName) {
    try {
      _audioPlayer.play(AssetSource('audio/$soundName.mp3'));
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  void _onOptionTap(String selectedOption) {
    if (showFeedback) return; // already waiting

    _playSound('pop'); // button tap sound

    final currentQ = questions[currentIndex];
    final isCorrect = selectedOption == currentQ["correct"];

    if (isCorrect) {
      _playSound('correct');
      setState(() {
        score++;
        showFeedback = true;
        feedbackIsCorrect = true;
        feedbackMessage = "✓ Great job! ${currentQ["correct"]} is right!";
      });
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (mounted) {
          setState(() {
            showFeedback = false;
            if (currentIndex + 1 < totalQuestions) {
              currentIndex++;
              // Animate new emoji
              _bounceController.reset();
              _bounceController.forward();
            } else {
              gameCompleted = true;
            }
          });
        }
      });
    } else {
      _playSound('wrong');
      setState(() {
        showFeedback = true;
        feedbackIsCorrect = false;
        feedbackMessage = "🤔 Oops! That's not correct. Try again!";
      });
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) setState(() => showFeedback = false);
      });
    }
  }

  void _resetGame() {
    setState(() {
      currentIndex = 0;
      score = 0;
      gameCompleted = false;
      showFeedback = false;
    });
    _bounceController.reset();
    _bounceController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    if (gameCompleted) {
      return _buildCompletionScreen(sw, sh);
    }

    final currentQ = questions[currentIndex];
    final progress = (currentIndex + 1) / totalQuestions;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA), Color(0xFFAB47BC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.02),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 24),
                        SizedBox(width: sw * 0.02),
                        Text(
                          "$score / $totalQuestions",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question ${currentIndex + 1} of $totalQuestions",
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: sh * 0.04),

              // Animated emoji container
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: sw * 0.05),
                  padding: EdgeInsets.all(sw * 0.05),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bouncing emoji
                      ScaleTransition(
                        scale: _bounceAnimation,
                        child: Text(
                          currentQ["emoji"],
                          style: TextStyle(fontSize: sw * 0.25, shadows: const [Shadow(blurRadius: 8, color: Colors.black26)]),
                        ),
                      ),
                      SizedBox(height: sh * 0.02),
                      // Scenario text
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.01),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          currentQ["scenario"],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: sw * 0.045,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Feedback message
              if (showFeedback)
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  opacity: 1.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: sw * 0.05, vertical: sh * 0.01),
                    padding: EdgeInsets.symmetric(vertical: sh * 0.01, horizontal: sw * 0.04),
                    decoration: BoxDecoration(
                      color: feedbackIsCorrect ? Colors.green.shade700 : Colors.red.shade700,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Text(
                      feedbackMessage,
                      style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

              // Emotion buttons
              Padding(
                padding: EdgeInsets.all(sw * 0.05),
                child: Wrap(
                  spacing: sw * 0.03,
                  runSpacing: sh * 0.015,
                  alignment: WrapAlignment.center,
                  children: currentQ["options"].map<Widget>((option) {
                    return Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(40),
                      child: InkWell(
                        onTap: showFeedback ? null : () => _onOptionTap(option),
                        borderRadius: BorderRadius.circular(40),
                        child: Container(
                          width: sw * 0.25,
                          padding: EdgeInsets.symmetric(vertical: sh * 0.018),
                          decoration: BoxDecoration(
                            color: showFeedback ? Colors.grey : _getEmotionColor(option),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: sh * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Color _getEmotionColor(String emotion) {
    switch (emotion) {
      case "Happy": return Colors.amber.shade600;
      case "Sad": return Colors.blue.shade600;
      case "Angry": return Colors.red.shade700;
      case "Scared": return Colors.purple.shade700;
      case "Surprised": return Colors.orange.shade600;
      case "Calm": return Colors.teal.shade600;
      case "Excited": return Colors.pink.shade600;
      case "Tired": return Colors.brown.shade500;
      default: return Colors.grey;
    }
  }

  Widget _buildCompletionScreen(double sw, double sh) {
    // Play a celebration sound
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playSound('correct');
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "🎉 Congratulations! 🎉",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: sh * 0.02),
              Text(
                "You scored $score out of $totalQuestions!",
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