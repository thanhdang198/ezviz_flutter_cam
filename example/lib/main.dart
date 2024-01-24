import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:ys_play_example/home_page.dart';

String appKey = '277853a54e91468f8c87bc29db46449f';
String accessToken =
    'at.af0q6yejccreg1ys1mjaowlcc6kor8mh-77d9eic86m-0vxtumr-gemkekkzb';
String deviceSerial = 'F23186035';
String verifyCode = '';
int cameraNo = 1;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
