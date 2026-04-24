import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TwinkleScreen extends StatefulWidget {
  final Map<String, dynamic> poem;
  const TwinkleScreen({Key? key, required this.poem}) : super(key: key);

  @override
  State<TwinkleScreen> createState() => _TwinkleScreenState();
}

class _TwinkleScreenState extends State<TwinkleScreen> {
  final AudioPlayer _player = AudioPlayer();
  final RxInt currentLineIndex = (-1).obs;
  final RxBool isPlayingLocal = false.obs;

  final List<Duration> lineTimings = [
    Duration(seconds: 0), Duration(seconds: 3), Duration(seconds: 6),
    Duration(seconds: 9), Duration(seconds: 12), Duration(seconds: 15),
    Duration(seconds: 18), Duration(seconds: 21), Duration(seconds: 24),
    Duration(seconds: 27), Duration(seconds: 30), Duration(seconds: 33),
  ];

  final List<String> lyrics = [
    "Twinkle, twinkle, little star,",
    "How I wonder what you are!",
    "Up above the world so high,",
    "Like a diamond in the sky.",
    "Twinkle, twinkle, little star,",
    "How I wonder what you are!",
    "When the blazing sun is gone,",
    "When he nothing shines upon,",
    "Then you show your little light,",
    "Twinkle, twinkle, all the night.",
    "Twinkle, twinkle, little star,",
    "How I wonder what you are!",
  ];

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;

  @override
  void initState() {
    super.initState();
    // Do NOT call precacheImage here – it causes MediaQuery error.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache the background image after dependencies are ready
    precacheImage(const AssetImage('lib/assets/cloud_top.jpg'), context);
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _completeSub?.cancel();
    _player.dispose();
    super.dispose();
  }

  Future<void> playFromBeginning() async {
    stopAll();
    isPlayingLocal.value = true;
    try {
      await _player.play(AssetSource('audio/twinkle.mp3'));
      _positionSub = _player.onPositionChanged.listen((position) {
        if (!isPlayingLocal.value) return;
        for (int i = 0; i < lineTimings.length; i++) {
          if (i < lineTimings.length - 1) {
            if (position >= lineTimings[i] && position < lineTimings[i + 1]) {
              currentLineIndex.value = i;
              break;
            }
          } else {
            if (position >= lineTimings[i]) currentLineIndex.value = i;
          }
        }
      });
      _completeSub = _player.onPlayerComplete.listen((event) => stopAll());
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  void pauseAudio() {
    if (!isPlayingLocal.value) return;
    _player.pause();
    isPlayingLocal.value = false;
  }

  Future<void> resumeAudio() async {
    if (isPlayingLocal.value) return;
    await _player.resume();
    isPlayingLocal.value = true;
  }

  void stopAll() {
    isPlayingLocal.value = false;
    currentLineIndex.value = -1;
    _positionSub?.cancel();
    _completeSub?.cancel();
    _player.stop();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF29B6D8)),
          const TwinklingStars(),
          Positioned.fill(
            child: Image.asset(
              'lib/assets/cloud_top.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(w, h),
                _buildTitle(w, h, "TWINKLE TWINKLE LITTLE STAR"),
                _buildLyricsContainer(w, h, lyrics),
                _buildControls(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(double w, double h) => Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: h * 0.01),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              stopAll();
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white, size: 20),
            ),
          ),
        ]),
      );

  Widget _buildTitle(double w, double h, String title) => Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.01),
        child: Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: w * 0.07,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                shadows: [Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1,1))])),
      );

  Widget _buildLyricsContainer(double w, double h, List<String> lyrics) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: w * 0.06),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.95),
                const Color(0xFFE1F5FE).withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: h * 0.02,
                horizontal: w * 0.06,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: lyrics.asMap().entries.map((entry) {
                    int idx = entry.key;
                    String line = entry.value;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        line,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: w * 0.045,
                          color: const Color(0xFF1E3A5F),
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                          letterSpacing: 0.5,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControls() => Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: playFromBeginning,
              child: const Icon(Icons.replay, size: 40, color: Colors.white)),
          const SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              if (isPlayingLocal.value) {
                pauseAudio();
              } else {
                if (currentLineIndex.value != -1) {
                  resumeAudio();
                } else {
                  playFromBeginning();
                }
              }
            },
            child: Icon(isPlayingLocal.value ? Icons.pause : Icons.play_arrow,
                size: 50, color: Colors.white),
          ),
          const SizedBox(width: 30),
          GestureDetector(
              onTap: stopAll,
              child: const Icon(Icons.stop, size: 40, color: Colors.white)),
        ],
      ));
}

// Star animation (unchanged)
class TwinklingStars extends StatefulWidget {
  const TwinklingStars({super.key});
  @override
  State<TwinklingStars> createState() => _TwinklingStarsState();
}

class _TwinklingStarsState extends State<TwinklingStars> {
  final List<double> opacity = List.generate(25, (_) => 0.3);
  @override
  void initState() {
    super.initState();
    animate();
  }
  void animate() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 700));
      if (!mounted) return false;
      setState(() {
        for (int i = 0; i < opacity.length; i++) {
          opacity[i] = opacity[i] == 1 ? 0.3 : 1;
        }
      });
      return true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(opacity.length, (i) {
        return Positioned(
          top: (i * 35) % MediaQuery.of(context).size.height,
          left: (i * 50) % MediaQuery.of(context).size.width,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 700),
            opacity: opacity[i],
            child: const Icon(Icons.star, color: Colors.white, size: 14),
          ),
        );
      }),
    );
  }
}