import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ABCScreen extends StatefulWidget {
  final Map<String, dynamic> poem;
  const ABCScreen({Key? key, required this.poem}) : super(key: key);
  
  @override
  State<ABCScreen> createState() => _ABCScreenState();
}

class _ABCScreenState extends State<ABCScreen> {
  final AudioPlayer _player = AudioPlayer();
  final RxInt currentLineIndex = (-1).obs;
  final RxBool isPlayingLocal = false.obs;

  final List<Duration> lineTimings = [
    Duration(seconds: 0), Duration(seconds: 2), Duration(seconds: 4),
    Duration(seconds: 6), Duration(seconds: 8), Duration(seconds: 10),
  ];

  final List<String> lyrics = [
    "A-B-C-D-E-F-G,",
    "H-I-J-K-L-M-N-O-P,",
    "Q-R-S, T-U-V,",
    "W-X, Y and Z.",
    "Now I know my ABCs,",
    "Next time won't you sing with me?",
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
    // Pre-cache the rainbow overlay image for instant loading
    precacheImage(const AssetImage('lib/assets/rainbow_overlay.jpg'), context);
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
      await _player.play(AssetSource('audio/abc_song.mp3'));
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
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green, Colors.blue, Colors.indigo, Colors.purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          Positioned.fill(
            child: Image.asset(
              'lib/assets/rainbow_overlay.jpg',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(w, h),
                _buildTitle(w, h, "ABC SONG"),
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
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.black87, size: 20),
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
                shadows: [Shadow(color: Colors.black45, blurRadius: 6)])),
      );

  Widget _buildLyricsContainer(double w, double h, List<String> lyrics) =>
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Container(
            padding: EdgeInsets.all(w * 0.05),
            decoration: BoxDecoration(
                color: const Color(0xDFFFFFFF),
                borderRadius: BorderRadius.circular(24)),
            child: SingleChildScrollView(
              child: Column(
                children: lyrics.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String line = entry.value;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Text(line,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: w * 0.045,
                            color: Colors.primaries[idx % Colors.primaries.length],
                            fontWeight: FontWeight.bold)),
                  );
                }).toList(),
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