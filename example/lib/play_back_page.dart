import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ys_play/ys_play.dart';
import 'package:ys_play_example/utils/permission_util.dart';
import 'package:ys_play_example/utils/time_util.dart';

import 'package:ys_play/src/view/ys_player/ys_player.dart';

import 'main.dart';

class PlaybackPage extends StatefulWidget {
  const PlaybackPage({Key? key}) : super(key: key);

  @override
  State<PlaybackPage> createState() => PlaybackPageState();
}

class PlaybackPageState extends State<PlaybackPage> {
  bool isRecording = false;
  late String startDt;
  late String endDt;

  int quarterTurns = 0;

  bool showOtherUI = true;

  GlobalKey<YsPlayerState> ysPlayKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    startDt = TimeUtil.date2Zero(now);
    endDt = TimeUtil.timeFormat(now.millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    String recordIcon = 'assets/icon_screen_record.png';
    if (isRecording) recordIcon = 'assets/icon_screen_record2.png';

    // 截屏和录屏按钮组
    Widget jplpWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onScreenShotHandle,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              'assets/icon_screen_shot.png',
              width: 30,
              height: 30,
            ),
          ),
        ),
        SizedBox(width: 20),
        GestureDetector(
          onTap: onScreenRecordHandle,
          child: Container(
            color: Colors.transparent,
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              recordIcon,
              width: 30,
              height: 30,
            ),
          ),
        ),
      ],
    );

    /// 开始时间
    Widget stWidget = TimeSelector(
      text: 'Starting time',
      time: startDt,
      onSelected: (t) {
        startDt = t;
      },
    );

    /// 结束时间
    Widget etWidget = TimeSelector(
      text: 'End Time',
      time: endDt,
      onSelected: (t) {
        endDt = t;
      },
    );

    /// 回放按钮
    Widget playbackBtn = OutlinedButton(
      onPressed: onPlayback,
      child: Text('Playback'),
    );

    YsPlayer ysPlayer = YsPlayer(
      key: ysPlayKey,
      deviceSerial: deviceSerial,
      verifyCode: verifyCode,
      mediaType: YsMediaType.playback,
      showOtherUI: (show) {
        setState(() {
          showOtherUI = show;
        });
      },
      accessToken: accessToken,
    );

    return showOtherUI
        ? Scaffold(
            appBar: AppBar(title: Text('Playback page')),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ysPlayer,

                  // 截屏和录屏
                  jplpWidget,

                  SizedBox(height: 50),

                  // 开始时间
                  stWidget,

                  SizedBox(height: 10),

                  // 结束时间
                  etWidget,
                  SizedBox(height: 30),

                  // 回放按钮
                  playbackBtn,
                ],
              ),
            ),
          )
        : Scaffold(body: ysPlayer);
  }

  /// 截屏
  void onScreenShotHandle() async {
    PermissionUtils.storage(
      context,
      action: () async {
        bool result = await YsPlay.capturePicture();
        if (result) {
          showToast(
              'The screenshot has been saved to the mobile phone album. Please go to the mobile phone photo album to view it.');
        } else {
          showToast('Screen capture failed');
        }
      },
    );
  }

  /// 录屏
  void onScreenRecordHandle() async {
    PermissionUtils.storage(
      context,
      action: () async {
        if (isRecording) {
          bool result = await YsPlay.stopRecordWithFile();
          if (result) {
            isRecording = false;
            showToast(
                'Screen recording has ended,Please go to the mobile phone album to view the recorded video');
          }
        } else {
          bool result = await YsPlay.startRecordWithFile();
          if (result) {
            isRecording = true;
            showToast(
                'Screen recording in progress...Click again to end screen recording');
          }
        }
        setState(() {});
      },
    );
  }

  /// 回放按钮点击事件
  void onPlayback() {
    if (ysPlayKey.currentState != null) {
      int st = TimeUtil.String2timeStamp(startDt);
      int et = TimeUtil.String2timeStamp(endDt);
      ysPlayKey.currentState!.onRePlay(startTime: st, endTime: et);
    }
  }
}
