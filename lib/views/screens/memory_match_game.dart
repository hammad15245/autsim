import 'package:flutter/material.dart';
import 'dart:math';

class MemoryCard {
  final String id;
  final Color color;
  final String colorName;
  final String emoji;
  bool isFaceUp;
  bool isMatched;

  MemoryCard({
    required this.id,
    required this.color,
    required this.colorName,
    required this.emoji,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}

class MemoryMatchGame extends StatefulWidget {
  final Map<String, dynamic> game;
  const MemoryMatchGame({Key? key, required this.game}) : super(key: key);

  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<MemoryCard> cards = [];
  MemoryCard? firstCard;
  MemoryCard? secondCard;
  bool isChecking = false;
  int matchedPairs = 0;
  int totalPairs = 4;
  bool gameCompleted = false;
  int currentDifficulty = 0; // 0=Easy, 1=Medium, 2=Hard
  int moveCount = 0;

  final List<Map<String, dynamic>> allColors = [
    {"color": const Color(0xFFE57373), "name": "Red", "emoji": "🍎"},
    {"color": const Color(0xFF64B5F6), "name": "Blue", "emoji": "🐟"},
    {"color": const Color(0xFF81C784), "name": "Green", "emoji": "🐸"},
    {"color": const Color(0xFFFFD54F), "name": "Yellow", "emoji": "⭐"},
    {"color": const Color(0xFFFF8A65), "name": "Orange", "emoji": "🍊"},
    {"color": const Color(0xFFCE93D8), "name": "Purple", "emoji": "🦄"},
    {"color": const Color(0xFF80CBC4), "name": "Teal", "emoji": "🐬"},
    {"color": const Color(0xFFF48FB1), "name": "Pink", "emoji": "🌸"},
  ];

  final List<Map<String, dynamic>> difficulties = [
    {"label": "Easy", "pairs": 4, "cols": 4, "color": const Color(0xFF4CAF50)},
    {"label": "Medium", "pairs": 6, "cols": 4, "color": const Color(0xFFFF9800)},
    {"label": "Hard", "pairs": 8, "cols": 4, "color": const Color(0xFFF44336)},
  ];

  @override
  void initState() {
    super.initState();
    _startGame(0);
  }

  void _startGame(int difficultyIndex) {
    final diff = difficulties[difficultyIndex];
    final int pairs = diff["pairs"];

    // Pick random colors (enough for the pairs)
    final shuffled = List.of(allColors)..shuffle(Random());
    final selected = shuffled.take(pairs).toList();

    List<MemoryCard> newCards = [];
    for (int i = 0; i < pairs; i++) {
      newCards.add(MemoryCard(
        id: '${i}_a',
        color: selected[i]["color"],
        colorName: selected[i]["name"],
        emoji: selected[i]["emoji"],
      ));
      newCards.add(MemoryCard(
        id: '${i}_b',
        color: selected[i]["color"],
        colorName: selected[i]["name"],
        emoji: selected[i]["emoji"],
      ));
    }
    newCards.shuffle(Random());

    setState(() {
      currentDifficulty = difficultyIndex;
      totalPairs = pairs;
      matchedPairs = 0;
      moveCount = 0;
      gameCompleted = false;
      firstCard = null;
      secondCard = null;
      isChecking = false;
      cards = newCards;
    });
  }

  void _onCardTap(MemoryCard card) {
    if (isChecking || card.isMatched || card.isFaceUp) return;

    setState(() {
      card.isFaceUp = true;
      if (firstCard == null) {
        firstCard = card;
      } else {
        secondCard = card;
        moveCount++;
        _checkMatch();
      }
    });
  }

  Future<void> _checkMatch() async {
    isChecking = true;
    await Future.delayed(const Duration(milliseconds: 600));

    if (firstCard!.color.value == secondCard!.color.value) {
      setState(() {
        firstCard!.isMatched = true;
        secondCard!.isMatched = true;
        matchedPairs++;
      });
      if (matchedPairs == totalPairs) {
        setState(() => gameCompleted = true);
      }
    } else {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        firstCard!.isFaceUp = false;
        secondCard!.isFaceUp = false;
      });
    }

    setState(() {
      firstCard = null;
      secondCard = null;
      isChecking = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    final diff = difficulties[currentDifficulty];
    final int cols = diff["cols"];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2E5E4F), Color(0xFF1B3B2F)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header with back button, title, and restart
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.02),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text(
                          'Memory Match',
                          style: TextStyle(
                            fontSize: sw * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          diff["label"],
                          style: TextStyle(
                            fontSize: sw * 0.035,
                            color: diff["color"],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => _startGame(currentDifficulty),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.refresh, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ),

              // Stats: Pairs left & Moves
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _infoChip(sw, '🎯', '${matchedPairs}/$totalPairs'),
                    _infoChip(sw, '👆', '${moveCount}moves'),
                  ],
                ),
              ),

              SizedBox(height: sh * 0.02),

              // Difficulty selector
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sw * 0.05),
                child: Row(
                  children: List.generate(difficulties.length, (i) {
                    final d = difficulties[i];
                    final isSelected = i == currentDifficulty;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => _startGame(i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: sw * 0.01),
                          padding: EdgeInsets.symmetric(vertical: sh * 0.01),
                          decoration: BoxDecoration(
                            color: isSelected ? d["color"] : Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              d["label"],
                              style: TextStyle(
                                fontSize: sw * 0.035,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: sh * 0.02),

              // Game grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sw * 0.04),
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: cards.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: sw * 0.025,
                      mainAxisSpacing: sh * 0.012,
                      childAspectRatio: cols == 4 ? 0.85 : 0.8,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _onCardTap(cards[index]),
                        child: _buildCard(cards[index], sw),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: sh * 0.02),
            ],
          ),
        ),
      ),

      // Completion message (simple popup)
      bottomSheet: gameCompleted
          ? Container(
              height: sh * 0.28,
              padding: EdgeInsets.all(sw * 0.05),
              decoration: BoxDecoration(
                color: const Color(0xFF2E5E4F),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                children: [
                  const Text('🎉 You Won! 🎉', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: sh * 0.01),
                  Text('Matched all $totalPairs pairs in $moveCount moves.', style: TextStyle(fontSize: 16, color: Colors.white70)),
                  SizedBox(height: sh * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () => _startGame(currentDifficulty),
                        style: ElevatedButton.styleFrom(backgroundColor: diff["color"], foregroundColor: Colors.white),
                        child: const Text('Play Again'),
                      ),
                      SizedBox(width: sw * 0.03),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white.withOpacity(0.2), foregroundColor: Colors.white),
                        child: const Text('Exit'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : null,
    );
  }

  Widget _infoChip(double sw, String icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sw * 0.02),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(icon, style: TextStyle(fontSize: sw * 0.045)),
          SizedBox(width: sw * 0.02),
          Text(text, style: TextStyle(fontSize: sw * 0.04, fontWeight: FontWeight.w600, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildCard(MemoryCard card, double sw) {
    final bool revealed = card.isFaceUp || card.isMatched;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: revealed ? card.color : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: revealed ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          if (revealed)
            BoxShadow(
              color: card.color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Center(
        child: revealed
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(card.emoji, style: TextStyle(fontSize: sw * 0.08)),
                  const SizedBox(height: 6),
                  Text(
                    card.colorName,
                    style: TextStyle(
                      fontSize: sw * 0.03,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            : Icon(
                Icons.question_mark,
                color: Colors.white.withOpacity(0.5),
                size: sw * 0.08,
              ),
      ),
    );
  }
}