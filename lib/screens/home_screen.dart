import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/controllers/home_controller.dart';
import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/helpers/pref.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/vpn_status.dart';
import 'package:vpn_basic_project/screens/location_screen.dart';
import 'package:vpn_basic_project/screens/network_test_screen.dart';
import 'package:vpn_basic_project/widgets/count_down_timer.dart';
import 'package:vpn_basic_project/widgets/home_card.dart';
import 'package:vpn_basic_project/widgets/watch_ad_dialog.dart';
import '../services/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    ///Add listener to update vpn state
    VpnEngine.vpnStageSnapshot().listen((event) {
      _controller.vpnState.value = event;
    });

    return Scaffold(
      // app bar
      appBar: AppBar(
        title: Text(
          'Vpn X',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        leading: Icon(
          CupertinoIcons.home,
        ),
        actions: [
          IconButton(
              onPressed: () {
                //ad dialog
                Get.dialog(WatchAdDialog(
                  onComplete: () {
                    // watch ads to gain reward
                    AdHelper.showRewardedAd(onComplete: () {
                      Get.changeThemeMode(
                          Pref.isDarkMode ? ThemeMode.light : ThemeMode.dark);
                      Pref.isDarkMode = !Pref.isDarkMode;
                    });
                  },
                ));
              },
              icon: Icon(
                Icons.brightness_2_outlined,
                size: 26,
              )),
          IconButton(
              padding: EdgeInsets.only(right: 16),
              onPressed: () => Get.to(() => NetworkTestScreen()),
              icon: Icon(
                CupertinoIcons.info,
                size: 26,
              )),
        ],
        backgroundColor: Theme.of(context).primaryColor,
      ),

      bottomNavigationBar: _changeLocation(context),

      // body
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          // adding some space
          SizedBox(
            height: mq.height * .03,
            width: double.maxFinite,
          ),
          // vpn button
          Obx(() => _vpnButton()),

          // adding some space
          SizedBox(
            height: mq.height * .03,
          ),

          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // country flag
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? 'Country'
                        : _controller.vpn.value.countryLong,
                    subtile: 'FREE',
                    icon: CircleAvatar(
                      backgroundColor: Colors.cyan.shade300,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: _controller.vpn.value.countryLong.isEmpty
                          ? Icon(Icons.vpn_lock_rounded)
                          : null,
                      backgroundImage: _controller.vpn.value.countryLong.isEmpty
                          ? null
                          : AssetImage(
                              'assets/flags/${_controller.vpn.value.countryShort.toLowerCase()}.png'),
                    )),
                // ping time
                HomeCard(
                    title: _controller.vpn.value.countryLong.isEmpty
                        ? '100 ms'
                        : '${_controller.vpn.value.ping} ms',
                    subtile: 'PING',
                    icon: CircleAvatar(
                      backgroundColor: Colors.pinkAccent.shade200,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Icon(Icons.equalizer),
                    )),
              ],
            ),
          ),
          // adding some space
          SizedBox(
            height: mq.height * .04,
          ),
          // stream builder
          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.vpnStatusSnapshot(),
              builder: (context, snapshot) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // download
                      HomeCard(
                          title: '${snapshot.data?.byteIn ?? '0 kbps'}',
                          subtile: 'DOWNLOAD',
                          icon: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Icon(CupertinoIcons.download_circle),
                          )),
                      // upload
                      HomeCard(
                          title: '${snapshot.data?.byteOut ?? '0 kbps'}',
                          subtile: 'UPLOAD',
                          icon: CircleAvatar(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Icon(CupertinoIcons.upload_circle),
                          )),
                    ],
                  )),
        ]),
      ),
    );
  }

  // vpn button
  Widget _vpnButton() => Column(
        children: [
          // vpn button
          Semantics(
            button: true,
            child: InkWell(
              onTap: () {
                _controller.connectToVpn();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _controller.getButtonColor.withOpacity(.15)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _controller.getButtonColor.withOpacity(.3)),
                  child: Container(
                    width: mq.height * .17,
                    height: mq.height * .17,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _controller.getButtonColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.power,
                          size: 35,
                          color: Colors.white,
                        ),
                        Text(
                          _controller.getButtonText,
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            margin:
                EdgeInsets.only(top: mq.height * .02, bottom: mq.height * .03),
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 9),
            decoration: BoxDecoration(
                color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
            child: Text(
              _controller.vpnState.value == VpnEngine.vpnDisconnected
                  ? 'Disconnect'
                  : _controller.vpnState.replaceAll('_', ' ').toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),

          // count down timer
          Obx(() => CountDownTimer(
              startTimer:
                  _controller.vpnState.value == VpnEngine.vpnConnected)),
        ],
      );

  Widget _changeLocation(BuildContext context) => SafeArea(
        child: Semantics(
          button: true,
          child: InkWell(
            onTap: () => Get.to(() => LocationScreen()),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: mq.width * .06),
              color: Theme.of(context).bottonNav,
              height: 60,
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.globe,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Change Location',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.cyan,
                      size: 28,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
