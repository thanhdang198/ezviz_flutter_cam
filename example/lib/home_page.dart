import 'package:flutter/material.dart';
import 'package:ys_play/ys_play.dart';
import 'package:ys_play_example/main.dart';
import 'package:ys_play_example/peiwang/peiwang_page.dart';
import 'package:ys_play_example/play_back_page.dart';
import 'package:ys_play_example/real_page/real_page.dart';
import 'package:ys_play_example/sample_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isPwSuccess = false; //是否配网
  @override
  void initState() {
    super.initState();
    initYsPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('EZVIZ SDK function test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PeiwangPage()),
                );
              },
              child: Text(
                'Distribution network',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PlaybackPage()),
                );
              },
              child: Text(
                'Playback',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RealPage()),
                );
              },
              child: Text(
                'live streaming',
                style: TextStyle(fontSize: 16),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SampleScreen()),
                );
              },
              child: Text(
                'Example',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 初始化萤石SDK
  void initYsPlay() async {
    YsPlay.initSdk(appKey);
  }
}
