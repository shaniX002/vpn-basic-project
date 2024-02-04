import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:vpn_basic_project/controllers/location_controller.dart';
// import 'package:vpn_basic_project/controllers/native_ad_controller.dart';
// import 'package:vpn_basic_project/helpers/ad_helper.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/widgets/vpn_card.dart';

class LocationScreen extends StatelessWidget {
  LocationScreen({Key? key}) : super(key: key);

  final _controller = LocationController();
  // final _adcontroller = NativeAdController();

  @override
  Widget build(BuildContext context) {
    if (_controller.vpnList.isEmpty) _controller.getVpnData();
    return Obx(
      () => Scaffold(
        // app bar
        appBar: AppBar(
          title: Text(
            'VPN Locations (${_controller.vpnList.length})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
        ),

        // bottomNavigationBar:
        //     _adcontroller.ad != null && _adcontroller.adLoaded.isFalse
        //         ? SafeArea(
        //             child: SizedBox(
        //             height: 80,
        //             child: AdWidget(ad: _adcontroller.ad!),
        //           ))
        //         : null,

        // refresh button
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 10),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () => _controller.getVpnData(),
            child: Icon(
              CupertinoIcons.refresh,
              color: Colors.white,
            ),
          ),
        ),
        body: _controller.isloading.value
            ? _loadingWidget()
            : _controller.vpnList.isEmpty
                ? _noVPNFound()
                : _vpnData(),
      ),
    );
  }

  // VPN Data widget
  _vpnData() => ListView.builder(
        itemCount: _controller.vpnList.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
            top: mq.height * .015,
            bottom: mq.height * .1,
            left: mq.width * .04,
            right: mq.width * .04),
        itemBuilder: (ctx, i) => VpnCard(vpn: _controller.vpnList[i]),
      );

  // Loading Widget
  _loadingWidget() => SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  lottie animation
            LottieBuilder.asset(
              'assets/lottie/loading.json',
            ),
            // Text
            Text(
              'Loading VPNs... 🔓',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color.fromARGB(151, 0, 0, 0)),
            )
          ],
        ),
      );

  // No Vpn found widget
  _noVPNFound() => Center(
        child: Text(
          'No VPNs Found! 😫',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color.fromARGB(151, 0, 0, 0)),
        ),
      );
}
