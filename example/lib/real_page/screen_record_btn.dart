import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ys_play/ys_play.dart';

import '../../../../utils/permission_util.dart';

class ScreenRecordBtn extends StatefulWidget {
  const ScreenRecordBtn({super.key});

  @override
  State<ScreenRecordBtn> createState() => _ScreenRecordBtnState();
}

class _ScreenRecordBtnState extends State<ScreenRecordBtn> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    String recordIcon = 'assets/icon_screen_record.png';
    if (isRecording) recordIcon = 'assets/icon_screen_record2.png';

    return IconButton(
      onPressed: onScreenRecordHandle,
      icon: Image.asset(recordIcon),
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
}
