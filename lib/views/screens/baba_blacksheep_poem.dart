import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaaBaaScreen extends StatefulWidget {
  final Map<String, dynamic> poem;
  const BaaBaaScreen({Key? key, required this.poem}) : super(key: key);
  
  @override
  State<BaaBaaScreen> createState() => _BaaBaaScreenState();
}

class _BaaBaaScreenState extends State<BaaBaaScreen> {
  final AudioPlayer _player = AudioPlayer();
  final RxInt currentLineIndex = (-1).obs;
  final RxBool isPlayingLocal = false.obs;

  final List<Duration> lineTimings = [
    Duration(seconds: 0), Duration(seconds: 2), Duration(seconds: 4),
    Duration(seconds: 6), Duration(seconds: 8), Duration(seconds: 10),
    Duration(seconds: 12),
  ];

  final List<String> lyrics = [
    "Baa baa black sheep, have you any wool?",
    "Yes sir, yes sir, three bags full!",
    "One for the master,",
    "One for the dame,",
    "And one for the little boy who lives down the lane.",
    "Baa baa black sheep, have you any wool?",
    "Yes sir, yes sir, three bags full!",
    "One for the master,",
    "One for the dame,",
    "And one for the little boy who lives down the lane.",
  ];

  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<void>? _completeSub;

  @override
  void initState() {
    super.initState();
    // No precache here – moved to didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Pre-cache background image for instant loading
    precacheImage(const AssetImage('lib/assets/meadow_pattern.jpg'), context);
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
      await _player.play(AssetSource('audio/baa_baa.mp3'));
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
          Container(color: const Color(0xFF81C784)),
          Positioned.fill(
            child: Image.asset(
              'lib/assets/meadow_pattern.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(w, h),
                _buildTitle(w, h, "BAA BAA BLACK SHEEP"),
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
                color: const Color(0xFF8D6E63),
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
                shadows: [
                  Shadow(color: Colors.black26, blurRadius: 4, offset: Offset(1, 1))
                ])),
      );

  Widget _buildLyricsContainer(double w, double h, List<String> lyrics) => Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Container(
            padding: EdgeInsets.all(w * 0.05),
            decoration: BoxDecoration(
                color: const Color(0xDFFFF8E1),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                ]),
            child: SingleChildScrollView(
              child: Column(
                children: lyrics.map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(line,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: w * 0.045,
                              color: const Color(0xFF4E342E),
                              fontWeight: FontWeight.w500)),
                    )).toList(),
              ),
            ),
          ),
        ),
      );

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