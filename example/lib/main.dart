import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pedesxplugin/pedesxplugin.dart' as Pedesxplugin;
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    /**
     * rewardVideoState:
     * -1;不支持的类型
     *  0; 视频加载失败
     *  1; 视频加载成功
     *  2; 视频展示
     *  3; 视频点击关闭
     *  4; 视频播放完成
     *  5; 视频出错
     *  6; 视频跳过
     *  7; 奖励回调
     *  8; 点击视频
     */
    Pedesxplugin.pedesxResponseEventHandler.listen((event) {
      if (event is Pedesxplugin.onRewardResponse) {
        print("激励视频回调：${event.rewardVideoState}");
      }
    });
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Pedesxplugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    Map<Permission, PermissionStatus> statuses = await [
      Permission.phone,
      Permission.location,
      Permission.storage,
    ].request();
    //校验权限
    if (statuses[Permission.location] != PermissionStatus.granted) {
      print("无位置权限");
    }

    _initPedesxSdk();
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  _initPedesxSdk() async {
    /**
     *  初始化SDK
     *  appID:渠道号
     *  shelf_id:任务的货架ID
     *  csjAppId：穿山甲后台的AppID
     *  codeId：穿山甲后台申请的激励视频广告位ID
     */

    await Pedesxplugin.initPedesxSdk(
        appId: "50",
        shelf_id: "f4b005970b3640f4b9e85bddb14d274a",
        csj_appId: "5056758",
        csj_video_id: "945122969",
        welfare_id: "c2fd0cfac5004ac6a39f1745c801a8c4");
  }

  @override
  Widget build(BuildContext context) {
    /**
     * 在拿到用户信息之后，调用此方法
     * 传入用户ID和设备oaid（可传）
     * 此uid需要替换成用户uid
     */
    Pedesxplugin.initPedesxSdkUser(
        uid: "1234567890xjj", //一般为32位
        oaid: "");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Center(
            child: FlatButton(
              onPressed: () {
                Pedesxplugin.startPedesxWelfareActivity();
                // Pedesxplugin.playVideo(video_id: "945122969");
                print("点击了Demo");
              },
              child: Text("点击进入福利中心"),
            ),
          ),
        ),
      ),
    );
  }
}
