import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OldMacDonaldScreen extends StatefulWidget {
  final Map<String, dynamic> poem;
  const OldMacDonaldScreen({Key? key, required this.poem}) : super(key: key);
  
  @override
  State<OldMacDonaldScreen> createState() => _OldMacDonaldScreenState();
}

class _OldMacDonaldScreenState extends State<OldMacDonaldScreen> {
  final AudioPlayer _player = AudioPlayer();
  final RxInt currentLineIndex = (-1).obs;
  final RxBool isPlayingLocal = false.obs;

  final List<Duration> lineTimings = [
    Duration(seconds: 0), Duration(seconds: 3), Duration(seconds: 6),
    Duration(seconds: 9), Duration(seconds: 12), Duration(seconds: 15),
    Duration(seconds: 18), Duration(seconds: 21), Duration(seconds: 24),
  ];

  final List<String> lyrics = [
    "Old MacDonald had a farm, E-I-E-I-O!",
    "And on his farm he had a cow, E-I-E-I-O!",
    "With a moo-moo here and a moo-moo there,",
    "Here a moo, there a moo, everywhere a moo-moo!",
    "Old MacDonald had a farm, E-I-E-I-O!",
    "And on his farm he had a duck, E-I-E-I-O!",
    "With a quack-quack here and a quack-quack there,",
    "Here a quack, there a quack, everywhere a quack-quack!",
    "With a moo-moo here and a moo-moo there,",
    "Here a moo, there a moo, everywhere a moo-moo!",
    "Old MacDonald had a farm, E-I-E-I-O!",
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
    precacheImage(const AssetImage('lib/assets/barn_background.jpg'), context);
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
      await _player.play(AssetSource('audio/old_macdonald.mp3'));
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
          Container(color: const Color(0xFFF5DEB3)),
          Positioned.fill(
            child: Image.asset(
              'lib/assets/barn_background.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(w, h),
                _buildTitle(w, h, "OLD MACDONALD HAD A FARM"),
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
                color: const Color(0xFFA1887F),
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
                color: const Color(0xFF5D4037))),
      );

  Widget _buildLyricsContainer(double w, double h, List<String> lyrics) =>
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Container(
            padding: EdgeInsets.all(w * 0.05),
            decoration: BoxDecoration(
                color: const Color(0xDFFFF3E0),
                borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                children: lyrics.map((line) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(line,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: w * 0.045,
                              color: const Color(0xFF4E2E1E),
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
              child: const Icon(Icons.replay, size: 40, color: Color(0xFF8D6E63))),
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
                size: 50, color: const Color(0xFF8D6E63)),
          ),
          const SizedBox(width: 30),
          GestureDetector(
              onTap: stopAll,
              child: const Icon(Icons.stop, size: 40, color: Color(0xFF8D6E63))),
        ],
      ));
}