import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ys_play/ys_play.dart';
import 'package:ys_play_example/main.dart';

import 'real_page/intercom_btn.dart';
import 'real_page/screen_record_btn.dart';
import 'utils/permission_util.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  /// Biến này dùng để set full screen cho cam
  bool showOtherUI = true;

  // bool isTalking = false;
  // bool isLongPressed = false;
  // int supportTalk = 0;

  // late YsRequestEntity entity;

  // @override
  // void initState() {
  //   super.initState();
  //   Map<String, dynamic> map = {
  //     'accessToken': accessToken,
  //     'deviceSerial': deviceSerial,
  //     'channelNo': cameraNo,
  //     'direction': 0,
  //     'speed': 1,
  //   };
  //   entity = YsRequestEntity.fromJson(map);
  // }

  @override
  Widget build(BuildContext context) {
    // // Nút hình camera ở chính giữa 4 nút điều hướng
    // Widget innerWidget = Image.asset(
    //   'assets/camera.png',
    //   width: 42,
    //   height: 42,
    // );

    // /// Bao gồm các button chụp hình, quay màn hình, ghi âm, lật camera
    // Widget buttonBars = Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //   children: [
    //     Expanded(
    //       child: IconButton(
    //         onPressed: capturePicture,
    //         icon: Image.asset('assets/icon_screen_shot.png'),
    //       ),
    //     ),
    //     Expanded(child: const ScreenRecordBtn()),
    //     Expanded(
    //       child: IntercomBtn(
    //         onIntercom: (isTalking) => onIntercom(isTalking),
    //       ),
    //     ),
    //     Expanded(
    //       child: IconButton(
    //         onPressed: onMirrorReverse,
    //         icon: Image.asset('assets/icon_turn_over.png'),
    //       ),
    //     ),
    //   ],
    // );

    // /// 4 nút điều hướng và nút camera ở giữa
    // Widget bodyWidget = Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   mainAxisSize: MainAxisSize.max,
    //   children: [
    //     PanelView(
    //       onLeftTap: () => onPTZStart(direction: 2),
    //       onRightTap: () => onPTZStart(direction: 3),
    //       onTopTap: () => onPTZStart(direction: 0),
    //       onBottomTap: () => onPTZStart(direction: 1),
    //       innerIcon: innerWidget,
    //       onCanceled: onPTZCancel,
    //       onInnerIconClicked: onInnerIconClicked,
    //     ),
    //     SizedBox(height: 30),
    //     Text(
    //         'Description: Long press the direction key to move the camera, cancel the key to stop'),
    //   ],
    // );

    /// Player hiển thị màn hình camera
    YsPlayer ysPlayer = YsPlayer(
      deviceSerial: deviceSerial,
      verifyCode: verifyCode,
      mediaType: YsMediaType.real,
      showOtherUI: (show) {
        setState(() {
          showOtherUI = show;
        });
      },
      accessToken: accessToken,
    );

    /// Check theo biếm show other ui để hiển thị màn hình ngang/dọc
    return showOtherUI
        ? Scaffold(
            appBar: AppBar(title: Text('Sample page')),
            body: Column(
              children: [
                ysPlayer,
                // buttonBars,
                // Expanded(child: bodyWidget),
              ],
            ),
          )
        : Scaffold(body: ysPlayer);
  }

  // /// Chụp màn hình
  // void capturePicture() async {
  //   PermissionUtils.storage(
  //     context,
  //     action: () async {
  //       bool result = await YsPlay.capturePicture();
  //       if (result) {
  //         showToast(
  //             'The screenshot has been saved to the mobile phone album. Please go to the mobile phone photo album to view it.');
  //       } else {
  //         showToast('Screen capture failed');
  //       }
  //     },
  //   );
  // }

  // /// Lật hình camera
  // void onMirrorReverse() async {
  //   entity.command = 2;
  //   await YsPlay.ptzMirror(entity).then((value) {
  //     if (value.code != '200') {
  //       showToast(value.msg ?? 'Unknown exception');
  //     }
  //   });
  // }

  // /**
  //  * Danh sách tham số điều khiển PTZ
  //  * 1.accessToken,
  //  * 2.deviceSerial,
  //  * 3.channelNo(cameraNo),
  //  * 4.direction:0 lên, 1 xuống, 2 trái, 3 phải, 4 trên trái, 5 dưới trái, 6 trên phải, 7 dưới phải, 8 phóng to, 9 thu nhỏ,
  //   *Tiêu cự 10 gần, tiêu cự 11 xa*
  //  * 5.speed: 0-slow, 1-moderate, 2-fast, các thông số của thiết bị Hikvision không được bằng 0. Mặc định là 1
  //  */
  // void onPTZStart({required int direction}) async {
  //   entity.direction = direction;
  //   // Sau khi khởi động điều khiển PTZ, trước tiên bạn phải gọi giao diện điều khiển Stop PTZ trước khi có thể thực hiện các thao tác khác, bao gồm cả việc xoay PTZ theo các hướng khác.
  //   bool result = await onPTZCancel();
  //   if (result) {
  //     await YsPlay.ptzStart(
  //       deviceSerial: deviceSerial,
  //       channelNo: cameraNo,
  //       accessToken: accessToken,
  //       direction: entity.direction!,
  //     ).then((value) {
  //       if (value.code != '200') {
  //         showToast(value.msg ?? 'Unknown exception');
  //       }
  //     });
  //   }
  // }

  // /// Huỷ
  // Future<bool> onPTZCancel() async {
  //   bool result = false;
  //   await YsPlay.ptzStop(
  //     accessToken: accessToken,
  //     deviceSerial: deviceSerial,
  //     channelNo: cameraNo,
  //     direction: entity.direction,
  //   ).then((value) {
  //     if (value.code == '200') {
  //       result = true;
  //     } else {
  //       showToast(value.msg ?? 'Unknown exception');
  //       result = false;
  //     }
  //   });
  //   return result;
  // }

  // /// Click vào button camera giữa 4 nút điều hướng
  // void onInnerIconClicked() {}

  // /// 对讲 - GOogle dịch là máy liên lạc nội bộ =))
  // void onIntercom(bool isTalking) async {
  //   setState(() {
  //     this.isTalking = isTalking;
  //   });

  //   if (isTalking) {
  //     // Xác định xem hệ thống liên lạc nội bộ có được hỗ trợ hay không
  //     await YsPlay.getDevCapacity(
  //             accessToken: accessToken, deviceSerial: deviceSerial)
  //         .then((res) {
  //       if (res.code == '200' && res.data != null) {
  //         //1-Hoàn toàn 3-Một nửa
  //         if (res.data!.supportTalk == "1" || res.data!.supportTalk == "3") {
  //           supportTalk = int.parse(res.data!.supportTalk!);
  //         } else {
  //           showToast('This device does not support intercom');
  //           supportTalk = 0;
  //         }
  //       } else {
  //         showToast(res.msg ?? 'Unknown exception');
  //         supportTalk = 0;
  //       }
  //     });
  //   } else {
  //     isLongPressed = false;
  //     await YsPlay.stopVoiceTalk();
  //   }
  // }

  // /// Nhấn và giữ để nói
  // void onStartTalk({required isPhone2Dev}) async {
  //   setState(() {
  //     isLongPressed = isPhone2Dev == 1;
  //   });
  //   // Yêu cầu quyền sử dụng micrô
  //   PermissionUtils.microPhone(
  //     context,
  //     action: () async {
  //       await YsPlay.startVoiceTalk(
  //         deviceSerial: deviceSerial,
  //         verifyCode: verifyCode,
  //         isPhone2Dev: isPhone2Dev,
  //         supportTalk: supportTalk,
  //       );
  //     },
  //   );
  // }
}
