import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/apis/apis.dart';
import 'package:vpn_basic_project/main.dart';
import 'package:vpn_basic_project/models/ip_details.dart';
import 'package:vpn_basic_project/models/network_data.dart';
import 'package:vpn_basic_project/widgets/Network_card.dart';

class NetworkTestScreen extends StatelessWidget {
  const NetworkTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ipData = IpDetails.fromJson({}).obs;
    APIs.getIPDetails(ipData: ipData);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Network Test Screen',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),

      // refresh button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            ipData.value = IpDetails.fromJson({});
            APIs.getIPDetails(ipData: ipData);
          },
          child: Icon(
            CupertinoIcons.refresh,
            color: Colors.white,
          ),
        ),
      ),
      // list view
      body: Obx(
        () => ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.only(
              left: mq.width * .04,
              right: mq.width * .04,
              top: mq.height * .01,
              bottom: mq.height * .1),
          children: [
            // IP
            NetworkCard(
                data: NetworkData(
                    title: 'IP Address',
                    subtitle: ipData.value.query,
                    icon: Icon(
                      CupertinoIcons.location_solid,
                      color: Colors.cyan,
                    ))),
            // isp
            NetworkCard(
                data: NetworkData(
                    title: 'Internet Provider',
                    subtitle: ipData.value.isp,
                    icon: Icon(
                      Icons.business_outlined,
                      color: Colors.orange,
                    ))),
            // location
            NetworkCard(
                data: NetworkData(
                    title: 'Location',
                    subtitle: ipData.value.country.isEmpty
                        ? 'Fetching....'
                        : '${ipData.value.city}, ${ipData.value.regionName}, ${ipData.value.country}',
                    icon: Icon(
                      CupertinoIcons.location,
                      color: Colors.pink,
                    ))),
            // pin code
            NetworkCard(
                data: NetworkData(
                    title: 'Pin-Code',
                    subtitle: ipData.value.zip,
                    icon: Icon(
                      Icons.pin_drop_outlined,
                      color: Colors.deepPurpleAccent,
                    ))),
            // Time zoon
            NetworkCard(
                data: NetworkData(
                    title: 'TimeZone',
                    subtitle: ipData.value.timezone,
                    icon: Icon(
                      CupertinoIcons.time,
                      color: Colors.blue,
                    ))),
          ],
        ),
      ),
    );
  }
}
